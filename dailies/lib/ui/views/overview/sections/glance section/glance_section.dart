import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:dailies/common/app_constants.dart';
import 'package:dailies/common/utils/build_context_extensions.dart';
import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/ui/components/schedule/schedule_item_widget.dart';
import 'package:dailies/ui/components/schedule/schedule_list_view_widget.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/overview/sections/glance%20section/glance_section_view_model.dart';
import 'package:dailies/ui/views/overview/sections/glance%20section/sub%20sections/today_sub_section.dart';
import 'package:dailies/ui/views/overview/sections/glance%20section/sub%20sections/tomorrow_sub_section.dart';
import 'package:dailies/ui/views/overview/sections/glance%20section/sub%20sections/week_sub_section.dart';
import 'package:dailies/ui/views/shared/events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GlanceSection extends StatelessWidget {
  final EventsViewModel _eventsViewModel;
  final PageController _pageController;
  final GlanceSectionViewModel _glanceSectionViewModel;

  const GlanceSection({
    super.key,
    required EventsViewModel eventsViewModel,
    required PageController pageController,
    required GlanceSectionViewModel glanceSectionViewModel,
  }) : _eventsViewModel = eventsViewModel,
       _pageController = pageController,
       _glanceSectionViewModel = glanceSectionViewModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _glanceSectionViewModel.selectedTabIndex,
      builder: (context, index, pageIndicator) {
        return Column(
          children: [
            Padding(
              padding: UIFormating.smallPadding(),
              child: IndexedStack(
                index: index,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Expanded(child: Text('Today', style: context.textTheme.headlineLarge)), Text(DateFormat.yMMMMd().format(DateTime.now()))],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Text('Tomorrow', style: context.textTheme.headlineLarge)),
                      Text(DateFormat.yMMMMd().format(DateTime.now().add(const Duration(days: 1)))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Text('Week', style: context.textTheme.headlineLarge)),
                      Text(
                        '${DateFormat.MMMM().format(DateTime.now())} ${DateFormat.d().format(DateTime.now())} - ${DateFormat.d().format(DateTime.now().add(const Duration(days: 7)))}, ${DateFormat.y().format(DateTime.now())}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MAX_SECTION_HEIGHT,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => _glanceSectionViewModel.selectedTabIndex.value = index,
                children: [
                  TodaySubSection(eventsViewModel: _eventsViewModel),
                  TomorrowSubSection(eventsViewModel: _eventsViewModel),
                  WeekSubSection(eventsViewModel: _eventsViewModel),
                ],
              ),
            ),

            if (pageIndicator != null) pageIndicator,
          ],
        );
      },
      child: Padding(
        padding: const EdgeInsetsGeometry.fromLTRB(0, 16, 0, 8),
        child: SmoothPageIndicator(
          controller: _pageController,
          count: 3,
          effect: WormEffect(dotHeight: 6, dotWidth: 6, activeDotColor: context.colorScheme.primary),
        ),
      ),
    );
  }
}
