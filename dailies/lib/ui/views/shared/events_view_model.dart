import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/service/repository/event_repository_service.dart';
import 'package:dailies/ui/mixins/service_view_model_mixin.dart';
import 'package:flutter/material.dart';

class EventsViewModel with ServiceViewModelMixin {
  final EventRepositoryService _eventRepositoryService;
  final ValueNotifier<List<EventTimeSlotPair>> todayLoadedFlattenedEventsNotifier = ValueNotifier([]);
  final ValueNotifier<List<EventTimeSlotPair>> selectedFlattenedEventsNotifier = ValueNotifier([]);
  final ValueNotifier<List<Event>> loadedEventsNotifier = ValueNotifier([]);
  late DateTime _currentLowerBound, _currentUpperBound;

  EventsViewModel({required EventRepositoryService eventRepositoryService}) : _eventRepositoryService = eventRepositoryService;

  //"Around" means entirety of last, this, and next month
  Future<void> loadEventsAround(DateTime day) async {
    _currentLowerBound = DateTime(day.month == 1 ? day.year - 1 : day.year, day.month == 1 ? 12 : day.month - 1, 1);

    DateTime firstDayMonthAfterUpperBound = DateTime(day.month >= 11 ? day.year + 1 : day.year, (day.month + 2) % 12 == 0 ? 12 : (day.month + 2) % 12, 1);
    _currentUpperBound = firstDayMonthAfterUpperBound.subtract(const Duration(days: 1));

    final result = await _eventRepositoryService.fetchAllEventsBetweenDates(_currentLowerBound, _currentUpperBound);
    switch (result) {
      case Ok<List<Event>>(value: final List<Event> events):
        loadedEventsNotifier.value = events;
        _updateTodaysEvents();

      case Error<List<Event>>(error: final Exception exception):
        updateViewModelErrors(exception);
    }
  }

  Future<void> updateSelectedFlattenedEvents(DateTime selectedDay) async {
    final eventsForDay = await getEventsForDay(selectedDay);
    selectedFlattenedEventsNotifier.value =
        eventsForDay.expand((event) => event.timeSlots.map((slot) => EventTimeSlotPair(first: event, second: slot))).toList();
  }

  void _updateTodaysEvents() {
    List<Event> events = loadedEventsNotifier.value.where((event) => event.timeSlots.any((slot) => slot.isSameDay(DateTime.now()))).toSet().toList()..sort();

    todayLoadedFlattenedEventsNotifier.value =
        events.expand((event) => event.timeSlots.map((timeSlot) => EventTimeSlotPair(first: event, second: timeSlot))).toList();
  }

  Future<void> _loadMonthsEventsOutsideBounds(DateTime day) async {
    if (day.isAfter(_currentLowerBound) && day.isBefore(_currentUpperBound)) return;

    DateTime endOfTheMonth = DateTime(day.month == 12 ? day.year + 1 : day.year, day.month == 12 ? 1 : day.month + 1, 1).subtract(const Duration(days: 1));

    DateTime beginningOfTheMonth = DateTime(day.month == 1 ? day.year - 1 : day.year, day.month == 1 ? 12 : day.month - 1, 1);

    DateTime? lowerBound;
    DateTime? upperBound;

    if (day.isAfter(_currentUpperBound)) {
      lowerBound = _currentUpperBound.add(const Duration(days: 1));
      upperBound = endOfTheMonth;
    } else if (day.isBefore(_currentLowerBound)) {
      lowerBound = beginningOfTheMonth;
      upperBound = _currentLowerBound.subtract(const Duration(days: 1));
    } else {
      return;
    }

    final result = await _eventRepositoryService.fetchAllEventsBetweenDates(lowerBound, upperBound);
    switch (result) {
      case Ok<List<Event>>(value: final List<Event> newEvents):
        loadedEventsNotifier.value = [...loadedEventsNotifier.value, ...newEvents];

        if (upperBound.isAfter(_currentUpperBound)) {
          _currentUpperBound = upperBound;
        }
        if (lowerBound.isBefore(_currentLowerBound)) {
          _currentLowerBound = lowerBound;
        }

      case Error<List<Event>>(error: final Exception exception):
        updateViewModelErrors(exception);
    }
  }

  Future<List<Event>> getEventsForDay(DateTime day) async {
    await _loadMonthsEventsOutsideBounds(day);

    return loadedEventsNotifier.value.where((event) => event.timeSlots.any((timeSlot) => timeSlot.isSameDay(day))).toSet().toList()..sort();
  }

  Future<void> addEvent(Event event) async {
    final result = await _eventRepositoryService.saveEvent(event);
    switch (result) {
      case Ok<int>(value: final int eventId):
        event.id = eventId;
        loadedEventsNotifier.value = [...loadedEventsNotifier.value, event];

        if (event.timeSlots.first.isSameDay(DateTime.now())) _updateTodaysEvents();
      case Error<int>(error: final Exception exception):
        updateViewModelErrors(exception);
    }
  }

  Future<void> deleteEvent(Event event) async {
    await _eventRepositoryService.deleteEvent(event);
    loadedEventsNotifier.value = loadedEventsNotifier.value.where((e) => e.id != event.id).toList();

    if (event.timeSlots.first.isSameDay(DateTime.now())) _updateTodaysEvents();
  }

  void dispose() {
    todayLoadedFlattenedEventsNotifier.dispose();
    loadedEventsNotifier.dispose();
  }
}
