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

    Result<int> id = await _staminaRepositoryService.saveStamina(stamina);

    switch (id) {
      case Ok<int>(value: final int id):
        stamina.id = id;
        staminas.value.add(stamina);
        notifyListeners();
      case Error<int>():
        throw UnimplementedError();
    }
  }

  Future<void> initialize() async {
    await loadAllStaminas();
  }

  Future<void> loadAllStaminas() async {
    Result<List<Stamina>> results = await _staminaRepositoryService.fetchAllStaminas();

    switch (results) {
      case Ok<List<Stamina>>(value: final staminaList):
        staminas.value = staminaList;
      case Error<List<Stamina>>():
        print("OVERVIEEW INIT ERROR");
    }

    for (Stamina s in staminas.value) {
      print("Name of Gacha: ${s.gachaTitle} Stamina of last reset: ${s.staminaOfLastestReset} Time of last save: ${s.timeOfLastReset.toString()}");
    }
  }

  void deleteStamina(Stamina stamina) async {
    await _staminaRepositoryService.deleteStamina(stamina);

    staminas.value.remove(stamina);

    notifyListeners();
  }
}
