import 'package:dailies/common/app_constants.dart';
import 'package:dailies/data/models/stamina.dart';
import 'package:dailies/ui/components/hero_dialog_route.dart';
import 'package:dailies/ui/components/popup%20cards/popup_card.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/overview/sections/gacha%20section/components/add_stamina_transparent_button.dart';
import 'package:dailies/ui/views/overview/sections/gacha%20section/components/stamina_widget.dart';
import 'package:dailies/ui/views/overview/sections/gacha%20section/gacha_view_model.dart';
import 'package:flutter/material.dart';

class GachaSection extends StatelessWidget {
  final GachaViewModel _viewModel;

  const GachaSection({super.key, required GachaViewModel viewModel}) : _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return ValueListenableBuilder<List<Stamina>>(
      valueListenable: _viewModel.staminas,
      builder: (context, staminas, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: UIFormating.smallPadding(), child: Text('Gachas', style: textTheme.headlineLarge)),
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: staminas.length,
              itemBuilder: (_, index) => StaminaWidget(key: ValueKey(staminas[index].id), stamina: staminas[index], onDelete: _viewModel.deleteStamina),
            ),
            AddStaminaTransparentButton(viewModel: _viewModel),
          ],
        );
      },
    );
  }
}
