import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:dailies_v2/ui/views/overview/carousel/event_carousel.dart';
import 'package:dailies_v2/ui/views/overview/gacha/gacha_section.dart';
import 'package:dailies_v2/ui/views/overview/upcoming/upcoming_section.dart';
import 'package:dailies_v2/ui/widgets/events_list.dart';
import 'package:flutter/material.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: UIFormating.mediumPadding(),
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GachaSection(),
            ValueListenableBuilder(
              valueListenable: EVENTS_VIEW_MODEL.isLoaded,
              builder: (_, _, _) => EventCarousel(
                pages: [
                  EventsList(
                    events: EVENTS_VIEW_MODEL.getInstancesByDate(
                      DateTime.now(),
                    ),
                  ),
                  EventsList(
                    events: EVENTS_VIEW_MODEL.getInstancesByDate(
                      DateTime.now().add(const Duration(days: 1)),
                    ),
                  ),
                  EventsList(
                    events: EVENTS_VIEW_MODEL.getInstancesByDateRangeInclusive(
                      DateTime.now(),
                      DateTime.now().add(const Duration(days: 7)),
                    ),
                  ),
                ],
              ),
            ),
            const UpcomingSection(),
          ],
        ),
      ),
    );
  }
}
