import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/service/repository/event_repository_service.dart';
import 'package:dailies/ui/mixins/error_stream_mixin.dart';
import 'package:dailies/ui/views/shared/calendar_view_model.dart';
import 'package:flutter/material.dart';

class EventsViewModel with ErrorStreamMixin {
  final CalendarViewModel _calendarViewModel;
  final EventRepositoryService _eventRepositoryService;
  final ValueNotifier<SplayTreeMap<DateTime, HeapPriorityQueue<TimeSlot>>> dateToTimeSlotsMap = ValueNotifier(SplayTreeMap());
  final Map<int, Event> _idToEventMap = {}; //Note: There is currently no culling logic for this (aside from adding and deleting events that proc a refresh).

  EventsViewModel({required CalendarViewModel calendarViewModel, required EventRepositoryService eventRepositoryService})
    : _calendarViewModel = calendarViewModel,
      _eventRepositoryService = eventRepositoryService;

  ValueNotifier<DateTime> get selectedDayNotifier => _calendarViewModel.selectedDayNotifier;

  Map<int, Event> get idToEventMap => _idToEventMap;

  Event? eventLookup(int id) => _idToEventMap[id];

  List<TimeSlot> timeSlotsLookup(DateTime date) {
    final DateTime normalized = DateTime(date.year, date.month, date.day);

    final HeapPriorityQueue<TimeSlot>? timeSlots = dateToTimeSlotsMap.value[normalized];

    if (timeSlots == null) {
      dateToTimeSlotsMap.value[normalized] = HeapPriorityQueue<TimeSlot>();
      _loadMonthsEventsOutsideBounds(normalized);
      return [];
    }

    return timeSlots.toList();
  }

  void _updateLoadedEvents(List<Event> events) {
    for (final Event event in events) {
      _idToEventMap[event.id] = event;
      _addTimeSlotsToMap(event.timeSlots);
      event.timeSlots.clear();
    }

    _clampCurrentlyLoadedEvents();
    notifyMapChanged();
  }

  //The amount of days worth of events should not exceed a limit. This will cull the earliest ones excluding today + 7
  void _clampCurrentlyLoadedEvents() {
    const int LIMIT = 365;
    final DateTime now = DateTime.now(), today = DateTime(now.year, now.month, now.day);

    final Set<DateTime> protectedDates = Set.from(List.generate(8, (int index) => today.add(Duration(days: index))));

    final SplayTreeMap<DateTime, HeapPriorityQueue> map = dateToTimeSlotsMap.value;

    while (map.length > LIMIT) {
      final DateTime? deleteFirst = map.keys.firstWhereOrNull((DateTime key) => !protectedDates.contains(key));
      final DateTime? deleteLast = map.keys.lastWhereOrNull((DateTime key) => !protectedDates.contains(key));

      if (deleteFirst == null && deleteLast == null) break;

      DateTime? deleteCandidate;
      if (deleteFirst != null && deleteLast != null) {
        deleteCandidate =
            (deleteFirst.difference(_calendarViewModel.selectedDay).abs().inSeconds < deleteLast.difference(_calendarViewModel.selectedDay).abs().inSeconds)
                ? deleteLast
                : deleteFirst;
      } else {
        deleteCandidate = deleteFirst ?? deleteLast;
      }

      if (deleteCandidate == null) break;

      map.remove(deleteCandidate);
    }
  }

  void notifyMapChanged() {
    dateToTimeSlotsMap.value = SplayTreeMap<DateTime, HeapPriorityQueue<TimeSlot>>.from(dateToTimeSlotsMap.value);
  }

  void _addTimeSlotsToMap(List<TimeSlot> timeSlots) {
    for (final TimeSlot timeSlot in timeSlots) {
      final DateTime dateOfTimeSlot = timeSlot.dateOfTimeSlot;
      final DateTime normalized = DateTime(dateOfTimeSlot.year, dateOfTimeSlot.month, dateOfTimeSlot.day);

      dateToTimeSlotsMap.value.putIfAbsent(normalized, HeapPriorityQueue<TimeSlot>.new);
      if (!dateToTimeSlotsMap.value[normalized]!.contains(timeSlot)) dateToTimeSlotsMap.value[normalized]!.add(timeSlot);
    }
  }

  //"Around" means entirety of last, this, and next month
  Future<void> loadEventsAround(DateTime day) async {
    final DateTime lowerBound = DateTime(day.month == 1 ? day.year - 1 : day.year, day.month == 1 ? 12 : day.month - 1);

    final DateTime firstDayMonthAfterUpperBound = DateTime(day.month >= 11 ? day.year + 1 : day.year, (day.month + 2) % 12 == 0 ? 12 : (day.month + 2) % 12);
    final DateTime upperBound = firstDayMonthAfterUpperBound.subtract(const Duration(days: 1));

    final result = await _eventRepositoryService.fetchAllEventsBetweenDates(lowerBound, upperBound);
    switch (result) {
      case Ok<List<Event>>(value: final List<Event> events):
        _updateLoadedEvents(events);

      case Error<List<Event>>(error: final Exception exception):
        emitError(exception);
    }
  }

  DateTime _getBeginningOfTheMonth(DateTime day) => DateTime(day.year, day.month);
  DateTime _getEndOfTheMonth(DateTime day) =>
      DateTime(day.month == 12 ? day.year + 1 : day.year, day.month == 12 ? 1 : day.month + 1).subtract(const Duration(days: 1));

  Future<void> _loadMonthsEventsOutsideBounds(DateTime day) async {
    final DateTime beginningOfTheMonth = _getBeginningOfTheMonth(day);
    final DateTime endOfTheMonth = _getEndOfTheMonth(day);

    _preInitializeMap(beginningOfTheMonth, endOfTheMonth);

    final result = await _eventRepositoryService.fetchAllEventsBetweenDates(beginningOfTheMonth, endOfTheMonth);
    switch (result) {
      case Ok<List<Event>>(value: final List<Event> newEvents):
        _updateLoadedEvents(newEvents);

      case Error<List<Event>>(error: final Exception exception):
        emitError(exception);
    }
  }

  void _preInitializeMap(DateTime lowerBound, DateTime upperBound) {
    if (lowerBound.year != upperBound.year || lowerBound.month != upperBound.month) return; //TODO: ERROR Report

    for (int i = lowerBound.day; i <= upperBound.day; i++) {
      final DateTime key = DateTime(lowerBound.year, lowerBound.month, i);
      if (dateToTimeSlotsMap.value[key] == null) {
        dateToTimeSlotsMap.value[key] = HeapPriorityQueue<TimeSlot>();
      }
    }
  }

  Future<void> deleteEvent(Event event) async {
    await _eventRepositoryService.deleteEvent(event);

    final List<DateTime> keys = dateToTimeSlotsMap.value.keys.toList();

    for (final DateTime key in keys) {
      final HeapPriorityQueue<TimeSlot>? timeSlots = dateToTimeSlotsMap.value[key];
      if (timeSlots == null) continue;

      final List<TimeSlot> timeslotsList = timeSlots.toList();
      final int lengthBeforeRemove = timeslotsList.length;
      timeslotsList.removeWhere((TimeSlot timeslot) => timeslot.eventId == event.id);

      if (lengthBeforeRemove != timeslotsList.length) {
        final HeapPriorityQueue<TimeSlot> edited = HeapPriorityQueue()..addAll(timeslotsList);
        dateToTimeSlotsMap.value[key] = edited;
      }
    }

    notifyMapChanged();
    _calendarViewModel.procSelectedDayNotifier();
  }

  Future<void> addEvent(Event event) async {
    final Result<int> result = await _eventRepositoryService.saveEvent(event);

    switch (result) {
      case Ok():
        refresh();
      case Error(error: final Exception exception):
        emitError(exception);
    }
  }

  Future<void> refresh() async {
    dateToTimeSlotsMap.value.clear();
    _idToEventMap.clear();

    await loadEventsAround(DateTime.now());
    await loadEventsAround(_calendarViewModel.selectedDay);

    _calendarViewModel.procSelectedDayNotifier();
  }

  void dispose() {
    dateToTimeSlotsMap.dispose();
  }

  List<TimeSlot> getUpcomingEvents() {
    final List<TimeSlot> timeSlots = [];

    for (final HeapPriorityQueue queue in dateToTimeSlotsMap.value.values) {
      for (final TimeSlot timeSlot in queue.toList()) {
        if (timeSlot.timeSlotType == TimeSlotType.Deadline) timeSlots.add(timeSlot);
      }
    }

    return timeSlots.sorted();
  }
}
