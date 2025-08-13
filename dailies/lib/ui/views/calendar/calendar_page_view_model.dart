import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/ui/views/calendar/calendar_view_model.dart';
import 'package:dailies/ui/views/shared%20view%20models/events_view_model.dart';
import 'package:flutter/material.dart';

class CalendarPageViewModel extends ChangeNotifier {
  final CalendarViewModel calendarViewModel;
  final EventsViewModel eventsViewModel;

  List<EventTimeSlotPair> _flattenedEvents = [];
  List<EventTimeSlotPair> get flattenedEvents => _flattenedEvents;

  late VoidCallback listener = () => _updateFlattenedEvents(calendarViewModel.selectedDay);

  CalendarPageViewModel({required this.calendarViewModel, required this.eventsViewModel}) {
    calendarViewModel.selectedDayNotifier.addListener(listener);
    eventsViewModel.loadedEventsNotifier.addListener(listener);

    _initialize();
  }

  Future<void> _initialize() async {
    await eventsViewModel.loadEventsAround(calendarViewModel.selectedDay);
    _updateFlattenedEvents(calendarViewModel.selectedDay);
  }

  Future<void> _updateFlattenedEvents(DateTime selectedDay) async {
    final eventsForDay = await eventsViewModel.getEventsForDay(selectedDay);
    _flattenedEvents = eventsForDay.expand((event) => event.timeSlots.map((slot) => EventTimeSlotPair(first: event, second: slot))).toList();
    notifyListeners();
  }

  void onDaySelect(DateTime day) {
    calendarViewModel.onDaySelect(day);
  }

  Future<void> onAddEvent(String eventName, String? location, DateTime? startTime, DateTime? endTime) async {
    final event = Event(
      eventName: eventName,
      location: location,
      timeSlot: TimeSlot(dateOfTimeSlot: calendarViewModel.selectedDay, startTime: startTime, endTime: endTime),
    );
    await eventsViewModel.addEvent(event);
  }

  Future<void> deleteEvent(Event event) async {
    await eventsViewModel.deleteEvent(event);
  }

  @override
  void dispose() {
    calendarViewModel.selectedDayNotifier.removeListener(listener);
    eventsViewModel.loadedEventsNotifier.removeListener(listener);
    super.dispose();
  }
}
