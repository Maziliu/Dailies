import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/ui/modals/add_stamina.dart';
import 'package:dailies_v2/ui/modals/confirmation.dart';
import 'package:dailies_v2/ui/modals/spend_stamina.dart';
import 'package:dailies_v2/ui/state/gacha_view_model.dart';
import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/views/widgets/item_list.dart';
import 'package:dailies_v2/ui/views/widgets/section_card.dart';
import 'package:dailies_v2/ui/views/widgets/stamina_list_item.dart';
import 'package:flutter/material.dart';

class GachaSection extends StatefulWidget {
  const GachaSection({super.key});

  @override
  State<GachaSection> createState() => _GachaSectionState();
}

class _GachaSectionState extends State<GachaSection> {
  final GachaViewModel viewModel = GACHA_VIEW_MODEL;

  Future<void> showAddStaminaDialog(BuildContext context) async {
    final result = await showDialog<StaminaModel>(
      context: context,
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
  void initState() {
    super.initState();
    viewModel.loadAllStaminas();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SectionCard(
      padding: const EdgeInsetsGeometry.fromLTRB(16, 12, 16, 12),
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
                      onDelete: () async {
                        final result = await showDialog<bool>(
                          context: context,
                          builder: (_) => ConfirmationModal(
                            title: 'Delete ${stamina.gachaTitle}?',
                            message: 'This action cannot be undone.',
                            confirmText: 'Delete',
                            destructive: true,
                          ),
                        );

                        if (result == null || result == false) return;

                        viewModel.deleteStamina(stamina);
                      },
                      onReset: () => viewModel.setStamina(stamina),
                      onSetStamina: () async {
                        final int? amount = await showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              insetPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 24,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const SpendStaminaModal(),
                            );
                          },
                        );

                        if (amount == null) return;

                        viewModel.setStamina(stamina, amount: amount);
                      },
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
