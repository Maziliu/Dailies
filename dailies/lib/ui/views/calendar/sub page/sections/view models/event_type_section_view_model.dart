import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:flutter/material.dart';

class EventTypeSectionViewModel extends ChangeNotifier {
  final ValueNotifier<TimeOfDay> pickedDeadline = ValueNotifier<TimeOfDay>(
        TimeOfDay.now(),
      ),
      pickedStartTime = ValueNotifier<TimeOfDay>(TimeOfDay.now()),
      pickedEndTime = ValueNotifier<TimeOfDay>(TimeOfDay.now());

  final ValueNotifier<int> selectedTimeSlotIndex = ValueNotifier<int>(
    TimeSlotType.values.indexOf(TimeSlotType.Unspecified),
  );

  List<bool> timeSlotSelection = [
    for (final type in TimeSlotType.values) (type == TimeSlotType.Unspecified),
  ];

  TimeSlotType get eventTypeSelected =>
      TimeSlotType.values[selectedTimeSlotIndex.value];

  void onTogglePress(int index) {
    selectedTimeSlotIndex.value = index;
    timeSlotSelection = [
      for (final type in TimeSlotType.values) type.index == index,
    ];
  }

  TimeSlot constructTimeSlot(DateTime selectedDay) {
    DateTime? startTime;
    DateTime? endTime;

    final DateTime normalizedSelectedDay = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
    );

    switch (eventTypeSelected) {
      case TimeSlotType.Interval:
        startTime = DateTime(
          selectedDay.year,
          selectedDay.month,
          selectedDay.day,
          pickedStartTime.value.hour,
          pickedStartTime.value.minute,
        );
        endTime = DateTime(
          selectedDay.year,
          selectedDay.month,
          selectedDay.day,
          pickedEndTime.value.hour,
          pickedEndTime.value.minute,
        );
      case TimeSlotType.Deadline:
        endTime = DateTime(
          selectedDay.year,
          selectedDay.month,
          selectedDay.day,
          pickedDeadline.value.hour,
          pickedDeadline.value.minute,
        );
      case TimeSlotType.Unspecified:
        startTime = null;
        endTime = null;
    }

    return TimeSlot.UnSaved(
      dateOfTimeSlot: normalizedSelectedDay,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
