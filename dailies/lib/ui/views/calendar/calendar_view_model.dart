import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/service/repository/event_repository_service.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewModel extends ChangeNotifier {
  final EventRepositoryService _eventRepositoryService;
  DateTime _selectedDay = DateTime.now();
  List<Event> _currentAndAdjacentMonthsEvents = [];
  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);
  ValueNotifier<List<Event>> get selectedEvents => _selectedEvents;
  DateTime get selectedDay => _selectedDay;

  CalendarViewModel({required EventRepositoryService eventRepositoryService}) : _eventRepositoryService = eventRepositoryService;

  Future<void> initialize() async {
    await loadEventsFromCurrentAndAdjacentMonths();
    _selectedEvents.value = getEventsForSpecificDay(_selectedDay);

    notifyListeners();
  }

  void onAddEventButtonPress(String eventName, String? location, DateTime? startTime, DateTime? endTime) async {
    TimeSlot timeSlot = TimeSlot(dateOfTimeSlot: _selectedDay, startTime: startTime, endTime: endTime);
    Event event = Event(eventName: eventName, location: location, timeSlot: timeSlot);

    print(((await _eventRepositoryService.saveEvent(event)) as Ok).value);
  }

  Future<void> loadEventsFromCurrentAndAdjacentMonths() async {
    DateTime lowerBound = _selectedDay.subtract(const Duration(days: 30)), upperBound = _selectedDay.add(const Duration(days: 30));

    print(lowerBound.toString());
    print(upperBound.toString());

    Result<List<Event>> eventsResult = await _eventRepositoryService.fetchAllEventsBetweenDates(lowerBound, upperBound);

    switch (eventsResult) {
      case Ok<List<Event>>(value: final events):
        _currentAndAdjacentMonthsEvents = events;
        print(events);
      case Error<List<Event>>():
        print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
    }
  }

  List<Event> getEventsForSpecificDay(DateTime specificDay) {
    List<Event> filteredEvents = [];
    for (final Event event in _currentAndAdjacentMonthsEvents) {
      for (final TimeSlot timeSlot in event.timeSlots) {
        if (timeSlot.isSameDay(specificDay)) {
          filteredEvents.add(event);
        }
      }
    }

    filteredEvents.sort();

    return filteredEvents;
  }

  void onDaySelect(DateTime selectedDay) {
    if (!isSameDay(selectedDay, _selectedDay)) {
      _selectedDay = selectedDay;
      _selectedEvents.value = getEventsForSpecificDay(selectedDay);
      notifyListeners();
    }
  }
}
