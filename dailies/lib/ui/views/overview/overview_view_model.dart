import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/stamina.dart';
import 'package:dailies/service/repository/stamina_repository_service.dart';
import 'package:flutter/material.dart';

class OverviewViewModel extends ChangeNotifier {
  final StaminaRepositoryService _staminaRepositoryService;
  final ValueNotifier<List<Stamina>> staminas = ValueNotifier([]);

  OverviewViewModel({required StaminaRepositoryService staminaRepositoryService}) : _staminaRepositoryService = staminaRepositoryService;

  void onAddStaminaButtonPress(String gachaName, int maxStamina, Duration rechargeTime, int staminaOfLastestReset, String? imageName) async {
    Stamina stamina = Stamina(
      rechargeTime: rechargeTime,
      maxStamina: maxStamina,
      gachaTitle: gachaName,
      imageName: imageName,
      timeOfLastReset: DateTime.now(),
      staminaOfLastestReset: staminaOfLastestReset,
    );

    _staminaRepositoryService.saveStamina(stamina);
  }

  Future<void> initialize() async {
    await loadAllStaminas();
    notifyListeners();
  }

  Future<void> loadAllStaminas() async {
    Result<List<Stamina>> results = await _staminaRepositoryService.fetchAllStaminas();

    switch (results) {
      case Ok<List<Stamina>>(value: final staminaList):
        staminas.value = staminaList;
      case Error<List<Stamina>>():
        print("OVERVIEEW INIT ERROR");
    }
  }
}
