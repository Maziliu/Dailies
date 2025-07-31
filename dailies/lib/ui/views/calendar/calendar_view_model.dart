import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewModel extends ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  final List<Event> _currentAndAdjacentMonthsEvents = [
    Event(
      id: 1,
      eventName: 'Meeting with Bob',
      location: 'Office',
      timeSlots: [
        TimeSlot(
          id: 101,
          nextTimeSlotId: null,
          dateOfTimeSlot: DateTime.now(), // Today
          startTime: DateTime.now().add(const Duration(hours: 1)),
          endTime: DateTime.now().add(const Duration(hours: 2)),
        ),
        TimeSlot(
          id: 1031,
          nextTimeSlotId: null,
          dateOfTimeSlot: DateTime.now(), // Today
          startTime: DateTime.now().add(const Duration(hours: 2)),
          endTime: DateTime.now().add(const Duration(hours: 4)),
        ),
        TimeSlot(
          id: 1031,
          nextTimeSlotId: null,
          dateOfTimeSlot: DateTime.now(), // Today
          startTime: DateTime.now().add(const Duration(hours: 2)),
          endTime: DateTime.now().add(const Duration(hours: 4)),
        ),
        TimeSlot(
          id: 1031,
          nextTimeSlotId: null,
          dateOfTimeSlot: DateTime.now(), // Today
          startTime: DateTime.now().add(const Duration(hours: 2)),
          endTime: DateTime.now().add(const Duration(hours: 4)),
        ),
        TimeSlot(
          id: 1031,
          nextTimeSlotId: null,
          dateOfTimeSlot: DateTime.now(), // Today
          startTime: DateTime.now().add(const Duration(hours: 2)),
          endTime: DateTime.now().add(const Duration(hours: 4)),
        ),
        TimeSlot(
          id: 1031,
          nextTimeSlotId: null,
          dateOfTimeSlot: DateTime.now(), // Today
          startTime: DateTime.now().add(const Duration(hours: 2)),
          endTime: DateTime.now().add(const Duration(hours: 4)),
        ),
      ],
    ),
    Event(
      id: 12,
      eventName: 'Mfgddgd',
      location: 'Officegfgdg',
      timeSlots: [
        TimeSlot(
          id: 1031,
          nextTimeSlotId: null,
          dateOfTimeSlot: DateTime.now(), // Today
          startTime: null,
          endTime: DateTime.now().add(const Duration(hours: 4)),
        ),
      ],
    ),
    Event(
      id: 2,
      eventName: 'Doctor Appointment',
      location: 'Clinic',
      timeSlots: [
        TimeSlot(
          id: 102,
          nextTimeSlotId: null,
          dateOfTimeSlot: DateTime.now().add(const Duration(days: 1)), // Tomorrow
          startTime: DateTime.now().add(const Duration(days: 1, hours: 10)),
          endTime: DateTime.now().add(const Duration(days: 1, hours: 11)),
        ),
      ],
    ),
    Event(
      id: 3,
      eventName: 'All-day Conference',
      location: 'Convention Center',
      timeSlots: [
        TimeSlot(
          id: 103,
          nextTimeSlotId: null,
          dateOfTimeSlot: DateTime.now(), // Today
          startTime: null,
          endTime: null,
        ),
      ],
    ),
  ];

  late final ValueNotifier<List<Event>> selectedEvents = ValueNotifier([]);

  DateTime get selectedDay => _selectedDay;

  Future<void> initialize() async {
    await loadEventsFromCurrentAndAdjacentMonths();
    selectedEvents.value = getEventsForSpecificDay(_selectedDay);
  }

  void onAddEventButtonPress() {
    print('Added Event');
  }

  Future<void> loadEventsFromCurrentAndAdjacentMonths() async {}

  List<Event> getEventsForSpecificDay(DateTime specificDay) {
    DateTime onlyDate(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

    List<Event> filteredEvents = [
      for (final event in _currentAndAdjacentMonthsEvents)
        ...(() {
          final matchingSlots = event.timeSlots.where((slot) => onlyDate(slot.dateOfTimeSlot) == onlyDate(specificDay)).toList();

          if (matchingSlots.isNotEmpty) {
            return [Event(id: event.id, eventName: event.eventName, location: event.location, timeSlots: matchingSlots)];
          }
          return [];
        })(),
    ];

    return filteredEvents;
  }

  void onDaySelect(DateTime selectedDay) {
    if (!isSameDay(selectedDay, _selectedDay)) {
      _selectedDay = selectedDay;
      selectedEvents.value = getEventsForSpecificDay(selectedDay);
      notifyListeners();
    }
  }
}
