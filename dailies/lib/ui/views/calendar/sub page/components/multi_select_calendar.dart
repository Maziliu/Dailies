import 'package:dailies/data/models/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MultiSelectCalendar extends StatelessWidget {
  final MultiSelectCalendarViewModel _viewModel;

  const MultiSelectCalendar({super.key, required MultiSelectCalendarViewModel viewModel}) : _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _viewModel.selectedDays,
      builder: (context, selectedDays, _) {
        return TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: DateTime.now(),
          selectedDayPredicate: (day) {
            return selectedDays.any((selectedDay) => isSameDay(selectedDay, day));
          },
          onDaySelected: (selectedDay, focusedDay) {
            final alreadySelected = selectedDays.any((day) => isSameDay(day, selectedDay));

            if (alreadySelected) {
              _viewModel.removeSelectedDay(selectedDay);
            } else {
              _viewModel.addSelectedDay(selectedDay);
            }
          },
          headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
          sixWeekMonthsEnforced: true,
        );
      },
    );
  }
}

class MultiSelectCalendarViewModel extends ChangeNotifier {
  final ValueNotifier<Set<DateTime>> selectedDays;

  MultiSelectCalendarViewModel({Set<DateTime>? initialSelectedDays, DateTime? initialSelectedDay}) : selectedDays = ValueNotifier<Set<DateTime>>({}) {
    final initialSet = <DateTime>{};
    if (initialSelectedDays != null) {
      initialSet.addAll(initialSelectedDays.map((day) => DateTime(day.year, day.month, day.day)));
    }
    if (initialSelectedDay != null) {
      initialSet.add(DateTime(initialSelectedDay.year, initialSelectedDay.month, initialSelectedDay.day));
    }
    selectedDays.value = initialSet;
  }

  void addSelectedDay(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    selectedDays.value = {...selectedDays.value, normalized};
  }

  void removeSelectedDay(DateTime selectedDay) {
    selectedDays.value = {
      for (final day in selectedDays.value)
        if (!isSameDay(day, selectedDay)) day,
    };
  }

  List<TimeSlot> generateAnchorPoints(TimeSlot referenceTimeSlot) =>
      selectedDays.value
          .map((day) => TimeSlot.UnSaved(dateOfTimeSlot: day, startTime: referenceTimeSlot.startTime, endTime: referenceTimeSlot.endTime))
          .toList();
}
