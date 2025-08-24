import 'package:dailies/data/dao/time_slot_pattern_dao.dart';
import 'package:dailies/data/database/drift/drift_database.dart';
import 'package:dailies/data/database/drift/tables/drift_time_slot_patterns.dart';
import 'package:drift/drift.dart';

part 'drift_time_slot_pattern_dao.g.dart';

@DriftAccessor(tables: [DriftTimeSlotPatterns])
class DriftTimeSlotPatternDao extends DatabaseAccessor<AppDatabase>
    with _$DriftTimeSlotPatternDaoMixin
    implements TimeSlotPatternDao<DriftTimeSlotPattern, DriftTimeSlotPatternsCompanion> {
  DriftTimeSlotPatternDao(super.attachedDatabase);

  @override
  Future<int> deleteEntryById(int id) => (delete(driftTimeSlotPatterns)..where((pattern) => pattern.id.equals(id))).go();

  @override
  Future<DriftTimeSlotPattern?> getEntryById(int id) => (select(driftTimeSlotPatterns)..where((pattern) => pattern.id.equals(id))).getSingleOrNull();

  @override
  Future<int> insertEntry(DriftTimeSlotPatternsCompanion object) => into(driftTimeSlotPatterns).insert(object);

  @override
  Future<bool> updateEntry(DriftTimeSlotPatternsCompanion updatedObject) => update(driftTimeSlotPatterns).replace(updatedObject);
}
