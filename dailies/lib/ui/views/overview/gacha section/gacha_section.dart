import 'package:dailies/data/models/stamina.dart';
import 'package:dailies/ui/components/hero_dialog_route.dart';
import 'package:dailies/ui/components/popup%20cards/popup_card.dart';
import 'package:dailies/ui/components/stamina%20widget/stamina_widget.dart';
import 'package:dailies/ui/views/overview/gacha%20section/gacha_view_model.dart';
import 'package:flutter/material.dart';

const String ADD_STAMINA_HERO_TAG = 'addStaminaHeroTag';

class GachaSection extends StatelessWidget {
  final GachaViewModel _viewModel;

  const GachaSection({super.key, required GachaViewModel viewModel}) : _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.fromLTRB(16, 16, 16, 0),
      child: ValueListenableBuilder<List<Stamina>>(
        valueListenable: _viewModel.staminas,
        builder: (context, staminas, child) {
          return GridView.count(
            childAspectRatio: 3,
            crossAxisCount: 2,
            shrinkWrap: true,
            children: [
              ...staminas.map((stamina) => StaminaWidget(key: ValueKey(stamina.id), stamina: stamina, onDelete: _viewModel.deleteStamina)),
              _addStaminaTransparentButton(context),
            ],
          );
        },
      ),
    );
  }

  Widget _addStaminaTransparentButton(BuildContext context) => Padding(
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
