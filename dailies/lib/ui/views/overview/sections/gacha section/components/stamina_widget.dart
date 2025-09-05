import 'dart:async';

import 'package:dailies/data/models/stamina.dart';
import 'package:dailies/dependency_setup.dart';
import 'package:dailies/service/repository/stamina_repository_service.dart';
import 'package:dailies/ui/components/hero_dialog_route.dart';
import 'package:dailies/ui/components/popup%20cards/delete_confirmation_popup_card.dart';
import 'package:dailies/ui/components/popup%20cards/popup_card.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';

const String SET_STAMINA_HERO_TAG = 'setStaminaHeroTag';

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
      Future.microtask(() => viewModel.decrementTimer());
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String imageName = (viewModel._stamina.imageName ?? '').isEmpty ? 'waveplate.png' : viewModel._stamina.imageName!;
    final String heroTag = '$SET_STAMINA_HERO_TAG/${widget._stamina.id}';

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final Stamina stamina = widget._stamina;

    return InkWell(
      key: ValueKey(widget._stamina.id),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        final int? remainingStamina = await Navigator.push<int>(
          context,
          HeroDialogRoute(
            builder: (context) {
              return PopupCard.SetStamina(heroTag: heroTag);
            },
          ),
        );

        if (remainingStamina != null) {
          await viewModel.resetStaminaTo(staminaLevel: remainingStamina);
        }
      },
      onDoubleTap: () async {
        await viewModel.resetStaminaTo();
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
        child: Padding(
          padding: UIFormating.smallPadding(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 40, height: 40, child: Image.asset('assets/$imageName')),
                  UIFormating.smallHorizontalSpacing(),
                  Text(stamina.gachaTitle, style: textTheme.headlineLarge, overflow: TextOverflow.ellipsis),
                ],
              ),
              ValueListenableBuilder<int>(
                valueListenable: viewModel.currentStamina,
                builder: (context, currentStamnina, _) {
                  return Text('$currentStamnina / ${viewModel.maxStamina}', style: textTheme.headlineLarge);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StaminaWidgetViewModel extends ChangeNotifier {
  final ValueNotifier<int> currentStamina = ValueNotifier<int>(0);
  int _timeUntilNextStaminaInSeconds = 0;
  final Stamina _stamina;
  final StaminaRepositoryService _staminaRepositoryService;

  _StaminaWidgetViewModel({required Stamina stamina, required StaminaRepositoryService staminaRepositoryService})
    : _stamina = stamina,
      _staminaRepositoryService = staminaRepositoryService {
    currentStamina.value = _computeCurrentStamina(_stamina.rechargeTime, _stamina.timeOfLastReset, _stamina.staminaOfLastestReset);
    _timeUntilNextStaminaInSeconds = _computeTimeUntilNextRefreshInSeconds(_stamina.rechargeTime, _stamina.timeOfLastReset);
  }

  int get maxStamina => _stamina.maxStamina;

  Future<void> resetStaminaTo({int staminaLevel = 0}) async {
    currentStamina.value = staminaLevel;
    _stamina.staminaOfLastestReset = staminaLevel;
    _stamina.timeOfLastReset = DateTime.now();

    await _staminaRepositoryService.updateStamina(_stamina);
  }

  void decrementTimer() {
    if (_timeUntilNextStaminaInSeconds > 0) {
      _timeUntilNextStaminaInSeconds--;
    } else {
      _timeUntilNextStaminaInSeconds = _stamina.rechargeTime.inSeconds;
      currentStamina.value++;
    }
  }

  void spendStaminaTo(int? stamina) {
    _timeUntilNextStaminaInSeconds = 0;
    currentStamina.value = stamina ?? 0;
  }

  int _computeTimeUntilNextRefreshInSeconds(Duration rechargeTime, DateTime timeOfLastRecharge) {
    final Duration timeSinceLastRecharge = DateTime.now().difference(timeOfLastRecharge);
    final int secondsIntoCurrentCycle = timeSinceLastRecharge.inSeconds % rechargeTime.inSeconds;

    return rechargeTime.inSeconds - secondsIntoCurrentCycle;
  }

  int _computeCurrentStamina(Duration rechargeTime, DateTime timeOfLastRecharge, int staminaOfLastReset) {
    final Duration timeSinceLastRecharge = DateTime.now().difference(timeOfLastRecharge);
    return (timeSinceLastRecharge.inSeconds / rechargeTime.inSeconds).floor() + staminaOfLastReset;
  }
}
