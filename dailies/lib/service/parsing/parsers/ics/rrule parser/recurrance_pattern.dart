import 'package:dailies/common/enums/days_of_the_week.dart';
import 'package:dailies/common/enums/rrule_frequency.dart';
import 'package:dailies/common/utils/parser_helpers.dart';
import 'package:dailies/service/parsing/parsers/ics/rrule%20parser/by_day_rule.dart';

const int ITERATION_LIMIT = 10000;

class RecurrencePattern {
  final String originalRRule;
  final Map<String, String> parsedRules;
  final RRuleFrequency frequency;
  final int interval;
  final int? count;
  final DateTime? until;
  final List<ByDayRule>? byDay;
  final List<int>? byMonthDay;
  final List<int>? byMonth;
  final List<int>? byHour;
  final List<int>? byMinute;
  final List<int>? bySecond;
  final DaysOfTheWeek weekStart;
  final List<DateTime> excludeDates;

  RecurrencePattern._({
    required this.originalRRule,
    required this.parsedRules,
    required this.frequency,
    required this.interval,
    this.count,
    this.until,
    this.byDay,
    this.byMonthDay,
    this.byMonth,
    this.byHour,
    this.byMinute,
    this.bySecond,
    this.weekStart = DaysOfTheWeek.Monday,
    this.excludeDates = const [],
  });

  factory RecurrencePattern.fromRRule(String rrule, {List<DateTime>? excludeDates}) {
    final parsedRules = _parseRRule(rrule);

    if (!parsedRules.containsKey('FREQ')) {
      throw ArgumentError('RRULE must contain FREQ parameter');
    }

    if (parsedRules.containsKey('COUNT') && parsedRules.containsKey('UNTIL')) {
      throw ArgumentError('RRULE cannot contain both COUNT and UNTIL');
    }

    final frequency = RRuleFrequency.fromString(parsedRules['FREQ']!);
    final interval = int.tryParse(parsedRules['INTERVAL'] ?? '1') ?? 1;
    final count = parsedRules.containsKey('COUNT') ? int.tryParse(parsedRules['COUNT']!) : null;
    final until = parsedRules.containsKey('UNTIL') ? parseDateString(parsedRules['UNTIL']!) : null;

    List<ByDayRule>? byDay;
    if (parsedRules.containsKey('BYDAY')) {
      byDay = ByDayRule.parse(parsedRules['BYDAY']!);
    }

    List<int>? byMonthDay;
    if (parsedRules.containsKey('BYMONTHDAY')) {
      byMonthDay = parsedRules['BYMONTHDAY']!.split(',').map((String day) => int.parse(day.trim())).toList();
    }

    List<int>? byMonth;
    if (parsedRules.containsKey('BYMONTH')) {
      byMonth = parsedRules['BYMONTH']!.split(',').map((String month) => int.parse(month.trim())).toList();
    }

    List<int>? byHour;
    if (parsedRules.containsKey('BYHOUR')) {
      byHour = parsedRules['BYHOUR']!.split(',').map((String hour) => int.parse(hour.trim())).toList();
    }

    List<int>? byMinute;
    if (parsedRules.containsKey('BYMINUTE')) {
      byMinute = parsedRules['BYMINUTE']!.split(',').map((String minute) => int.parse(minute.trim())).toList();
    }

    List<int>? bySecond;
    if (parsedRules.containsKey('BYSECOND')) {
      bySecond = parsedRules['BYSECOND']!.split(',').map((String second) => int.parse(second.trim())).toList();
    }

    DaysOfTheWeek weekStart = DaysOfTheWeek.Monday;
    if (parsedRules.containsKey('WKST')) {
      weekStart = DaysOfTheWeek.fromIcalCode(parsedRules['WKST']!);
    }

    return RecurrencePattern._(
      originalRRule: rrule,
      parsedRules: parsedRules,
      frequency: frequency,
      interval: interval,
      count: count,
      until: until,
      byDay: byDay,
      byMonthDay: byMonthDay,
      byMonth: byMonth,
      byHour: byHour,
      byMinute: byMinute,
      bySecond: bySecond,
      weekStart: weekStart,
      excludeDates: excludeDates ?? [],
    );
  }

  static Map<String, String> _parseRRule(String rrule) {
    final Map<String, String> rules = {};

    for (final String pair in rrule.split(';')) {
      final values = pair.split('=');
      if (values.length == 2) {
        rules[values[0].trim().toUpperCase()] = values[1].trim();
      }
    }

    return rules;
  }

  bool _isSameNormalizedDay(DateTime first, DateTime second) {
    return first.year == second.year && first.month == second.month && first.day == second.day;
  }

  List<DateTime> generateOccurrences(DateTime start, {int? maxCount}) {
    final occurrences = <DateTime>[];
    DateTime current = start;
    int generatedCount = 0;
    int iterations = 0;

    final int effectiveMaxCount = maxCount ?? count ?? 100;

    //Always include the start date if it matches and isn't excluded
    if (_matchesRule(current, start) && !_isExcluded(current)) {
      occurrences.add(current);
      generatedCount++;
    }

    while (generatedCount < effectiveMaxCount && iterations < ITERATION_LIMIT) {
      iterations++;
      current = current.add(const Duration(days: 1));

      if (until != null && current.isAfter(until!)) break;

      if (_matchesRule(current, start) && !_isExcluded(current)) {
        occurrences.add(current);
        generatedCount++;

        if (count != null && generatedCount >= count!) break;
      }

      if (iterations >= ITERATION_LIMIT) break;
    }

    return occurrences;
  }

  bool _isExcluded(DateTime date) => excludeDates.any((exDate) => _isSameNormalizedDay(date, exDate));

  bool _matchesRule(DateTime date, DateTime start) {
    //BYMONTH
    if (byMonth != null && !byMonth!.contains(date.month)) {
      return false;
    }

    //BYMONTHDAY
    if (byMonthDay != null) {
      bool matchesMonthDay = false;
      for (final int day in byMonthDay!) {
        if (day > 0 && date.day == day) {
          matchesMonthDay = true;
          break;
        } else if (day < 0) {
          //Negative means count from end of month
          final lastDay = DateTime(date.year, date.month + 1, 0).day;
          if (date.day == lastDay + day + 1) {
            matchesMonthDay = true;
            break;
          }
        }
      }
      if (!matchesMonthDay) return false;
    }

    //BYDAY
    if (byDay != null) {
      bool matchesByDay = false;
      for (final ByDayRule rule in byDay!) {
        if (_matchesByDayRule(date, rule)) {
          matchesByDay = true;
          break;
        }
      }
      if (!matchesByDay) return false;
    }

    //BYHOUR
    if (byHour != null && !byHour!.contains(date.hour)) {
      return false;
    }

    //BYMINUTE
    if (byMinute != null && !byMinute!.contains(date.minute)) {
      return false;
    }

    //BYSECOND
    if (bySecond != null && !bySecond!.contains(date.second)) {
      return false;
    }

    return _matchesFrequencyInterval(date, start);
  }

  bool _matchesByDayRule(DateTime date, ByDayRule rule) {
    if (DaysOfTheWeek.fromDateTime(date) != rule.weekday) {
      return false;
    }

    if (rule.position == null) {
      return true;
    }

    switch (frequency) {
      case RRuleFrequency.Monthly:
        return _matchesMonthlyPosition(date, rule.position!);
      case RRuleFrequency.Yearly:
        return _matchesYearlyPosition(date, rule.position!);
      default:
        return true;
    }
  }

  bool _matchesMonthlyPosition(DateTime date, int position) {
    final targetWeekday = DaysOfTheWeek.fromDateTime(date);

    if (position > 0) {
      DateTime firstOfMonth = DateTime(date.year, date.month);
      while (DaysOfTheWeek.fromDateTime(firstOfMonth) != targetWeekday) {
        firstOfMonth = firstOfMonth.add(const Duration(days: 1));
        if (firstOfMonth.month != date.month) {
          return false;
        }
      }

      final nthOccurrence = DateTime(date.year, date.month, firstOfMonth.day + (position - 1) * 7);
      return nthOccurrence.month == date.month && nthOccurrence.day == date.day;
    } else {
      DateTime lastOfMonth = DateTime(date.year, date.month + 1, 0);
      while (DaysOfTheWeek.fromDateTime(lastOfMonth) != targetWeekday) {
        lastOfMonth = lastOfMonth.subtract(const Duration(days: 1));
        if (lastOfMonth.month != date.month) {
          return false;
        }
      }

      final nthFromLastOccurrence = DateTime(date.year, date.month, lastOfMonth.day + (position + 1) * 7);
      return nthFromLastOccurrence.month == date.month && nthFromLastOccurrence.day >= 1 && nthFromLastOccurrence.day == date.day;
    }
  }

  bool _matchesYearlyPosition(DateTime date, int position) {
    return _matchesMonthlyPosition(date, position);
  }

  bool _matchesFrequencyInterval(DateTime date, DateTime start) {
    switch (frequency) {
      case RRuleFrequency.Daily:
        final daysDiff = date.difference(start).inDays;
        return daysDiff >= 0 && daysDiff % interval == 0;

      case RRuleFrequency.Weekly:
        final daysDiff = date.difference(start).inDays;
        final weeksDiff = daysDiff ~/ 7;

        if (byDay != null) {
          return weeksDiff >= 0 && weeksDiff % interval == 0;
        } else {
          return weeksDiff >= 0 && weeksDiff % interval == 0 && date.weekday == start.weekday;
        }

      case RRuleFrequency.Monthly:
        final monthsDiff = (date.year - start.year) * 12 + (date.month - start.month);
        return monthsDiff >= 0 && monthsDiff % interval == 0;

      case RRuleFrequency.Yearly:
        final yearsDiff = date.year - start.year;
        return yearsDiff >= 0 && yearsDiff % interval == 0;
    }
  }

  String toRRule() => originalRRule;

  @override
  String toString() {
    return 'RecurrencePattern(frequency: $frequency, interval: $interval, '
        'count: $count, until: $until, byDay: $byDay, excludeDates: ${excludeDates.length})';
  }
}
