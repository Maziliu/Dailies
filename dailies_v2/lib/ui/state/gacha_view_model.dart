import 'package:dailies_v2/models/stamina.dart';
import 'package:flutter/foundation.dart';

class GachaViewModel extends ChangeNotifier {
  final ValueNotifier<List<StaminaModel>> staminas = ValueNotifier([]);

  void onAddStaminaButtonPress(
    String gachaName,
    int maxStamina,
    Duration rechargeTime,
    int staminaOfLastestReset,
    String? imageName,
  ) async {}

  Future<void> _initialize() async {
    await loadAllStaminas();
  }

  Future<void> loadAllStaminas() async {}

  void deleteStamina(StaminaModel stamina) async {}
}
