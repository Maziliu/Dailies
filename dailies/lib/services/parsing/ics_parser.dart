import 'dart:math';

import 'package:dailies_v2/enums/event_type.dart';
import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/services/parsing/parser.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:file_picker/file_picker.dart';
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
      return TZDateTime.parse(getLocation(ics.tzid!), ics.dt);
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
  Stream<FileParseEvent> parseFilesStream(List<PlatformFile> files) async* {
    int completed = 0;
    final total = files.length;

    for (final file in files) {
      final textResult = await extractTextFromFile(file);

      switch (textResult) {
        case Ok<String>(value: final rawText):
          final parsed = await rawTextToEventInfos(rawText);

          switch (parsed) {
            case Ok<List<Result<EventInfoModel>>>(value: final events):
              for (final event in events) {
                switch (event) {
                  case Ok<EventInfoModel>(value: final e):
                    yield FileParseSuccess(e);
                  case Error<EventInfoModel>(failure: final f):
                    yield FileParseFailure(file.name, f);
                }
              }
            case Error<List<Result<EventInfoModel>>>(failure: final f):
              yield FileParseFailure(file.name, f);
          }

        case Error<String>(failure: final f):
          yield FileParseFailure(file.name, f);
      }

      completed++;
      yield FileParseProgress(completed, total);
    }
  }
}

final ICSParser ICS_PARSER = ICSParser();
