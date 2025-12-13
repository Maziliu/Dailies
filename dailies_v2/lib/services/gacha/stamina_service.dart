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

  Future<Result<StaminaModel>> spendStamina(int? staminaId, int? amount) async {
    if (amount != null && amount <= 0) {
      return Result.error(
        ValidationFailure("Stamina amount must be greater than 0 or null"),
      );
    }

    if (staminaId == null) {
      return Result.error(
        ValidationFailure("Stamina id in null. Must be positive or zero"),
      );
    }

    if (staminaId < 0) {
      return Result.error(
        ValidationFailure(
          "Stamina id: $staminaId is invalid. Must be positive or zero",
        ),
      );
    }

    Stamina result;

    try {
      result = await _dao.spendOrZeroStamina(staminaId, amount);
    } catch (e) {
      return Result.error(
        DatabaseFailure(
          "Failed to spend stamina id: $staminaId ${e.toString()}",
        ),
      );
    }

    try {
      return Result.ok(result.toModel());
    } catch (e) {
      return Result.error(
        ConversionFailure(
          "Failed to convert stamina id: $staminaId to model ${e.toString()}",
        ),
      );
    }
  }

  Future<Result<void>> deleteStamina(int? staminaId) async {
    if (staminaId == null) {
      return Result.error(
        ValidationFailure("Stamina id is null. Must be positive or zero"),
      );
    }

    if (staminaId < 0) {
      return Result.error(
        ValidationFailure(
          "Stamina id: $staminaId is invalid. Must be positive or zero",
        ),
      );
    }

    return guardedAsyncExecute(
      () => _dao.deleteStamina(staminaId),
      DatabaseFailure("Failed to delete stamina id: $staminaId"),
    );
  }
}
