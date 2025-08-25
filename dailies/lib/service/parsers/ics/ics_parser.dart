import 'dart:convert';
import 'dart:io';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/data/models/time_slot_pattern.dart';
import 'package:dailies/service/parsers/parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:icalendar_parser/icalendar_parser.dart';

class ICSParser implements Parser {
  @override
  Future<Result<List<Event>>> parseFile(PlatformFile file) async {
    try {
      if (file.path == null) {
        return Result.error(Exception('File path is null'));
      }

      File icsFile = File(file.path!);

      if (!await icsFile.exists()) {
        return Result.error(Exception('File does not exist'));
      }

      String icsContent;
      try {
        icsContent = await icsFile.readAsString(encoding: utf8);
      } catch (e) {
        return Result.error(Exception('Failed to read file content: ${e.toString()}'));
      }

      ICalendar iCalendar;
      try {
        iCalendar = ICalendar.fromString(icsContent);
      } catch (e) {
        return Result.error(Exception('Failed to parse ICS file: ${e.toString()}'));
      }

      List<Event> events = [];

      for (var event in iCalendar.data) {
        if (event['type'] == 'VEVENT') {
          try {
            String? summary = event['summary']?.toString();
            String? location = event['location']?.toString();

            DateTime? startTime;
            DateTime? endTime;

            if (event['dtstart'] != null) {
              startTime = _parseDateTime(event['dtstart']);
            }

            if (event['dtend'] != null) {
              endTime = _parseDateTime(event['dtend']);
            }

            String? rrule = event['rrule']?.toString();
            bool isRecurring = rrule != null;

            Duration? frequency;
            DateTime? endPatternDate;
            String? timeZoneId;

            if (isRecurring) {
              final recurrenceInfo = _parseRecurrenceRule(rrule);
              frequency = recurrenceInfo['frequency'];
              endPatternDate = recurrenceInfo['until'];
            }

            // Extract timezone information
            if (event['dtstart'] is Map && event['dtstart']['tzid'] != null) {
              timeZoneId = event['dtstart']['tzid'].toString();
            } else if (event['dtstart'] != null) {
              // Try to extract from IcsDateTime object string
              String dtstartStr = event['dtstart'].toString();
              if (dtstartStr.startsWith('IcsDateTime{')) {
                RegExp tzidRegex = RegExp(r'tzid:\s*([^,}]+)');
                Match? match = tzidRegex.firstMatch(dtstartStr);
                if (match != null) {
                  timeZoneId = match.group(1)!.trim();
                }
              }
            }

            Event parsedEvent = Event(eventName: summary ?? 'Untitled Event', location: location);

            if (startTime != null) {
              TimeSlot anchorPoint = TimeSlot.UnSaved(
                dateOfTimeSlot: DateTime(startTime.year, startTime.month, startTime.day),
                startTime: startTime,
                endTime: endTime,
              );

              TimeSlotPattern pattern = TimeSlotPattern.UnSaved(
                endPatternDate: endPatternDate,
                timeZoneId: timeZoneId,
                frequencyInSeconds: frequency?.inSeconds,
                anchorPointsList: [anchorPoint],
              );

              parsedEvent.pattern = pattern;
              parsedEvent.timeSlots.add(anchorPoint);
            }

            events.add(parsedEvent);
          } catch (e) {
            print('Error parsing individual event: ${e.toString()}');
          }
        }
      }

      return Result.ok(events);
    } catch (e) {
      return Result.error(Exception('Unexpected error: ${e.toString()}'));
    }
  }

  Map<String, dynamic> _parseRecurrenceRule(String rrule) {
    Map<String, dynamic> result = {};

    List<String> parts = rrule.split(';');
    Map<String, String> rruleMap = {};

    for (String part in parts) {
      List<String> keyValue = part.split('=');
      if (keyValue.length == 2) {
        rruleMap[keyValue[0]] = keyValue[1];
      }
    }

    //TODO: Fix the approx
    String? freq = rruleMap['FREQ'];
    if (freq != null) {
      switch (freq.toUpperCase()) {
        case 'DAILY':
          result['frequency'] = const Duration(days: 1);
        case 'WEEKLY':
          result['frequency'] = const Duration(days: 7);
        case 'MONTHLY':
          result['frequency'] = const Duration(days: 30); //Approximation
        case 'YEARLY':
          result['frequency'] = const Duration(days: 365); //Approximation
      }
    }

    String? interval = rruleMap['INTERVAL'];
    if (interval != null && result['frequency'] != null) {
      int intervalValue = int.tryParse(interval) ?? 1;
      Duration baseFrequency = result['frequency'];
      result['frequency'] = Duration(microseconds: baseFrequency.inMicroseconds * intervalValue);
    }

    String? until = rruleMap['UNTIL'];
    if (until != null) {
      result['until'] = _parseDateTime(until);
    }

    String? count = rruleMap['COUNT'];
    if (count != null) {
      result['count'] = int.tryParse(count);
    }

    return result;
  }

  DateTime? _parseDateTime(dynamic dateTimeValue) {
    if (dateTimeValue == null) return null;

    try {
      String dateTimeStr;

      // Handle IcsDateTime objects
      if (dateTimeValue is Map) {
        dateTimeStr = dateTimeValue['dt']?.toString() ?? '';
      } else {
        dateTimeStr = dateTimeValue.toString();
      }

      // If it's still an IcsDateTime object string, try to extract the dt value
      if (dateTimeStr.startsWith('IcsDateTime{')) {
        RegExp dtRegex = RegExp(r'dt:\s*([^,}]+)');
        Match? match = dtRegex.firstMatch(dateTimeStr);
        if (match != null) {
          dateTimeStr = match.group(1)!.trim();
        } else {
          print('Could not extract datetime from IcsDateTime object: $dateTimeStr');
          return null;
        }
      }

      if (dateTimeStr.contains('T')) {
        //Format: YYYYMMDDTHHMMSS or YYYYMMDDTHHMMSSZ
        dateTimeStr = dateTimeStr.replaceAll('Z', '');

        if (dateTimeStr.length >= 15) {
          int year = int.parse(dateTimeStr.substring(0, 4));
          int month = int.parse(dateTimeStr.substring(4, 6));
          int day = int.parse(dateTimeStr.substring(6, 8));
          int hour = int.parse(dateTimeStr.substring(9, 11));
          int minute = int.parse(dateTimeStr.substring(11, 13));
          int second = int.parse(dateTimeStr.substring(13, 15));

          return DateTime(year, month, day, hour, minute, second);
        }
      } else if (dateTimeStr.length == 8) {
        int year = int.parse(dateTimeStr.substring(0, 4));
        int month = int.parse(dateTimeStr.substring(4, 6));
        int day = int.parse(dateTimeStr.substring(6, 8));

        return DateTime(year, month, day);
      }

      return DateTime.tryParse(dateTimeStr);
    } catch (e) {
      print('Error parsing datetime: ${dateTimeValue.toString()}, error: ${e.toString()}');
      return null;
    }
  }
}
