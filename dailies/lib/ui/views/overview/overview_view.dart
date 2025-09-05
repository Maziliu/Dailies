import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/overview/gacha%20section/gacha_section.dart';
import 'package:dailies/ui/views/overview/overview_page_view_model.dart';
import 'package:dailies/ui/views/overview/sections/today%20section/today_section.dart';
import 'package:dailies/ui/views/overview/sections/gacha%20section/gacha_section.dart';
import 'package:dailies/ui/views/overview/sections/upcoming%20section/upcoming_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageViewModel = context.watch<OverviewPageViewModel>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: UIFormating.mediumPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GachaSection(viewModel: pageViewModel.staminaViewModel),
            UIFormating.mediumVerticalSpacing(),
            TodaySection(eventsViewModel: pageViewModel.eventsViewModel),
            UIFormating.mediumVerticalSpacing(),
            UpcomingSection(eventsViewModel: pageViewModel.eventsViewModel),
          ],
        ),
      ),
    );
  }
}
