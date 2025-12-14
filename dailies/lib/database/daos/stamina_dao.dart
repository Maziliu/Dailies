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

  Future<Stamina> setOrZeroStamina(int staminaId, int? amount) {
    return transaction(() async {
      final now = DateTime.now().toUtc();

      await (update(staminas)..where((t) => t.id.equals(staminaId))).write(
        StaminasCompanion(
          staminaOfLastReset: Value(amount ?? 0),
          timeOfLastReset: Value(now),
        ),
      );

      return (select(
        staminas,
      )..where((t) => t.id.equals(staminaId))).getSingle();
    });
  }
}

final StaminaDao STAMINA_DAO = StaminaDao(APP_DATABASE);
