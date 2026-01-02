import 'package:dailies_v2/enums/event_type.dart';
import 'package:dailies_v2/models/event.dart';

abstract class RRuleEventGenerator {
  static List<EventCacheInstanceModel> generateInstances(EventInfoModel info) {
    final DateTime anchor = _startOfDay(info.date);
    final DateTime? start = info.start;
    final DateTime? end = info.end;

    switch (info.type) {
      case EventType.DEADLINE:
      case EventType.INTERVAL:
      case EventType.UNDEFINED:
      case EventType.INDEFINITE:
        return [
          EventCacheInstanceModel(
            eventInfoId: info.id!,
            date: anchor,
            start: start,
            end: end,
          ),
        ];

      case EventType.MULTI_DAY:
        return _expandMultiDay(info, start, end);

      case EventType.REACCURING:
        return expandRecurring(info, start, end);
    }
  }

  static DateTime _startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);

  static List<EventCacheInstanceModel> _expandMultiDay(
    EventInfoModel info,
    DateTime? start,
    DateTime? end,
  ) {
    if (end == null) return [];

    final DateTime firstDay = _startOfDay(start ?? info.date);
    final DateTime lastDay = _startOfDay(end);

    final List<EventCacheInstanceModel> out = [];

    DateTime cursor = firstDay;
    while (!cursor.isAfter(lastDay)) {
      out.add(
        EventCacheInstanceModel(
          eventInfoId: info.id!,
          date: cursor,
          start: start != null ? cursor : null,
          end: start != null ? cursor.add(const Duration(days: 1)) : null,
        ),
      );
      cursor = cursor.add(const Duration(days: 1));
    }

    return out;
  }

  static List<EventCacheInstanceModel> expandRecurring(
    EventInfoModel info,
    DateTime? start,
    DateTime? end, {
    int maxInstances = 100,
  }) {
    final String rule = info.rrule!;
    final parts = {
      for (final p in rule.split(';'))
        if (p.contains('=')) p.split('=').first: p.split('=').last,
    };

    final String? freq = parts['FREQ'];
    final int interval = int.tryParse(parts['INTERVAL'] ?? '1') ?? 1;
    final int? count = int.tryParse(parts['COUNT'] ?? '');

    DateTime? until;
    if (parts['UNTIL'] != null) {
      final untilStr = parts['UNTIL']!;
      try {
        if (untilStr.contains('T')) {
          until = DateTime.parse(
            '${untilStr.substring(0, 4)}-${untilStr.substring(4, 6)}-${untilStr.substring(6, 8)}T'
            '${untilStr.substring(9, 11)}:${untilStr.substring(11, 13)}:${untilStr.substring(13, 15)}',
          );
        } else {
          until = DateTime.parse(
            '${untilStr.substring(0, 4)}-${untilStr.substring(4, 6)}-${untilStr.substring(6, 8)}',
          );
        }
      } catch (e) {
        print('Failed to parse UNTIL date: $untilStr');
      }
    }

    final List<String>? byDay = parts['BYDAY']?.split(',');
    final List<int>? byMonthDay = parts['BYMONTHDAY']
        ?.split(',')
        .map((d) => int.tryParse(d))
        .whereType<int>()
        .toList();

    final List<int>? byMonth = parts['BYMONTH']
        ?.split(',')
        .map((m) => int.tryParse(m))
        .whereType<int>()
        .toList();

    final DateTime baseDate = start ?? info.date;
    final Duration? duration = (start != null && end != null)
        ? end.difference(start)
        : null;

    final List<EventCacheInstanceModel> out = [];

    if (freq == 'WEEKLY' && byDay != null && byDay.isNotEmpty) {
      DateTime cursor = baseDate;
      int generated = 0;

      while (generated < maxInstances) {
        if (count != null && generated >= count) break;
        if (until != null && cursor.isAfter(until)) break;

        if (_matchesByDaySimple(cursor, byDay)) {
          out.add(
            EventCacheInstanceModel(
              eventInfoId: info.id!,
              date: _startOfDay(cursor),
              start: start != null
                  ? DateTime(
                      cursor.year,
                      cursor.month,
                      cursor.day,
                      baseDate.hour,
                      baseDate.minute,
                      baseDate.second,
                    )
                  : null,
              end: duration != null
                  ? DateTime(
                      cursor.year,
                      cursor.month,
                      cursor.day,
                      baseDate.hour,
                      baseDate.minute,
                      baseDate.second,
                    ).add(duration)
                  : null,
            ),
          );
          generated++;
        }

        cursor = cursor.add(const Duration(days: 1));

        if (cursor.weekday == baseDate.weekday && interval > 1) {
          cursor = cursor.add(Duration(days: 7 * (interval - 1)));
        }

        if (cursor.year > 2100) break;
      }
    } else {
      DateTime cursor = baseDate;
      int generated = 0;
      int iterations = 0;
      final int maxIterations = maxInstances * 1000;

      while (iterations < maxIterations) {
        iterations++;

        if (count != null && generated >= count) break;
        if (until != null && cursor.isAfter(until)) break;
        if (generated >= maxInstances) break;

        bool matches = true;

        if (byMonth != null && !byMonth.contains(cursor.month)) {
          matches = false;
        }

        if (matches && byMonthDay != null) {
          final int day = cursor.day;
          final int daysInMonth = DateTime(
            cursor.year,
            cursor.month + 1,
            0,
          ).day;

          bool dayMatches = false;
          for (final md in byMonthDay) {
            if (md > 0 && day == md) {
              dayMatches = true;
              break;
            } else if (md < 0 && day == daysInMonth + md + 1) {
              dayMatches = true;
              break;
            }
          }
          matches = dayMatches;
        }

        if (matches && byDay != null && byDay.isNotEmpty) {
          matches = _matchesByDay(cursor, byDay, freq);
        }

        if (matches) {
          out.add(
            EventCacheInstanceModel(
              eventInfoId: info.id!,
              date: _startOfDay(cursor),
              start: start != null ? cursor : null,
              end: duration != null ? cursor.add(duration) : null,
            ),
          );
          generated++;
        }

        cursor = _advanceCursor(cursor, freq, interval);

        if (cursor.year > 2100) break;
      }
    }

    return out;
  }

  static bool _matchesByDaySimple(DateTime date, List<String> byDay) {
    final int weekday = date.weekday; // 1=Monday, 7=Sunday

    for (final day in byDay) {
      final dayAbbr = day.trim();
      final targetWeekday = _weekdayFromAbbr(dayAbbr);

      if (weekday == targetWeekday) return true;
    }

    return false;
  }

  static DateTime _advanceCursor(DateTime cursor, String? freq, int interval) {
    switch (freq) {
      case 'SECONDLY':
        return cursor.add(Duration(seconds: interval));
      case 'MINUTELY':
        return cursor.add(Duration(minutes: interval));
      case 'HOURLY':
        return cursor.add(Duration(hours: interval));
      case 'DAILY':
        return cursor.add(Duration(days: interval));
      case 'WEEKLY':
        return cursor.add(Duration(days: 7 * interval));
      case 'MONTHLY':
        int newMonth = cursor.month + interval;
        int newYear = cursor.year;
        while (newMonth > 12) {
          newMonth -= 12;
          newYear++;
        }
        final daysInNewMonth = DateTime(newYear, newMonth + 1, 0).day;
        final newDay = cursor.day > daysInNewMonth
            ? daysInNewMonth
            : cursor.day;
        return DateTime(
          newYear,
          newMonth,
          newDay,
          cursor.hour,
          cursor.minute,
          cursor.second,
        );
      case 'YEARLY':
        final daysInMonth = DateTime(
          cursor.year + interval,
          cursor.month + 1,
          0,
        ).day;
        final newDay = cursor.day > daysInMonth ? daysInMonth : cursor.day;
        return DateTime(
          cursor.year + interval,
          cursor.month,
          newDay,
          cursor.hour,
          cursor.minute,
          cursor.second,
        );
      default:
        return cursor.add(const Duration(days: 1));
    }
  }

  static bool _matchesByDay(DateTime date, List<String> byDay, String? freq) {
    final int weekday = date.weekday;

    for (final day in byDay) {
      final match = RegExp(r'^(-?\d+)?([A-Z]{2})$').firstMatch(day.trim());
      if (match == null) continue;

      final String? posStr = match.group(1);
      final String dayAbbr = match.group(2)!;

      final int targetWeekday = _weekdayFromAbbr(dayAbbr);

      if (posStr == null) {
        if (weekday == targetWeekday) return true;
      } else {
        final int position = int.parse(posStr);

        if (freq == 'MONTHLY') {
          if (_isNthWeekdayOfMonth(date, targetWeekday, position)) {
            return true;
          }
        } else if (freq == 'YEARLY') {
          if (_isNthWeekdayOfYear(date, targetWeekday, position)) {
            return true;
          }
        }
      }
    }

    return false;
  }

  static int _weekdayFromAbbr(String abbr) {
    switch (abbr) {
      case 'MO':
        return 1;
      case 'TU':
        return 2;
      case 'WE':
        return 3;
      case 'TH':
        return 4;
      case 'FR':
        return 5;
      case 'SA':
        return 6;
      case 'SU':
        return 7;
      default:
        return 1;
    }
  }

  static bool _isNthWeekdayOfMonth(
    DateTime date,
    int targetWeekday,
    int position,
  ) {
    if (date.weekday != targetWeekday) return false;

    if (position > 0) {
      int occurrences = 0;

      for (int day = 1; day <= date.day; day++) {
        final current = DateTime(date.year, date.month, day);
        if (current.weekday == targetWeekday) {
          occurrences++;
        }
      }

      return occurrences == position;
    } else {
      final lastOfMonth = DateTime(date.year, date.month + 1, 0);
      int occurrences = 0;

      for (int day = lastOfMonth.day; day >= date.day; day--) {
        final current = DateTime(date.year, date.month, day);
        if (current.weekday == targetWeekday) {
          occurrences++;
        }
      }

      return occurrences == -position;
    }
  }

  static bool _isNthWeekdayOfYear(
    DateTime date,
    int targetWeekday,
    int position,
  ) {
    if (date.weekday != targetWeekday) return false;

    if (position > 0) {
      int occurrences = 0;
      final startOfYear = DateTime(date.year, 1, 1);

      for (int day = 0; day <= date.difference(startOfYear).inDays; day++) {
        final current = startOfYear.add(Duration(days: day));
        if (current.weekday == targetWeekday) {
          occurrences++;
        }
      }

      return occurrences == position;
    } else {
      int occurrences = 0;
      final endOfYear = DateTime(date.year, 12, 31);

      for (int day = endOfYear.difference(date).inDays; day >= 0; day--) {
        final current = date.add(Duration(days: day));
        if (current.weekday == targetWeekday) {
          occurrences++;
        }
      }

      return occurrences == -position;
    }
  }
}
