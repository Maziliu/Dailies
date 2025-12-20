import 'package:dailies_v2/models/event.dart';
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
            EventCarousel(
              pages: [
                EventsList(events: fakeEvents()),
                EventsList(events: fakeEvents()),
                EventsList(events: fakeEvents()),
              ],
            ),
            const UpcomingSection(),
          ],
        ),
      ),
    );
  }
}

List<EventUIModel> fakeEvents() {
  final now = DateTime.now();
  final startDay = DateTime(now.year, now.month, now.day);

  int bucket(DateTime d) => d.year * 10000 + d.month * 100 + d.day;

  final List<EventUIModel> events = [];

  for (int i = 0; i < 7; i++) {
    final day = startDay.add(Duration(days: i));

    events.addAll([
      EventUIModel(
        date: DateTime.now(),
        start: day.add(const Duration(hours: 9)),
        end: day.add(const Duration(hours: 10)),
        title: 'Daily Standup',
        location: 'Office',
      ),
      EventUIModel(
        date: DateTime.now(),
        start: day.add(const Duration(hours: 18)),
        end: day.add(const Duration(hours: 19)),
        title: 'Gym',
        location: 'Fitness Center',
      ),
    ]);
  }

  return events;
}
