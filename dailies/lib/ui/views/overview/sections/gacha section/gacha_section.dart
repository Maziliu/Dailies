import 'package:dailies/common/utils/build_context_extensions.dart';
import 'package:dailies/data/models/stamina.dart';
import 'package:dailies/ui/components/hero_dialog_route.dart';
import 'package:dailies/ui/components/popup%20cards/popup_card.dart';
import 'package:dailies/ui/views/overview/sections/gacha%20section/components/add_stamina_transparent_button.dart';
import 'package:dailies/ui/views/overview/sections/gacha%20section/components/stamina_widget.dart';
import 'package:dailies/ui/views/overview/sections/gacha%20section/gacha_view_model.dart';
import 'package:flutter/material.dart';

class GachaSection extends StatelessWidget {
  final GachaViewModel _viewModel;

  const GachaSection({super.key, required GachaViewModel viewModel}) : _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsGeometry.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Gachas', style: context.textTheme.headlineLarge),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    HeroDialogRoute(
                      builder: (_) {
                        return PopupCard.AddStamina(onSubmit: _viewModel.onAddStaminaButtonPress, heroTag: ADD_STAMINA_HERO_TAG);
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        ValueListenableBuilder<List<Stamina>>(
          valueListenable: _viewModel.staminas,
          builder: (context, staminas, child) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: staminas.length,
              itemBuilder: (_, index) => StaminaWidget(key: ValueKey(staminas[index].id), stamina: staminas[index], onDelete: _viewModel.deleteStamina),
            );
          },
        ),
      ],
    );
  }
}
