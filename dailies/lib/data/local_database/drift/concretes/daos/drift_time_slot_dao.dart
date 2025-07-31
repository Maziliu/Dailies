import 'package:dailies/data/local_database/drift/drift_database.dart';
import 'package:dailies/data/local_database/drift/tables/drift_time_slots_table.dart';
import 'package:dailies/data/local_database/interfaces/dao/generic_dao.dart';
import 'package:drift/drift.dart';

part 'drift_time_slot_dao.g.dart';

@DriftAccessor(tables: [DriftTimeSlots])
class DriftTimeSlotDao extends DatabaseAccessor<AppDatabase>
    with _$DriftTimeSlotDaoMixin
    implements GenericDao<DriftTimeSlot, DriftTimeSlotsCompanion> {
  DriftTimeSlotDao(super.attachedDatabase);

  @override
  Future<int> deleteEntryById(int id) =>
      (delete(driftTimeSlots)
        ..where((driftTimeSlot) => driftTimeSlot.id.equals(id))).go();

  @override
  Future<DriftTimeSlot?> getEntryById(int id) =>
      (select(driftTimeSlots)..where(
        (driftTimeSlot) => driftTimeSlot.id.equals(id),
      )).getSingleOrNull();

  @override
  Future<int> insertEntry(DriftTimeSlotsCompanion object) =>
      into(driftTimeSlots).insert(object);

  @override
  Future<bool> updateEntry(DriftTimeSlotsCompanion updatedObject) =>
      update(driftTimeSlots).replace(updatedObject);
}
