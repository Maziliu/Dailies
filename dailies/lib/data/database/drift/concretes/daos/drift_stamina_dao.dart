import 'package:dailies/data/dao/stamina_dao.dart';
import 'package:dailies/data/database/drift/drift_database.dart';
import 'package:dailies/data/database/drift/tables/drift_staminas_table.dart';
import 'package:drift/drift.dart';

part 'drift_stamina_dao.g.dart';

@DriftAccessor(tables: [DriftStaminas])
class DriftStaminaDao extends DatabaseAccessor<AppDatabase> with _$DriftStaminaDaoMixin implements StaminaDao<DriftStamina, DriftStaminasCompanion> {
  DriftStaminaDao(super.attachedDatabase);

  @override
  Future<int> deleteEntryById(int id) => (delete(driftStaminas)..where((driftStamina) => driftStamina.id.equals(id))).go();

  @override
  Future<DriftStamina?> getEntryById(int id) => (select(driftStaminas)..where((driftStamina) => driftStamina.id.equals(id))).getSingleOrNull();

  @override
  Future<int> insertEntry(DriftStaminasCompanion object) => into(driftStaminas).insert(object);

  @override
  Future<bool> updateEntry(DriftStaminasCompanion updatedObject) => update(driftStaminas).replace(updatedObject);

  @override
  Future<List<DriftStamina>> getAllStaminaEntries() => select(driftStaminas).get();
}
