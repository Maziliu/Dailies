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
        staminas.value = [...staminas.value, stamina];
        print("Inserted $id");

      case Error<int>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  Future<void> _initialize() async {
    await loadAllStaminas();
  }

  Future<void> loadAllStaminas() async {}

  void deleteStamina(StaminaModel stamina) async {}
}
