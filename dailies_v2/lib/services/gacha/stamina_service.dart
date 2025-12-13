import 'package:dailies_v2/database/daos/stamina_dao.dart';
import 'package:dailies_v2/database/database.dart';
import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/utils/result.dart';

class StaminaService {
  final StaminaDao _dao = StaminaDao(APP_DATABASE);

  Future<Result<int>> insertStamina(StaminaModel stamina) async {
    return guardedAsyncExecute<int>(
      () => _dao.insert(stamina.toCompanion()),
      DatabaseFailure("Failed to insert ${stamina.gachaTitle}"),
    );
  }

  Future<Result<void>> spendStamina(int staminaId, int? amount) async {
    return guardedAsyncExecute(
      () => _dao.spendOrZeroStamina(staminaId, amount),
      DatabaseFailure("Failed to spend $amount stamina of id: $staminaId"),
    );
  }

  Future<Result<void>> deleteStamina(int staminaId) async {
    return guardedAsyncExecute(
      () => _dao.deleteStamina(staminaId),
      DatabaseFailure("Failed to delete stamina id: $staminaId"),
    );
  }
}
