import 'package:dailies/data/models/stamina.dart';
import 'package:dailies/dependency_setup.dart';
import 'package:dailies/ui/components/hero_dialog_route.dart';
import 'package:dailies/ui/components/popup%20cards/popup_card.dart';
import 'package:dailies/ui/components/stamina%20widget/stamina_widget.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/overview/overview_view_model.dart';
import 'package:dailies/ui/views/overview/schedule_section.dart';
import 'package:dailies/ui/views/shared%20view%20models/events_view_model.dart';
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

  Widget _buildGachaSection() {
    final OverviewViewModel viewModel = Provider.of<OverviewViewModel>(context);
    return ValueListenableBuilder<List<Stamina>>(
      valueListenable: viewModel.staminas,
      builder: (context, staminas, child) {
        return Wrap(
          children: staminas.map((Stamina stamina) => StaminaWidget(key: ValueKey(stamina.id), stamina: stamina, onDelete: viewModel.deleteStamina)).toList(),
        );
      },
    );
  }

  Widget _buildScheduleSection() => ScheduleSection(eventsViewModel: injector<EventsViewModel>());

  Widget _buildFloatingActionButton() => FloatingActionButton(
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
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIFormating.smallPadding(),
      child: Scaffold(
        body: Column(mainAxisSize: MainAxisSize.min, children: [_buildGachaSection(), UIFormating.extraLargeVerticalSpacing(), _buildScheduleSection()]),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }
}
