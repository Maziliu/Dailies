import 'package:dailies/ui/components/section_card.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/calendar/calendar_page_view_model.dart';
import 'package:dailies/ui/views/calendar/sections/calendar_section.dart';
import 'package:dailies/ui/views/calendar/sections/events_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final DateTime FIRST_CALENDAR_DAY = DateTime.utc(2003, 05, 14);
final DateTime LAST_CALENDAR_DAY = DateTime.utc(2100, 12, 31);
final String ADD_EVENT_HERO_TAG = 'addEventHeroTag';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarPageViewModel pageViewModel = context.watch<CalendarPageViewModel>();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Calendar', style: textTheme.headlineLarge?.copyWith(fontSize: 24))),
      body: SingleChildScrollView(
        child: Padding(
          padding: UIFormating.mediumPadding(),
          child: Column(
            children: [
              SectionCard(child: CalendarSection(calendarViewModel: pageViewModel.calendarViewModel)),
              UIFormating.mediumVerticalSpacing(),
              SectionCard(child: EventsSection(eventsViewModel: pageViewModel.eventsViewModel)),
            ],
          ),
        ),
      ),
    );
  }
}
