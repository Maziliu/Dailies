import 'package:dailies/service/parsers/ics/rrule%20parser/recurrance_pattern.dart';

List<DateTime> parseExclusionDates(List<String> exDateLines) {
  final excludeDates = <DateTime>[];

  for (String line in exDateLines) {
    if (line.toUpperCase().startsWith('EXDATE')) {
      final colonIndex = line.indexOf(':');
      if (colonIndex != -1) {
        final dateString = line.substring(colonIndex + 1);
        try {
          excludeDates.add(RecurrencePattern.parseUntilTagValue(dateString));
        } catch (e) {
          print('Warning: Could not parse EXDATE: $line');
        }
      }
    }
  }

  return excludeDates;
}
