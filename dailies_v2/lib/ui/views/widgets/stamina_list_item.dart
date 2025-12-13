import 'dart:async';
import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:flutter/material.dart';

class StaminaListItem extends StatefulWidget {
  final StaminaModel stamina;
  final void Function(StaminaModel) onDelete;

  const StaminaListItem(this.stamina, this.onDelete, {super.key});

  @override
  State<StaminaListItem> createState() => _StaminaListItemState();
}

class _StaminaListItemState extends State<StaminaListItem> {
  late final StaminaListItemViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = StaminaListItemViewModel(widget.stamina)..start();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: viewModel,
      builder: (_, child) {
        return InkWell(
          key: ValueKey(widget.stamina.id),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onDoubleTap: viewModel.resetStamina,
          child: Card(
            elevation: 0,
            color: Colors.black26,
            child: Padding(
              padding: EdgeInsetsGeometry.fromLTRB(8, 8, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  child ?? SizedBox.shrink(),
                  Text(
                    '${viewModel.currentStamina} / ${viewModel.maxStamina}',
                    style: theme.textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Row(
        spacing: 8,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: Image.asset('assets/${viewModel.imageName}'),
          ),
          Text(
            widget.stamina.gachaTitle,
            style: theme.textTheme.headlineLarge,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class StaminaListItemViewModel extends ChangeNotifier {
  final StaminaModel _stamina;
  Timer? _timer;

  int _currentStamina = 0;
  int _timeUntilNextStamina = 0;

  StaminaListItemViewModel(this._stamina) {
    _recomputeFromModel();
  }

  int get currentStamina => _currentStamina;
  int get maxStamina => _stamina.maxStamina;

  String get imageName => (_stamina.imageName?.isNotEmpty ?? false)
      ? _stamina.imageName!
      : 'waveplate.png';

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void resetStamina({int value = 0}) {
    _stamina
      ..staminaOfLastestReset = value
      ..timeOfLastReset = DateTime.now();

    _recomputeFromModel();
    notifyListeners();
  }

  void spendStamina(int? value) {
    _stamina
      ..staminaOfLastestReset = value ?? 0
      ..timeOfLastReset = DateTime.now();

    _recomputeFromModel();
    notifyListeners();
  }

  void _tick() {
    if (_currentStamina >= maxStamina) return;

    if (_timeUntilNextStamina > 0) {
      _timeUntilNextStamina--;
    } else {
      _timeUntilNextStamina = _stamina.rechargeTime.inSeconds;
      _currentStamina++;
      notifyListeners();
    }
  }

  void _recomputeFromModel() {
    final now = DateTime.now();
    final elapsed = now.difference(_stamina.timeOfLastReset).inSeconds;
    final rechargeSeconds = _stamina.rechargeTime.inSeconds;

    final gained = elapsed ~/ rechargeSeconds;

    _currentStamina = (_stamina.staminaOfLastestReset + gained).clamp(
      0,
      maxStamina,
    );

    _timeUntilNextStamina = rechargeSeconds - (elapsed % rechargeSeconds);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
