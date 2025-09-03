import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/data/models/time_slot_pattern.dart';
import 'package:dailies/service/parsing/parsers/ics/rrule%20parser/recurrance_pattern.dart';
import 'package:table_calendar/table_calendar.dart';

List<TimeSlot> generateTimeSlots(TimeSlotPattern pattern, {int limitInDays = 365}) =>
    (pattern.hasRecurranceRule) ? _generateFromRecurranceRule(pattern, limitInDays) : _generateFromParameters(pattern, limitInDays);

List<TimeSlot> _generateFromParameters(TimeSlotPattern pattern, int limitInDays) {
  final List<TimeSlot> timeSlots = [...pattern.anchorPointsList];

  if (pattern.isReacurring) {
    final DateTime limit = normalizeDate(DateTime.now()).add(Duration(days: limitInDays + 1));
    final Duration patternFrequency = pattern.frequency!;
    final Duration totalOffset = patternFrequency;

    for (final TimeSlot timeSlot in pattern.anchorPointsList) {
      final DateTime currentDate = normalizeDate(timeSlot.dateOfTimeSlot);
      int offsetCount = 1;

      while (true) {
        final Duration currentOffset = totalOffset * offsetCount;
        final DateTime nextDate = currentDate.toUtc().add(currentOffset);
        print(normalizeDate(nextDate));

        if (nextDate.isAfter(limit) || (pattern.isFinite && nextDate.isAfter(pattern.endPatternDate!))) {
          break;
        }

        timeSlots.add(TimeSlot.UnSaved(dateOfTimeSlot: normalizeDate(nextDate), startTime: timeSlot.startTime, endTime: timeSlot.endTime));

        offsetCount++;
      }
    }
  }

  return timeSlots;
}

List<TimeSlot> _generateFromRecurranceRule(TimeSlotPattern pattern, int limit) {
  final RecurrencePattern rrulePattern = RecurrencePattern.fromRRule(pattern.recurranceRule!);
  final TimeSlot reference = pattern.anchorPointsList.first;

  final List<DateTime> timeSlotDates = rrulePattern.generateOccurrences(reference.dateOfTimeSlot, maxCount: limit);

  print(pattern.recurranceRule);
  print(timeSlotDates.length);

  return timeSlotDates.map((DateTime date) => TimeSlot.UnSaved(dateOfTimeSlot: date, startTime: reference.startTime, endTime: reference.endTime)).toList();
}
