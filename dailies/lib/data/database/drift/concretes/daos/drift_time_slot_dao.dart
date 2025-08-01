import 'package:dailies/data/database/drift/drift_database.dart';
import 'package:dailies/data/database/drift/tables/drift_time_slots_table.dart';
import 'package:dailies/data/dao/time_slot_dao.dart';
import 'package:drift/drift.dart';

part 'drift_time_slot_dao.g.dart';

@DriftAccessor(tables: [DriftTimeSlots])
class DriftTimeSlotDao extends DatabaseAccessor<AppDatabase> with _$DriftTimeSlotDaoMixin implements TimeSlotDao<DriftTimeSlot, DriftTimeSlotsCompanion> {
  DriftTimeSlotDao(super.attachedDatabase);

  @override
  Future<int> deleteEntryById(int id) => (delete(driftTimeSlots)..where((driftTimeSlot) => driftTimeSlot.id.equals(id))).go();

  @override
  Future<DriftTimeSlot?> getEntryById(int id) => (select(driftTimeSlots)..where((driftTimeSlot) => driftTimeSlot.id.equals(id))).getSingleOrNull();

  @override
  Future<int> insertEntry(DriftTimeSlotsCompanion object) => into(driftTimeSlots).insert(object);

  @override
  Future<bool> updateEntry(DriftTimeSlotsCompanion updatedObject) => update(driftTimeSlots).replace(updatedObject);

  @override
  Future<List<DriftTimeSlot>> getTimeSlotsInDateTimeRange(DateTime lowerBound, DateTime upperBound) =>
      (select(driftTimeSlots)..where((timeSlot) => timeSlot.date.isBetweenValues(lowerBound, upperBound))).get();
}
