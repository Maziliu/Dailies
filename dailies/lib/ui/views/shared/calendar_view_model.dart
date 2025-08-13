import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewModel {
  final ValueNotifier<DateTime> selectedDayNotifier;

  CalendarViewModel() : selectedDayNotifier = ValueNotifier(DateTime.now());

  DateTime get selectedDay => selectedDayNotifier.value;

  void onDaySelect(DateTime day) {
    if (!isSameDay(day, selectedDayNotifier.value)) {
      selectedDayNotifier.value = day;
    }
  }

  void dispose() {
    selectedDayNotifier.dispose();
  }
}
