import 'package:dailies/data/models/stamina.dart';
import 'package:dailies/ui/components/hero_dialog_route.dart';
import 'package:dailies/ui/components/popup%20cards/popup_card.dart';
import 'package:dailies/ui/components/stamina%20widget/stamina_widget.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/overview/gacha%20section/gacha_view_model.dart';
import 'package:flutter/material.dart';

const String ADD_STAMINA_HERO_TAG = 'addStaminaHeroTag';

class GachaSection extends StatelessWidget {
  final GachaViewModel _viewModel;

  const GachaSection({super.key, required GachaViewModel viewModel}) : _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Stamina>>(
      valueListenable: _viewModel.staminas,
      builder: (context, staminas, child) {
        return Wrap(
          children: [
            ...staminas.map((Stamina stamina) => StaminaWidget(key: ValueKey(stamina.id), stamina: stamina, onDelete: _viewModel.deleteStamina)),
            _addStaminaTransparentButton(context),
          ],
        );
      },
    );
  }

  Widget _addStaminaTransparentButton(BuildContext context) => OutlinedButton(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: Color.fromRGBO(158, 158, 158, 0.5)),
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(17),
      backgroundColor: Colors.transparent,
    ),
    onPressed: () {
      Navigator.of(context).push(
        HeroDialogRoute(
          builder: (_) {
            return PopupCard.AddStamina(onSubmit: _viewModel.onAddStaminaButtonPress, heroTag: ADD_STAMINA_HERO_TAG);
          },
        ),
      );
    },
    child: const Icon(Icons.add, color: Colors.grey),
  );
}
