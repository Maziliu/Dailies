import 'package:dailies/data/models/event.dart';
import 'package:dailies/ui/components/hero_dialog_route.dart';
import 'package:dailies/ui/components/popup%20cards/popup_card.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/calendar/calendar%20section/calendar_section.dart';
import 'package:dailies/ui/views/calendar/calendar_page_view_model.dart';
import 'package:dailies/ui/views/calendar/events%20section/events_section.dart';
import 'package:dailies/ui/views/shared/calendar_view_model.dart';
import 'package:dailies/ui/views/shared/events_view_model.dart';
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

    return Padding(
      padding: UIFormating.smallPadding(),
      child: Column(
        children: [
          CalendarSection(calendarViewModel: pageViewModel.calendarViewModel),
          Expanded(child: EventsSection(eventsViewModel: pageViewModel.eventsViewModel, calendarViewModel: pageViewModel.calendarViewModel)),
        ],
      ),
    );
  }
}
