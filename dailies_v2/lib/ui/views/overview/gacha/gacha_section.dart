import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/ui/modals/add_gacha.dart';
import 'package:dailies_v2/ui/state/gacha_view_model.dart';
import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/views/widgets/item_list.dart';
import 'package:dailies_v2/ui/views/widgets/section_card.dart';
import 'package:dailies_v2/ui/views/widgets/stamina_list_item.dart';
import 'package:flutter/material.dart';

class GachaSection extends StatelessWidget {
  final GachaViewModel viewModel = GACHA_VIEW_MODEL;

  GachaSection({super.key});

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

    viewModel.insertStamina(result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SectionCard(
      padding: EdgeInsetsGeometry.fromLTRB(16, 12, 16, 12),
      child: ValueListenableBuilder<List<StaminaModel>>(
        valueListenable: viewModel.staminas,
        builder: (context, staminas, _) {
          return Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsGeometry.only(left: 4, right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Gachas', style: theme.textTheme.headlineLarge),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: IconButton(
                        onPressed: () => showAddStaminaDialog(context),
                        icon: Icon(
                          Icons.add,
                          size: 24,
                          color: theme.colorScheme.primary,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ],
                ),
              ),

              if (staminas.isNotEmpty)
                ItemList(
                  items: staminas,
                  itemBuilder: (stamina) {
                    return StaminaListItem(
                      stamina: stamina,
                      onDelete: () => viewModel.deleteStamina(stamina),
                      onReset: () => viewModel.spendStamina(stamina),
                      onSpend: (int amount) =>
                          viewModel.spendStamina(stamina, amount: amount),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
