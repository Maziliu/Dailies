import 'package:dailies_v2/models/gacha_stamina_model.dart';
import 'package:dailies_v2/ui/state/gacha_view_model.dart';
import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/views/widgets/section_card.dart';
import 'package:flutter/material.dart';

class GachaSection extends StatelessWidget {
  const GachaSection({super.key});

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
                IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
              ],
            ),
          ),
          ValueListenableBuilder<List<GachaStaminaModel>>(
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
