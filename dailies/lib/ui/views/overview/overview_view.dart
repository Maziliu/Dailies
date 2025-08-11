import 'package:dailies/data/models/stamina.dart';
import 'package:dailies/ui/components/hero_dialog_route.dart';
import 'package:dailies/ui/components/popup%20cards/popup_card.dart';
import 'package:dailies/ui/components/stamina%20widget/stamina_widget.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/overview/overview_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String ADD_STAMINA_HERO_TAG = 'addStaminaHeroTag';

class OverviewView extends StatefulWidget {
  const OverviewView({super.key});

  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (mounted) {
        OverviewViewModel viewModel = Provider.of<OverviewViewModel>(context, listen: false);
        await viewModel.initialize();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final OverviewViewModel viewModel = Provider.of<OverviewViewModel>(context);

    return Padding(
      padding: UIFormating.smallPadding(),
      child: Scaffold(
        body: Wrap(children: viewModel.staminas.value.map((Stamina stamina) => StaminaWidget(stamina: stamina, onDelete: viewModel.deleteStamina)).toList()),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          heroTag: ADD_STAMINA_HERO_TAG,
          child: const Icon(Icons.add),
          onPressed: () {
            final OverviewViewModel viewModel = Provider.of<OverviewViewModel>(context, listen: false);
            Navigator.of(context).push(
              HeroDialogRoute(
                builder: (_) {
                  return PopupCard.AddStamina(onSubmit: viewModel.onAddStaminaButtonPress, heroTag: ADD_STAMINA_HERO_TAG);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
