import 'package:dailies_v2/database/database.dart';
import 'package:dailies_v2/database/tables/events.dart';
import 'package:drift/drift.dart';

part 'event_dao.g.dart';

@DriftAccessor(tables: [EventInfos, EventCacheInstances])
class EventDao extends DatabaseAccessor<Database> with _$EventDaoMixin {
  EventDao(super.db);

  Stream<List<EventInfo>> watchAllEventInfos() => select(eventInfos).watch();

  Stream<List<EventCacheInstance>> watchAllCacheInstances() =>
      select(eventCacheInstances).watch();

  Future<int> insertEventInfo(EventInfosCompanion entry) =>
      into(eventInfos).insert(entry);

  Future<void> insertCacheInstances(
    List<EventCacheInstancesCompanion> entries,
  ) => batch((batch) {
    batch.insertAll(eventCacheInstances, entries);
  });

  Future<void> deleteEvent(int eventInfoId) async =>
      await (delete(eventInfos)..where((e) => e.id.equals(eventInfoId))).go();

  Future<void> deleteAllEvents() async => await delete(eventInfos).go();
}

final EventDao EVENT_DAO = EventDao(APP_DATABASE);
