import 'package:dailies/data/models/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MultiSelectCalendar extends StatelessWidget {
  final MultiSelectCalendarViewModel _viewModel;

  const MultiSelectCalendar({
    super.key,
    required MultiSelectCalendarViewModel viewModel,
  }) : _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _viewModel.selectedDays,
      builder: (context, selectedDays, _) {
        return TableCalendar(
          firstDay: DateTime.utc(2020),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _viewModel.getFocusedDay(),
          selectedDayPredicate: (day) {
            return selectedDays.any(
              (selectedDay) => isSameDay(selectedDay, day),
            );
          },
          onDaySelected: (selectedDay, focusedDay) {
            final alreadySelected = selectedDays.any(
              (day) => isSameDay(day, selectedDay),
            );

            if (alreadySelected) {
              _viewModel.removeSelectedDay(selectedDay);
            } else {
              _viewModel.addSelectedDay(selectedDay);
            }
          },
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          sixWeekMonthsEnforced: true,
        );
      },
    );
  }
}

class MultiSelectCalendarViewModel extends ChangeNotifier {
  final ValueNotifier<List<DateTime>> selectedDays;
  DateTime _lastInteractedDay = DateTime.now();

  MultiSelectCalendarViewModel({
    Set<DateTime>? initialSelectedDays,
    DateTime? initialSelectedDay,
  }) : selectedDays = ValueNotifier<List<DateTime>>([]) {
    final initialList = <DateTime>[];
    if (initialSelectedDays != null) {
      for (final day in initialSelectedDays) {
        initialList.add(DateTime(day.year, day.month, day.day));
      }
    }
    if (initialSelectedDay != null) {
      final normalized = DateTime(
        initialSelectedDay.year,
        initialSelectedDay.month,
        initialSelectedDay.day,
      );
      if (!initialList.any((day) => isSameDay(day, normalized))) {
        initialList.add(normalized);
      }
      _lastInteractedDay = normalized;
    }
    selectedDays.value = initialList;
  }

  DateTime getFocusedDay() {
    if (selectedDays.value.isEmpty) {
      return DateTime.now();
    }

    DateTime closest = selectedDays.value.first;
    int closestDifference = _lastInteractedDay.difference(closest).abs().inDays;

    for (final day in selectedDays.value) {
      final difference = _lastInteractedDay.difference(day).abs().inDays;
      if (difference < closestDifference) {
        closest = day;
        closestDifference = difference;
      }
    }

    return closest;
  }

  void addSelectedDay(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    _lastInteractedDay = normalized;

    final currentList = List<DateTime>.from(selectedDays.value);

    currentList.removeWhere(
      (existingDay) => isSameDay(existingDay, normalized),
    );

    currentList.add(normalized);

    selectedDays.value = currentList;
  }

  void removeSelectedDay(DateTime selectedDay) {
    final normalized = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
    );
    _lastInteractedDay = normalized;

    final currentList = List<DateTime>.from(selectedDays.value);
    currentList.removeWhere((day) => isSameDay(day, selectedDay));
    selectedDays.value = currentList;
  }

  List<TimeSlot> generateAnchorPoints(TimeSlot referenceTimeSlot) =>
      selectedDays.value
          .map(
            (day) => TimeSlot.UnSaved(
              dateOfTimeSlot: day,
              startTime: referenceTimeSlot.startTime,
              endTime: referenceTimeSlot.endTime,
            ),
          )
          .toList();
}
