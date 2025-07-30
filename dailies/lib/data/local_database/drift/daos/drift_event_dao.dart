import 'package:dailies/data/local_database/drift/drift_database.dart';
import 'package:dailies/data/local_database/drift/tables/drift_events_table.dart';
import 'package:dailies/data/local_database/interfaces/dao/generic_dao.dart';
import 'package:drift/drift.dart';

part 'drift_event_dao.g.dart';

@DriftAccessor(tables: [DriftEvents])
class DriftEventDao extends DatabaseAccessor<AppDatabase>
    with _$DriftEventDaoMixin
    implements GenericDao<DriftEvent, DriftEventsCompanion> {
  DriftEventDao(super.attachedDatabase);

  @override
  Future<int> deleteEntryById(int id) =>
      (delete(driftEvents)
        ..where((driftEvent) => driftEvent.id.equals(id))).go();

  @override
  Future<DriftEvent?> getEntryById(int id) =>
      (select(driftEvents)
        ..where((driftEvent) => driftEvent.id.equals(id))).getSingleOrNull();

  @override
  Future<int> insertEntry(DriftEventsCompanion object) =>
      into(driftEvents).insert(object);

  @override
  Future<bool> updateEntry(DriftEventsCompanion updatedObject) =>
      update(driftEvents).replace(updatedObject);
}
