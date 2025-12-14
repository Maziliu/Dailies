import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:dailies_v2/ui/views/overview/carousel/event_carousel.dart';
import 'package:dailies_v2/ui/views/overview/gacha/gacha_section.dart';
import 'package:dailies_v2/ui/views/overview/upcoming/upcoming_section.dart';
import 'package:dailies_v2/ui/views/widgets/events_list.dart';
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
                EventsList(events: fakeTodayEvents()),
                EventsList(events: fakeTodayEvents()),
                EventsList(events: fakeTodayEvents()),
              ],
            ),
            const UpcomingSection(),
          ],
        ),
      ),
    );
  }
}

List<EventModel> fakeTodayEvents() {
  final now = DateTime.now();
  final day = DateTime(now.year, now.month, now.day);

  return [
    EventModel(
      id: 1,
      uid: 'uid-1',
      calendarId: 'calendar-local',

      title: 'Daily Standup',
      description: 'Team sync',
      location: 'Office',

      start: day.add(const Duration(hours: 9)),
      end: day.add(const Duration(hours: 9, minutes: 30)),

      timezone: 'local',
      status: 'CONFIRMED',

      createdAt: now,
      lastModified: now,
    ),

    EventModel(
      id: 2,
      uid: 'uid-2',
      calendarId: 'calendar-local',

      title: 'Gym',
      location: 'Fitness Center',

      start: day.add(const Duration(hours: 18)),
      duration: const Duration(hours: 1),

      timezone: 'local',
      status: 'CONFIRMED',

      createdAt: now,
      lastModified: now,
    ),
    EventModel(
      id: 3,
      uid: 'uid-3',
      calendarId: 'calendar-local',

      title: 'Gym',
      location: 'Fitness Center',

      start: day.add(const Duration(hours: 18)),
      duration: const Duration(hours: 1),

      timezone: 'local',
      status: 'CONFIRMED',

      createdAt: now,
      lastModified: now,
    ),
    EventModel(
      id: 4,
      uid: 'uid-4',
      calendarId: 'calendar-local',

      title: 'Gym',
      location: 'Fitness Center',

      start: day.add(const Duration(hours: 18)),
      duration: const Duration(hours: 1),

      timezone: 'local',
      status: 'CONFIRMED',

      createdAt: now,
      lastModified: now,
    ),
  ];
}
