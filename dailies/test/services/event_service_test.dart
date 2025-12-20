import 'package:dailies_v2/database/daos/event_dao.dart';
import 'package:dailies_v2/database/database.dart';
import 'package:dailies_v2/enums/event_type.dart';
import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/services/event/event_service.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_database.dart';

void main() {
  late Database db;
  late EventDao dao;
  late EventService service;

  setUp(() async {
    db = createTestDatabase();
    dao = EventDao(db);
    service = EventService(dao: dao);
  });

  tearDown(() async {
    await db.close();
  });

  EventInfoModel baseEvent({
    EventType type = EventType.INTERVAL,
    DateTime? start,
    DateTime? end,
    String? rrule,
  }) {
    final now = DateTime(2024, 1, 1, 10);

    return EventInfoModel(
      calendarId: 'local',
      uid: 'uid-1',
      title: 'Test Event',
      date: DateTime(2024),
      start: start,
      end: end,
      timezone: 'UTC',
      rrule: rrule,
      type: type,
      createdAt: now,
      lastModified: now,
    );
  }

  test('createEvent inserts EventInfo and one cache instance', () async {
    final event = baseEvent(
      start: DateTime(2024, 1, 1, 10),
      end: DateTime(2024, 1, 1, 11),
    );

    final result = await service.createEvent(event);

    expect(result, isA<Ok<int>>());

    final infos = await dao.watchAllEventInfos().first;
    final instances = await dao.watchAllCacheInstances().first;

    expect(infos.length, 1);
    expect(instances.length, 1);
  });

  test(
    'createEvent with null start creates instance with null start',
    () async {
      final event = baseEvent();

      final result = await service.createEvent(event);

      expect(result, isA<Ok<int>>());

      final instances = await dao.watchAllCacheInstances().first;
      expect(instances.length, 1);
      expect(instances.first.start, isNull);
    },
  );

  test('multi-day event expands into daily instances', () async {
    final event = baseEvent(
      type: EventType.MULTI_DAY,
      start: DateTime(2024),
      end: DateTime(2024, 1, 3),
    );

    final result = await service.createEvent(event);

    expect(result, isA<Ok<int>>());

    final instances = await dao.watchAllCacheInstances().first;
    expect(instances.length, 3);
  });

  test('daily recurring event generates correct count', () async {
    final event = baseEvent(
      type: EventType.REACCURING,
      start: DateTime(2024, 1, 1, 9),
      end: DateTime(2024, 1, 1, 10),
      rrule: 'FREQ=DAILY;COUNT=5',
    );

    final result = await service.createEvent(event);

    expect(result, isA<Ok<int>>());

    final instances = await dao.watchAllCacheInstances().first;
    expect(instances.length, 5);
  });

  test(
    'recurring event with null start uses date as cursor but keeps start null',
    () async {
      final event = baseEvent(
        type: EventType.REACCURING,
        rrule: 'FREQ=DAILY;COUNT=3',
      );

      final result = await service.createEvent(event);

      expect(result, isA<Ok<int>>());

      final instances = await dao.watchAllCacheInstances().first;
      expect(instances.length, 3);
      expect(instances.every((e) => e.start == null), true);
    },
  );

  test('deleteEvent removes EventInfo and cache instances', () async {
    final event = baseEvent(
      start: DateTime(2024, 1, 1, 10),
      end: DateTime(2024, 1, 1, 11),
    );

    final create = await service.createEvent(event);
    final id = (create as Ok<int>).value;

    final delete = await service.deleteAllEventsInSeries(id);

    expect(delete, isA<Ok<void>>());

    final infos = await dao.watchAllEventInfos().first;
    final instances = await dao.watchAllCacheInstances().first;

    expect(infos, isEmpty, reason: 'Infos should be gone');
    expect(instances, isEmpty, reason: 'Instances should be gone');
  });

  test('deleteEvent fails for null id', () async {
    final result = await service.deleteAllEventsInSeries(null);

    expect(result, isA<Error<void>>());
    expect((result as Error).failure, isA<ValidationFailure>());
  });

  test('deleteEvent fails for negative id', () async {
    final result = await service.deleteAllEventsInSeries(-1);

    expect(result, isA<Error<void>>());
    expect((result as Error).failure, isA<ValidationFailure>());
  });
}
