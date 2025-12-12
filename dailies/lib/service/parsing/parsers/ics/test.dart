import 'package:dailies/common/enums/days_of_the_week.dart';
import 'package:dailies/common/utils/parser_helpers.dart';
import 'package:dailies/service/parsing/parsers/ics/rrule%20parser/recurrance_pattern.dart';

void main() {
  print('Testing RRULE Implementation with EXDATE support\n');

  // Example with EXDATE (simulating your university schedule)
  print('1. Weekly class with holiday exclusions:');

  // Simulate the university schedule RRULE
  final classPattern = RecurrencePattern.fromRRule(
    'FREQ=WEEKLY;UNTIL=20251205T095000;BYDAY=MO,WE,FR',
    excludeDates: [
      DateTime(2025, 9, 30), // Sept 30 - excluded
      DateTime(2025, 10, 13), // Oct 13 - excluded
      DateTime(2025, 11, 11), // Nov 11 - excluded
      DateTime(2025, 11, 13), // Nov 13 - excluded
      DateTime(2025, 11, 14), // Nov 14 - excluded
      DateTime(2025, 11, 15), // Nov 15 - excluded
    ],
  );

  final start = DateTime(2025, 9, 3); // Sept 3, 2025 (Wednesday)
  final classOccurrences = classPattern.generateOccurrences(
    start,
    maxCount: 15,
  );

  print('Class schedule (first 15 occurrences):');
  for (final date in classOccurrences) {
    final dayName = DaysOfTheWeek.fromDateTime(date).name;
    print('  ${date.toIso8601String().split('T')[0]} ($dayName)');
  }

  final Map<DaysOfTheWeek, DateTime> anchorPointMap = {
    for (final DateTime date in classOccurrences.reversed)
      DaysOfTheWeek.fromDateTime(date): date,
  };
  print(anchorPointMap);

  // Example 2: Every weekday for 10 days
  print('\n2. Every weekday for 10 days:');
  final weekdayPattern = RecurrencePattern.fromRRule(
    'FREQ=DAILY;BYDAY=MO,TU,WE,TH,FR;COUNT=10',
  );

  final start2 = DateTime(2025, 8, 4); // Monday, Aug 4, 2025
  final weekdayOccurrences = weekdayPattern.generateOccurrences(start2);
  for (final date in weekdayOccurrences) {
    print(
      '  ${date.toIso8601String().split('T')[0]} (${DaysOfTheWeek.fromDateTime(date).name})',
    );
  }

  // Example 3: With exclusions
  print('\n3. Daily pattern with specific exclusions:');
  final dailyWithExclusions = RecurrencePattern.fromRRule(
    'FREQ=DAILY;COUNT=10',
    excludeDates: [
      DateTime(2025, 8, 6), // Skip Wednesday
      DateTime(2025, 8, 10), // Skip Sunday
    ],
  );

  final excludedOccurrences = dailyWithExclusions.generateOccurrences(start2);
  for (final date in excludedOccurrences) {
    print(
      '  ${date.toIso8601String().split('T')[0]} (${DaysOfTheWeek.fromDateTime(date).name})',
    );
  }

  // Example 4: Parsing EXDATE from ICS-style lines
  print('\n4. Parsing EXDATE from ICS format:');
  final exDateLines = [
    'EXDATE;TZID=MST:20250930T090000',
    'EXDATE;TZID=MST:20251013T090000',
    'EXDATE;TZID=MST:20251111T090000',
  ];

  final parsedExDates = parseExclusionDates(exDateLines);
  print('Parsed exclude dates:');
  for (final exDate in parsedExDates) {
    print('  ${exDate.toIso8601String().split('T')[0]}');
  }
}
