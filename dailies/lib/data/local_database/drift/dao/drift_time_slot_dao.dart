import 'package:dailies/data/local_database/drift/drift_database.dart';
import 'package:dailies/data/local_database/drift/tables/drift_time_slots_table.dart';
import 'package:drift/drift.dart';

part 'drift_time_slot_dao.g.dart';

@DriftAccessor(tables: [DriftTimeSlots])
class DriftTimeSlotDao extends DatabaseAccessor<AppDatabase>
    with _$DriftTimeSlotDaoMixin {
  DriftTimeSlotDao(super.attachedDatabase);

  Future<int> insertTimeSlotByCompanion(DriftTimeSlotsCompanion companion) =>
      into(driftTimeSlots).insert(companion);

  Future<int> deleteByTimeSlotId(int timeSlotId) =>
      (delete(driftTimeSlots)
        ..where((driftTimeSlot) => driftTimeSlot.id.equals(timeSlotId))).go();

  Future<DriftTimeSlot?> getTimeSlotById(int timeSlotId) =>
      (select(driftTimeSlots)..where(
        (driftTimeSlot) => driftTimeSlot.id.equals(timeSlotId),
      )).getSingleOrNull();

  Future<bool> updateTimeSlotByCompanion(DriftTimeSlotsCompanion companion) =>
      update(driftTimeSlots).replace(companion);
}
