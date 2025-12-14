import 'package:dailies_v2/database/daos/stamina_dao.dart';
import 'package:dailies_v2/database/database.dart';
import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/utils/result.dart';

class StaminaService {
  final StaminaDao _dao = StaminaDao(APP_DATABASE);

  Future<Result<int>> insertStamina(StaminaModel stamina) async {
    return guardedAsyncExecute<int>(
      () => _dao.insert(stamina.toCompanion()),
      DatabaseFailure('Failed to insert ${stamina.gachaTitle}'),
    );
  }

  Future<Result<StaminaModel>> spendStamina(int? staminaId, int? amount) async {
    if (amount != null && amount <= 0) {
      return Result.error(
        ValidationFailure('Stamina amount must be greater than 0 or null'),
      );
    }

    if (staminaId == null) {
      return Result.error(
        ValidationFailure('Stamina id in null. Must be positive or zero'),
      );
    }

    if (staminaId < 0) {
      return Result.error(
        ValidationFailure(
          'Stamina id: $staminaId is invalid. Must be positive or zero',
        ),
      );
    }

    final Result<Stamina> result = await guardedAsyncExecute(
      () => _dao.spendOrZeroStamina(staminaId, amount),
      DatabaseFailure('Failed to spend stamina id: $staminaId'),
    );

    switch (result) {
      case Ok<Stamina>(value: final Stamina stamina):
        return guardedAsyncExecute(
          () async => stamina.toModel(),
          ConversionFailure(
            'Failed to convert stamina id: $staminaId to model',
          ),
        );

      case Error<Stamina>(failure: final Failure error):
        return Result.error(error);
    }
  }

  Future<Result<void>> deleteStamina(int? staminaId) async {
    if (staminaId == null) {
      return Result.error(
        ValidationFailure('Stamina id is null. Must be positive or zero'),
      );
    }

    if (staminaId < 0) {
      return Result.error(
        ValidationFailure(
          'Stamina id: $staminaId is invalid. Must be positive or zero',
        ),
      );
    }

    return guardedAsyncExecute(
      () => _dao.deleteStamina(staminaId),
      DatabaseFailure('Failed to delete stamina id: $staminaId'),
    );
  }

  Future<Result<List<StaminaModel>>> getAllStaminas() async {
    final Result<List<Stamina>> result = await guardedAsyncExecute(
      _dao.getAll,
      DatabaseFailure('Failed to retreive all staminas'),
    );

    switch (result) {
      case Ok<List<Stamina>>(value: final List<Stamina> staminas):
        return await guardedAsyncExecute(
          () async => staminas.map((s) => s.toModel()).toList(),
          ConversionFailure('Failed to convert stamina list'),
        );

      case Error<List<Stamina>>(failure: final Failure error):
        return Result.error(error);
    }
  }
}
