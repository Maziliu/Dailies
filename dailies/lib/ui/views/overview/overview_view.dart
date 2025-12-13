import 'package:dailies/ui/components/section_card.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/overview/overview_page_view_model.dart';
import 'package:dailies/ui/views/overview/sections/gacha%20section/gacha_section.dart';
import 'package:dailies/ui/views/overview/sections/glance%20section/glance_section.dart';
import 'package:dailies/ui/views/overview/sections/glance%20section/glance_section_view_model.dart';
import 'package:dailies/ui/views/overview/sections/upcoming%20section/upcoming_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageViewModel = context.watch<OverviewPageViewModel>();
    final PageController glancePageController = PageController();
    final GlanceSectionViewModel glanceSectionViewModel =
        GlanceSectionViewModel();

    return Scaffold(
      body: SingleChildScrollView(
        padding: UIFormating.mediumPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionCard(
              child: GachaSection(viewModel: pageViewModel.staminaViewModel),
            ),
            UIFormating.mediumVerticalSpacing(),
            SectionCard(
              child: GlanceSection(
                eventsViewModel: pageViewModel.eventsViewModel,
                glanceSectionViewModel: glanceSectionViewModel,
                pageController: glancePageController,
              ),
            ),
            UIFormating.mediumVerticalSpacing(),
            SectionCard(
              child: UpcomingSection(
                eventsViewModel: pageViewModel.eventsViewModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
