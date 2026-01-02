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
      for (final p in rule.split(';')) p.split('=').first: p.split('=').last,
    };

    final String? freq = parts['FREQ'];
    final int? count = int.tryParse(parts['COUNT'] ?? '');
    final DateTime? until = parts['UNTIL'] != null
        ? DateTime.parse(parts['UNTIL']!)
        : null;

    final DateTime baseDate = info.date;
    final DateTime cursorStart = start ?? baseDate;

    final Duration? duration = (start != null && end != null)
        ? end.difference(start)
        : null;

    final List<EventCacheInstanceModel> out = [];

    DateTime cursor = cursorStart;
    int generated = 0;

    while (true) {
      if (count != null && generated >= count) break;
      if (until != null && cursor.isAfter(until)) break;
      if (generated >= maxInstances) break;

      out.add(
        EventCacheInstanceModel(
          eventInfoId: info.id!,
          date: _startOfDay(cursor),
          start: start != null ? cursor : null,
          end: duration != null ? cursor.add(duration) : null,
        ),
      );

      generated++;

      switch (freq) {
        case 'SECONDLY':
          cursor = cursor.add(const Duration(seconds: 1));
        case 'MINUTELY':
          cursor = cursor.add(const Duration(minutes: 1));
        case 'HOURLY':
          cursor = cursor.add(const Duration(hours: 1));
        case 'DAILY':
          cursor = cursor.add(const Duration(days: 1));
        case 'WEEKLY':
          cursor = cursor.add(const Duration(days: 7));
        case 'MONTHLY':
          cursor = DateTime(
            cursor.year,
            cursor.month + 1,
            cursor.day,
            cursor.hour,
            cursor.minute,
          );
        case 'YEARLY':
          cursor = DateTime(
            cursor.year + 1,
            cursor.month,
            cursor.day,
            cursor.hour,
            cursor.minute,
          );
        default:
          return out;
      }
    }

    return out;
  }
}
