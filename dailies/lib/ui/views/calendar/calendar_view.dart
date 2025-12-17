import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:dailies_v2/ui/views/calendar/events/events_section.dart';
import 'package:dailies_v2/ui/widgets/calendar.dart';
import 'package:flutter/material.dart';

final DateTime FIRST_CALENDAR_DAY = DateTime.utc(2003, 05, 14);
final DateTime LAST_CALENDAR_DAY = DateTime.utc(2100, 12, 31);

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: UIFormating.mediumPadding(),
        child: const Column(
          spacing: 4,
          children: [
            CalendarWidget(),
            Expanded(child: EventsSection()),
          ],
        ),
      ),
    );
  }
}
