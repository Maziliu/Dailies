import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/services/gacha/stamina_service.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:flutter/foundation.dart';

class GachaViewModel extends ChangeNotifier {
  final ValueNotifier<List<StaminaModel>> staminas = ValueNotifier([]);
  final StaminaService _staminaService = StaminaService();

  void insertStamina(StaminaModel stamina) async {
    final Result<int> result = await _staminaService.insertStamina(stamina);

    switch (result) {
      case Ok<int>(value: int id):
        stamina.id = id;
        staminas.value = [...staminas.value, stamina];
        print("Inserted $id ${stamina.staminaOfLastestReset}");

      case Error<int>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  Future<void> _initialize() async {
    await loadAllStaminas();
  }

  Future<void> loadAllStaminas() async {}

  void deleteStamina(StaminaModel stamina) async {
    final Result<void> result = await _staminaService.deleteStamina(stamina.id);

    switch (result) {
      case Ok<void>():
        staminas.value = staminas.value
            .where((s) => s.id != stamina.id)
            .toList();
        print("Deleted ${stamina.id} ${stamina.gachaTitle}");

      case Error<void>(failure: Failure error):
        print(error.message);
    }
  }

  void spendStamina(StaminaModel stamina, {int? amount}) async {
    final Result<StaminaModel> result = await _staminaService.spendStamina(
      stamina.id,
      amount,
    );

    switch (result) {
      case Ok<StaminaModel>(value: final updatedStamina):
        final list = List<StaminaModel>.from(staminas.value);

        final index = list.indexWhere((s) => s.id == stamina.id);
        if (index == -1) return;

        list[index] = updatedStamina;
        staminas.value = list;

      case Error<StaminaModel>(failure: final error):
        print(error.message);
    }
  }
}
