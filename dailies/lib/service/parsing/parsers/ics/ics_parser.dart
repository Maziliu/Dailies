import 'dart:io';
import 'package:dailies/common/utils/generators.dart';
import 'package:dailies/common/utils/parser_helpers.dart';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/data/models/time_slot_pattern.dart';
import 'package:dailies/service/parsing/parsers/parser.dart';
import 'package:icalendar_parser/icalendar_parser.dart';

class ICSParser extends Parser {
  @override
  Future<Result<List<Event>>> parseFile(String? filePath) async {
    if (filePath == null) return Result.error(Exception('ICS file path is null'));

    final File icsFile = File(filePath);
    if (!icsFile.existsSync()) return Result.error(Exception('ICS file does not exist $filePath'));

    String icsContent;
    try {
      icsContent = await icsFile.readAsString();
    } catch (exception) {
      return Result.error(Exception('Failed to read file content: ${exception.toString()}'));
    }

    ICalendar iCalendar;
    try {
      iCalendar = ICalendar.fromString(icsContent);
    } catch (e) {
      return Result.error(Exception('Failed to parse ICS file: ${e.toString()}'));
    }

    return parseICalendar(iCalendar);
  }

  static Result<List<Event>> parseICalendar(ICalendar iCalendar) {
    final List<Event> events = [];
    for (final eventData in iCalendar.data) {
      if (eventData['type'] != 'VEVENT') continue;

      final Result result = gaurdedExectute(() {
        final String? summary = eventData['summary']?.toString();
        final String? location = eventData['location']?.toString();
        final DateTime? startTime = eventData['dtstart']?.toDateTime();
        final DateTime startDate = eventData['dtstamp'].toDateTime();
        final DateTime? endTime = eventData['dtend']?.toDateTime();
        final String? recurranceRule = eventData['rrule']?.toString();
        final List? exclusionDates = eventData['exdate']?.map((date) => date.toDateTime()).toList() ?? [];

        final Event event = Event(eventName: summary ?? 'Untitled', location: location);

        TimeSlotPattern? pattern;

        if (recurranceRule != null) {
          //RRule patterns will carry a reference. The normalize component does not matter only the relative times
          final TimeSlot reference = TimeSlot.UnSaved(dateOfTimeSlot: startDate, startTime: startTime, endTime: endTime);

          pattern = TimeSlotPattern.UnSaved(
            recurranceRule: recurranceRule,
            exclusionDates: exclusionDates?.map((date) => date as DateTime).toList(),
            anchorPointsList: [reference],
          );
        } else {
          //No rrule means this is a oneshot event but I represent these with pattern of 1
          final TimeSlot anchorPoint = TimeSlot.UnSaved(dateOfTimeSlot: startDate, startTime: startTime, endTime: endTime);
          pattern = TimeSlotPattern.UnSaved(
            endPatternDate: (endTime != null) ? normalizeDateTime(endTime) : null,
            exclusionDates: exclusionDates?.map((date) => date as DateTime).toList(),
            anchorPointsList: [anchorPoint],
          );

          event.timeSlots.add(anchorPoint);
        }

        event.pattern = pattern;
        return event;
      });

      switch (result) {
        case Ok(value: final event):
          events.add(event);
        case Error(error: final Exception exception):
          return Result.error(exception);
      }
    }

    print(events.length);

    for (final Event event in events) {
      event.timeSlots = generateTimeSlots(event.pattern);
    }

    return Result.ok(events);
  }
}
