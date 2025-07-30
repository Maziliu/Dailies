import 'package:dailies/data/local_database/drift/drift_database.dart';
import 'package:dailies/data/local_database/drift/tables/drift_events_table.dart';
import 'package:drift/drift.dart';

part 'drift_event_dao.g.dart';

@DriftAccessor(tables: [DriftEvents])
class DriftEvemtDao extends DatabaseAccessor<AppDatabase>
    with _$DriftEvemtDaoMixin {
  DriftEvemtDao(super.attachedDatabase);

  Future<int> insertEventByCompanion(DriftEventsCompanion companion) =>
      into(driftEvents).insert(companion);

  Future<int> deleteByEventId(int eventId) =>
      (delete(driftEvents)
        ..where((driftEvent) => driftEvent.id.equals(eventId))).go();

  Future<DriftEvent?> getEventById(int eventId) =>
      (select(driftEvents)..where(
        (driftEvent) => driftEvent.id.equals(eventId),
      )).getSingleOrNull();

  Future<bool> updateEventByCompanion(DriftEventsCompanion companion) =>
      update(driftEvents).replace(companion);
}
