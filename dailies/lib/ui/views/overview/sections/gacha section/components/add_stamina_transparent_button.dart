import 'package:dailies/ui/components/hero_dialog_route.dart';
import 'package:dailies/ui/components/popup%20cards/popup_card.dart';
import 'package:dailies/ui/views/overview/sections/gacha%20section/gacha_view_model.dart';
import 'package:flutter/material.dart';

const String ADD_STAMINA_HERO_TAG = 'addStaminaHeroTag';

class AddStaminaTransparentButton extends StatelessWidget {
  final GachaViewModel _viewModel;

  const AddStaminaTransparentButton({super.key, required GachaViewModel viewModel}) : _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            HeroDialogRoute(
              builder: (_) {
                return PopupCard.AddStamina(onSubmit: _viewModel.onAddStaminaButtonPress, heroTag: ADD_STAMINA_HERO_TAG);
              },
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color.fromRGBO(158, 158, 158, 0.5)),
            color: Colors.transparent,
          ),
          child: const Icon(Icons.add, color: Colors.grey),
        ),
      ),
    );
  }
}
