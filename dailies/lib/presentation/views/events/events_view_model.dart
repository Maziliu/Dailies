import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsViewModel extends ChangeNotifier {
  DateTime _selectedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;

  void onAddEventButtonPress() {
    print('Added Event');
  }

  void onDaySelect(DateTime selectedDay) {
    if (!isSameDay(selectedDay, _selectedDay)) {
      _selectedDay = selectedDay;
      notifyListeners();
    }
  }
}
