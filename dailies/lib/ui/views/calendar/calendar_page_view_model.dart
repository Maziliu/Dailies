import 'package:dailies/ui/views/shared/calendar_view_model.dart';
import 'package:dailies/ui/views/shared/events_view_model.dart';
import 'package:flutter/material.dart';

class CalendarPageViewModel extends ChangeNotifier {
  final CalendarViewModel calendarViewModel;
  final EventsViewModel eventsViewModel;

  CalendarPageViewModel({required this.calendarViewModel, required this.eventsViewModel}) {
    Future.microtask(_initialize);
  }

  Future<void> _initialize() async {
    await eventsViewModel.loadEventsAround(calendarViewModel.selectedDay);
  }
}
