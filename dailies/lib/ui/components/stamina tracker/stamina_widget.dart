import 'dart:async';

import 'package:dailies/data/models/stamina.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';

class StaminaWidget extends StatefulWidget {
  final Stamina _stamina;

  const StaminaWidget({super.key, required Stamina stamina}) : _stamina = stamina;

  @override
  State<StaminaWidget> createState() => _StaminaWidgetState();
}

class _StaminaWidgetState extends State<StaminaWidget> {
  Timer? timer;
  late _StaminaWidgetViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = _StaminaWidgetViewModel(stamina: widget._stamina);
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      viewModel.decrementTimer();
    });
  }

  @override
  void dispose() {
    //TODO: Save the current state of the timer and stam into the db before widget dies
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 40, height: 40, child: Image.asset('assets/${viewModel._stamina.imageName ?? ''}')),
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
    );
  }
}

class _StaminaWidgetViewModel extends ChangeNotifier {
  final ValueNotifier<int> currentStamina = ValueNotifier<int>(0);
  final ValueNotifier<int> timeUntilNextStaminaInSeconds = ValueNotifier<int>(0);
  final Stamina _stamina;

  int get maxStamina => _stamina.maxStamina;

  _StaminaWidgetViewModel({required Stamina stamina}) : _stamina = stamina {
    currentStamina.value = _computeCurrentStamina(_stamina.rechargeTime, _stamina.timeOfLastReset, _stamina.staminaOfLastestReset);
    timeUntilNextStaminaInSeconds.value = _computeTimeUntilNextRefreshInSeconds(_stamina.rechargeTime, _stamina.timeOfLastReset);
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
