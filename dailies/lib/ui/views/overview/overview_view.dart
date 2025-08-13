import 'package:dailies/dependency_setup.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/overview/overview_page_view_model.dart';
import 'package:dailies/ui/views/overview/schedule%20section/schedule_section.dart';
import 'package:dailies/ui/views/overview/gacha%20section/gacha_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    OverviewPageViewModel pageViewModel = context.watch<OverviewPageViewModel>();

    return Padding(
      padding: UIFormating.smallPadding(),
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GachaSection(viewModel: pageViewModel.staminaViewModel),
            UIFormating.extraLargeVerticalSpacing(),
            ScheduleSection(eventsViewModel: pageViewModel.eventsViewModel),
          ],
        ),
      ),
    );
  }
}
