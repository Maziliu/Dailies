import 'dart:math';

import 'package:dailies_v2/enums/event_type.dart';
import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/services/parsing/parser.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:timezone/standalone.dart';
import 'package:uuid/uuid.dart';

class ICSParser extends FileParser {
  static const _uuid = Uuid();

  List<Map<String, dynamic>> extractVEvents(ICalendar iCal) {
    return iCal.data
        .whereType<Map<String, dynamic>>()
        .where((e) => e['type'] == 'VEVENT')
        .toList();
  }

  DateTime _icsDateTimeToDateTime(IcsDateTime ics) {
    if (ics.tzid != null) {
      final location = getLocation(ics.tzid!);
      return TZDateTime(
        location,
        int.parse(ics.dt.substring(0, 4)),
        int.parse(ics.dt.substring(4, 6)),
        int.parse(ics.dt.substring(6, 8)),
        ics.dt.length > 8 ? int.parse(ics.dt.substring(9, 11)) : 0,
        ics.dt.length > 8 ? int.parse(ics.dt.substring(11, 13)) : 0,
        ics.dt.length > 8 ? int.parse(ics.dt.substring(13, 15)) : 0,
      );
    }

    return DateTime.parse(ics.dt);
  }

  bool _isAllDayEvent(IcsDateTime start, IcsDateTime? end) {
    if (!start.dt.contains('T')) return true;

    if (end == null) return false;
    if (!end.dt.contains('T')) return false;

    final s = _icsDateTimeToDateTime(start);
    final e = _icsDateTimeToDateTime(end);

    final sMidnight =
        s.hour == 0 && s.minute == 0 && s.second == 0 && s.millisecond == 0;
    final eMidnight =
        e.hour == 0 && e.minute == 0 && e.second == 0 && e.millisecond == 0;

    if (sMidnight && eMidnight) {
      final sDate = DateTime(s.year, s.month, s.day);
      final eDate = DateTime(e.year, e.month, e.day);
      return eDate.isAfter(sDate);
    }

    return false;
  }

  int _allDaySpan(DateTime start, DateTime end) {
    final sDate = DateTime(start.year, start.month, start.day);
    final eDate = DateTime(end.year, end.month, end.day);
    return eDate.difference(sDate).inDays;
  }

  EventType _classifyEvent({
    required DateTime start,
    DateTime? end,
    String? rrule,
    required bool isAllDay,
  }) {
    if (rrule != null) return EventType.REACCURING;

    if (end == null || end.isAtSameMomentAs(start)) {
      return EventType.DEADLINE;
    }

    if (isAllDay) {
      final days = _allDaySpan(start, end);
      if (days > 1) return EventType.MULTI_DAY;
      return EventType.DEADLINE;
    }

    final dayDiff = end.difference(start).inDays;
    if (dayDiff >= 1) return EventType.MULTI_DAY;

    return EventType.INTERVAL;
  }

  Result<EventInfoModel> _icalEventToEventInfo(Map<String, dynamic> event) {
    final IcsDateTime? icsStart = event['dtstart'];
    if (icsStart == null) {
      return Result.error(
        ICSParseFailure('Invalid ICAL event: missing dtstart'),
      );
    }

    final IcsDateTime? icsEnd = event['dtend'];

    final DateTime start = _icsDateTimeToDateTime(icsStart);
    final DateTime? end = icsEnd != null
        ? _icsDateTimeToDateTime(icsEnd)
        : null;

    final bool isAllDay = _isAllDayEvent(icsStart, icsEnd);
    final String uid = event['uid'] is String ? event['uid'] : _uuid.v4();

    final String title = event['summary'] is String
        ? event['summary']
        : 'Untitled';

    final String? description = event['description'];
    final String? location = event['location'];

    final String? rrule = event['rrule'];

    final EventType type = _classifyEvent(
      start: start,
      end: end,
      rrule: rrule,
      isAllDay: isAllDay,
    );

    final DateTime date = DateTime(start.year, start.month, start.day);

    return Result.ok(
      EventInfoModel(
        uid: uid,
        calendarId: 'imported',
        title: title,
        description: description,
        location: location?.trim(),
        date: date,
        start: start,
        end: end,
        type: type,
        rrule: rrule,
        createdAt: DateTime.now(),
        lastModified: DateTime.now(),
      ),
    );
  }

  @override
  Future<Result<List<Result<EventInfoModel>>>> rawTextToEventInfos(
    String rawText,
  ) async {
    final ICalendar ical = ICalendar.fromString(rawText);
    final events = extractVEvents(ical);

    if (events.isEmpty) {
      final preview = rawText.substring(0, min(500, rawText.length));
      return Result.error(
        FileExtractionFailure(
          'No events were found in .ics file\nPreview:\n$preview',
        ),
      );
    }

    return Result.ok(events.map(_icalEventToEventInfo).toList());
  }

  @override
  bool canParse(PlatformFile file) => file.extension?.toLowerCase() == 'ics';
}

final ICSParser ICS_PARSER = ICSParser();
