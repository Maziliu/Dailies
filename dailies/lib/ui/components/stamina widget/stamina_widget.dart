import 'dart:async';

import 'package:dailies/data/models/stamina.dart';
import 'package:dailies/dependency_setup.dart';
import 'package:dailies/service/repository/stamina_repository_service.dart';
import 'package:dailies/ui/components/popup%20cards/delete_confirmation_popup_card.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class StaminaWidget extends StatefulWidget {
  final Stamina _stamina;
  final void Function(Stamina) _onDelete;

  const StaminaWidget({super.key, required Stamina stamina, required void Function(Stamina) onDelete}) : _stamina = stamina, _onDelete = onDelete;

  @override
  State<StaminaWidget> createState() => _StaminaWidgetState();
}

class _StaminaWidgetState extends State<StaminaWidget> {
  Timer? timer;
  late _StaminaWidgetViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = _StaminaWidgetViewModel(stamina: widget._stamina, staminaRepositoryService: injector<StaminaRepositoryService>());
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      viewModel.decrementTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    String imageName = (viewModel._stamina.imageName ?? '').isEmpty ? 'waveplate.png' : viewModel._stamina.imageName!;

    return InkWell(
      onDoubleTap: () async {
        await viewModel.resetStaminaTo(staminaLevel: 0);
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return DeleteConfirmationDialog(
              onDelete: () {
                widget._onDelete(widget._stamina);
              },
              itemName: widget._stamina.gachaTitle,
            );
          },
        );
      },
      child: Card(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 40, height: 40, child: Image.asset('assets/$imageName')),
            ValueListenableBuilder<int>(
              valueListenable: viewModel.currentStamina,
              builder: (context, currentStamnina, _) {
                return Padding(
                  padding: UIFormating.smallPadding(),
                  child: Text('$currentStamnina/${viewModel.maxStamina}', style: const TextStyle(fontSize: 24)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StaminaWidgetViewModel extends ChangeNotifier {
  final ValueNotifier<int> currentStamina = ValueNotifier<int>(0);
  final ValueNotifier<int> timeUntilNextStaminaInSeconds = ValueNotifier<int>(0);
  final Stamina _stamina;
  final StaminaRepositoryService _staminaRepositoryService;

  _StaminaWidgetViewModel({required Stamina stamina, required StaminaRepositoryService staminaRepositoryService})
    : _stamina = stamina,
      _staminaRepositoryService = staminaRepositoryService {
    currentStamina.value = _computeCurrentStamina(_stamina.rechargeTime, _stamina.timeOfLastReset, _stamina.staminaOfLastestReset);
    timeUntilNextStaminaInSeconds.value = _computeTimeUntilNextRefreshInSeconds(_stamina.rechargeTime, _stamina.timeOfLastReset);
  }

  int get maxStamina => _stamina.maxStamina;

  Future<void> resetStaminaTo({int staminaLevel = 0}) async {
    currentStamina.value = staminaLevel;
    _stamina.staminaOfLastestReset = staminaLevel;
    _stamina.timeOfLastReset = DateTime.now();

    await _staminaRepositoryService.updateStamina(_stamina);
    notifyListeners();
  }

  void decrementTimer() {
    if (timeUntilNextStaminaInSeconds.value > 0) {
      timeUntilNextStaminaInSeconds.value--;
    } else {
      timeUntilNextStaminaInSeconds.value = _stamina.rechargeTime.inSeconds;
      currentStamina.value++;
    }
  }

  void spendStaminaTo(int? stamina) {
    timeUntilNextStaminaInSeconds.value = 0;
    currentStamina.value = stamina ?? 0;
  }

  int _computeTimeUntilNextRefreshInSeconds(Duration rechargeTime, DateTime timeOfLastRecharge) {
    Duration timeSinceLastRecharge = DateTime.now().difference(timeOfLastRecharge);
    int secondsIntoCurrentCycle = timeSinceLastRecharge.inSeconds % rechargeTime.inSeconds;

    return rechargeTime.inSeconds - secondsIntoCurrentCycle;
  }

  int _computeCurrentStamina(Duration rechargeTime, DateTime timeOfLastRecharge, int staminaOfLastReset) {
    Duration timeSinceLastRecharge = DateTime.now().difference(timeOfLastRecharge);
    return (timeSinceLastRecharge.inSeconds / rechargeTime.inSeconds).floor() + staminaOfLastReset;
  }
}
