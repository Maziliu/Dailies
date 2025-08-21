import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:flutter/material.dart';

class EventTypeSectionViewModel extends ChangeNotifier {
  final ValueNotifier<TimeOfDay> pickedDeadline = ValueNotifier<TimeOfDay>(TimeOfDay.now()),
      pickedStartTime = ValueNotifier<TimeOfDay>(TimeOfDay.now()),
      pickedEndTime = ValueNotifier<TimeOfDay>(TimeOfDay.now());

  final ValueNotifier<int> selectedTimeSlotIndex = ValueNotifier<int>(TimeSlotType.values.indexOf(TimeSlotType.Unspecified));

  List<bool> timeSlotSelection = [for (final type in TimeSlotType.values) (type == TimeSlotType.Unspecified)];

  void onTogglePress(int index) {
    selectedTimeSlotIndex.value = index;
    timeSlotSelection = [for (final type in TimeSlotType.values) type.index == index];
  }
}
