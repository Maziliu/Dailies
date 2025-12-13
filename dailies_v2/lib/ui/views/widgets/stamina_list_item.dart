import 'dart:async';
import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/ui/modals/confirmation_modal.dart';
import 'package:flutter/material.dart';

class StaminaListItem extends StatefulWidget {
  final StaminaModel stamina;
  final VoidCallback onDelete;
  final VoidCallback onReset;
  final void Function(int value) onSpend;

  const StaminaListItem({
    super.key,
    required this.stamina,
    required this.onDelete,
    required this.onReset,
    required this.onSpend,
  });

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
  void didUpdateWidget(covariant StaminaListItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.stamina != widget.stamina) {
      viewModel.updateModel(widget.stamina);
    }
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
      builder: (_, _) {
        return InkWell(
          key: ValueKey(widget.stamina.id),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onDoubleTap: widget.onReset,
          onLongPress: () async {
            final result = await showDialog<bool>(
              context: context,
              builder: (_) => ConfirmationModal(
                title: 'Delete ${widget.stamina.gachaTitle}?',
                message: 'This action cannot be undone.',
                confirmText: 'Delete',
                destructive: true,
              ),
            );

            if (result == null || result == false) return;

            widget.onDelete();
          },
          child: Card(
            elevation: 0,
            color: Colors.black26,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
    );
  }
}

class StaminaListItemViewModel extends ChangeNotifier {
  StaminaModel _stamina;
  Timer? _timer;

  int _currentStamina = 0;
  int _timeUntilNextStamina = 0;

  StaminaListItemViewModel(this._stamina) {
    _recompute();
  }

  int get currentStamina => _currentStamina;
  int get maxStamina => _stamina.maxStamina;

  String get imageName => (_stamina.imageName?.isNotEmpty ?? false)
      ? _stamina.imageName!
      : 'waveplate.png';

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void updateModel(StaminaModel stamina) {
    _stamina = stamina;
    _recompute();
    notifyListeners();
  }

  void _tick() {
    if (_timeUntilNextStamina > 0) {
      _timeUntilNextStamina--;
    } else {
      _timeUntilNextStamina = _stamina.rechargeTime.inSeconds;
      _currentStamina++;
      notifyListeners();
    }
  }

  void _recompute() {
    final now = DateTime.now();
    final elapsed = now.difference(_stamina.timeOfLastReset).inSeconds;
    final rechargeSeconds = _stamina.rechargeTime.inSeconds;

    final gained = elapsed ~/ rechargeSeconds;

    _currentStamina = _stamina.staminaOfLastestReset + gained;

    _timeUntilNextStamina = rechargeSeconds - (elapsed % rechargeSeconds);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
