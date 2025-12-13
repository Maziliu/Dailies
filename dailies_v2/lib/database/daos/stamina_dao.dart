import 'package:dailies_v2/database/database.dart';
import 'package:dailies_v2/database/tables/staminas.dart';
import 'package:drift/drift.dart';
part 'stamina_dao.g.dart';

@DriftAccessor(tables: [Staminas])
class StaminaDao extends DatabaseAccessor<Database> with _$StaminaDaoMixin {
  StaminaDao(super.db);

  Future<List<Stamina>> getAll() => select(staminas).get();

  Future<int> insert(StaminasCompanion data) => into(staminas).insert(data);

  Future<void> deleteStamina(int id) {
    return (delete(staminas)..where((s) => s.id.equals(id))).go();
  }

  Future<void> spendOrZeroStamina(int staminaId, int? amount) {
    return (update(staminas)..where((t) => t.id.equals(staminaId))).write(
      StaminasCompanion(
        staminaOfLastReset: Value(amount ?? 0),
        timeOfLastReset: Value(DateTime.now().toUtc()),
      ),
    );
  }
}
