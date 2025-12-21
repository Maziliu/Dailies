import 'package:dailies_v2/enums/event_type.dart';
import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/services/parsing/ics_parser.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/result_unwrapper.dart';

void main() {
  test('parses single one-time event', () async {
    final parser = ICS_PARSER;

    const rawIcs = '''
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Test//ICSParser//EN
BEGIN:VEVENT
UID:1
SUMMARY:Meeting
DTSTART:20250101T120000Z
DTEND:20250101T130000Z
DESCRIPTION:Team meeting
LOCATION:Office
END:VEVENT
END:VCALENDAR
''';

    final result = await parser.rawTextToEventInfos(rawIcs);
    final events = expectOk(result);

    expect(events.length, 1);

    final event = expectOk(events.first);
    expect(event.title, 'Meeting');
    expect(event.type, EventType.INTERVAL);
    expect(event.start?.hour, 12);
    expect(event.end!.hour, 13);
  });

  test('parses deadline event', () async {
    final parser = ICSParser();

    const rawIcs = '''
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Test//ICSParser//EN
BEGIN:VEVENT
UID:2
SUMMARY:Assignment Due
DTSTART:20250110T235900Z
END:VEVENT
END:VCALENDAR
''';

    final result = await parser.rawTextToEventInfos(rawIcs);
    final events = expectOk(result);

    final event = expectOk(events.first);
    expect(event.type, EventType.DEADLINE);
    expect(event.end, isNull);
  });

  test('parses all-day event', () async {
    final parser = ICSParser();

    const rawIcs = '''
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Test//ICSParser//EN
BEGIN:VEVENT
UID:3
SUMMARY:Holiday
DTSTART:20250101
DTEND:20250102
END:VEVENT
END:VCALENDAR
''';

    final result = await parser.rawTextToEventInfos(rawIcs);
    final events = expectOk(result);

    final event = expectOk(events.first);
    expect(event.start?.hour, 0);
    expect(event.type, EventType.DEADLINE);
  });

  test('parses recurring event', () async {
    final parser = ICSParser();

    const rawIcs = '''
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Test//ICSParser//EN
BEGIN:VEVENT
UID:4
SUMMARY:Standup
DTSTART:20250101T090000Z
RRULE:FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR
END:VEVENT
END:VCALENDAR
''';

    final result = await parser.rawTextToEventInfos(rawIcs);
    final events = expectOk(result);

    final event = expectOk(events.first);
    expect(event.type, EventType.REACCURING);
    expect(event.rrule, contains('FREQ=WEEKLY'));
    expect(event.rrule, contains('BYDAY=MO,TU,WE,TH,FR'));
  });

  test('parses multi-day event', () async {
    final parser = ICSParser();

    const rawIcs = '''
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Test//ICSParser//EN
BEGIN:VEVENT
UID:5
SUMMARY:Conference
DTSTART:20250101T090000Z
DTEND:20250103T170000Z
END:VEVENT
END:VCALENDAR
''';

    final result = await parser.rawTextToEventInfos(rawIcs);
    final events = expectOk(result);

    final event = expectOk(events.first);
    expect(event.type, EventType.MULTI_DAY);
  });

  test('parses multiple events from one file', () async {
    final parser = ICSParser();

    const rawIcs = '''
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Test//ICSParser//EN
BEGIN:VEVENT
UID:6
SUMMARY:Event A
DTSTART:20250101T100000Z
END:VEVENT
BEGIN:VEVENT
UID:7
SUMMARY:Event B
DTSTART:20250102T100000Z
END:VEVENT
END:VCALENDAR
''';

    final result = await parser.rawTextToEventInfos(rawIcs);
    final events = expectOk(result);

    expect(events.length, 2);
  });

  test('fails when no VEVENT present', () async {
    final parser = ICSParser();

    const rawIcs = '''
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Test//ICSParser//EN
END:VCALENDAR
''';

    final result = await parser.rawTextToEventInfos(rawIcs);

    expect(result, isA<Error<List<Result<EventInfoModel>>>>());
  });
}
