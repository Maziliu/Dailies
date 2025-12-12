import 'package:dailies_v2/models/gacha_stamina_model.dart';
import 'package:flutter/foundation.dart';

class GachaViewModel extends ChangeNotifier {
  final ValueNotifier<List<GachaStaminaModel>> staminas = ValueNotifier([]);

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

  void deleteStamina(GachaStaminaModel stamina) async {}
}
