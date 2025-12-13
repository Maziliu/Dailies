import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/ui/modals/add_gacha.dart';
import 'package:dailies_v2/ui/state/gacha_view_model.dart';
import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/views/widgets/section_card.dart';
import 'package:flutter/material.dart';

class GachaSection extends StatelessWidget {
  const GachaSection({super.key});

  Future<void> showAddStaminaDialog(BuildContext context) async {
    final result = await showDialog<StaminaModel>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const AddStaminaModal(),
        );
      },
    );

    if (result == null) return;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final GachaViewModel viewModel = GACHA_VIEW_MODEL;
    return SectionCard(
      padding: EdgeInsetsGeometry.fromLTRB(12, 0, 4, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.only(left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Gachas', style: theme.textTheme.headlineLarge),
                IconButton(
                  onPressed: () => showAddStaminaDialog(context),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<List<StaminaModel>>(
            valueListenable: viewModel.staminas,
            builder: (context, staminas, child) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: staminas.length,
                itemBuilder: (_, index) => Placeholder(),
              );
            },
          ),
        ],
      ),
    );
  }
}
