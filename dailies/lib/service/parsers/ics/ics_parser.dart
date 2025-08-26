import 'dart:convert';
import 'dart:io';
import 'package:dailies/common/utils/generators.dart';
import 'package:dailies/common/utils/parser_helpers.dart';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/data/models/time_slot_pattern.dart';
import 'package:dailies/service/parsers/parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:icalendar_parser/icalendar_parser.dart';

class ICSParser implements Parser {
  @override
  Future<Result<List<Event>>> parseFile(PlatformFile file) async {
    if (file.path == null) return Result.error(Exception("ICS file path is null"));

    File icsFile = File(file.path!);
    if (!(await icsFile.exists())) return Result.error(Exception("ICS file does not exist ${file.path}"));

    String icsContent;
    try {
      icsContent = await icsFile.readAsString(encoding: utf8);
    } catch (exception) {
      return Result.error(Exception('Failed to read file content: ${exception.toString()}'));
    }

    ICalendar iCalendar;
    try {
      iCalendar = ICalendar.fromString(icsContent);
    } catch (e) {
      return Result.error(Exception('Failed to parse ICS file: ${e.toString()}'));
    }

    return _parseICalendar(iCalendar);
  }

  Result<List<Event>> _parseICalendar(ICalendar iCalendar) {
    List<Event> events = [];
    for (var eventData in iCalendar.data) {
      if (eventData['type'] != 'VEVENT') continue;
      if (eventData['dtstart'] == null) return Result.error(Exception('Incorrectly formated file. VEVENT must have DTSTART'));

      Result result = gaurdedExectute(() {
        String? summary = eventData['summary']?.toString();
        String? location = eventData['location']?.toString();
        DateTime startTime = eventData['dtstart'].toDateTime();
        DateTime startDate = normalizeDateTime(startTime);
        DateTime? endTime = eventData['dtend']?.toDateTime();
        String? recurranceRule = eventData['rrule']?.toString();
        List? exclusionDates = eventData['exdate']?.map((date) => date.toDateTime()).toList() ?? [];

        Event event = Event(eventName: summary ?? 'Untitled', location: location);

        TimeSlotPattern? pattern;

        if (recurranceRule != null) {
          //RRule patterns will carry a reference. The normalize component does not matter only the relative timesll
          TimeSlot reference = TimeSlot.UnSaved(dateOfTimeSlot: startDate, startTime: startTime, endTime: endTime);

          pattern = TimeSlotPattern.UnSaved(
            recurranceRule: recurranceRule,
            exclusionDates: exclusionDates?.map((date) => date as DateTime).toList(),
            anchorPointsList: [reference],
          );
        } else {
          //No rrule means this is a oneshot event but I represent these with pattern of 1
          TimeSlot anchorPoint = TimeSlot.UnSaved(dateOfTimeSlot: startDate, startTime: startTime, endTime: endTime);
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
