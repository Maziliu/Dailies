import 'package:dailies/common/enums/frequency_type.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/data/models/time_slot_pattern.dart';
import 'package:dailies/ui/views/calendar/sub%20page/components/multi_select_calendar.dart';
import 'package:flutter/widgets.dart';

class PatternDetailsSectionViewModel extends ChangeNotifier {
  final MultiSelectCalendarViewModel calendarViewModel;

  ValueNotifier<bool> patternSectionToggle = ValueNotifier<bool>(false);
  ValueNotifier<bool> daylightSavingToggle = ValueNotifier<bool>(false);
  ValueNotifier<bool> finitePatternToggle = ValueNotifier<bool>(false);
  ValueNotifier<bool> repeatablePatternToggle = ValueNotifier<bool>(false);

  PatternDetailsSectionViewModel({required DateTime selectedDay})
    : calendarViewModel = MultiSelectCalendarViewModel(
        initialSelectedDay: selectedDay,
      );

  TimeSlotPattern constructTimeSlotPattern(
    int? frequencyValue,
    FrequencyType? frequencyType,
    DateTime? patternEndDate,
    TimeSlot referenceTimeSlot,
  ) {
    final bool isDaylightSaving = daylightSavingToggle.value;
    final bool isRepeatable = repeatablePatternToggle.value;

    Duration? frequency;

    if (isRepeatable) {
      frequency = _determineDuration(frequencyValue!, frequencyType!);
    }

    return TimeSlotPattern.UnSaved(
      endPatternDate: patternEndDate,
      timeZoneId: isDaylightSaving ? DateTime.now().timeZoneName : null,
      frequencyInSeconds: frequency?.inSeconds,
      anchorPointsList: calendarViewModel.generateAnchorPoints(
        referenceTimeSlot,
      ),
    );
  }

  Duration _determineDuration(int value, FrequencyType units) {
    switch (units) {
      case FrequencyType.Seconds:
        return Duration(seconds: value);
      case FrequencyType.Minutes:
        return Duration(minutes: value);
      case FrequencyType.Hours:
        return Duration(hours: value);
      case FrequencyType.Days:
        return Duration(days: value);
      case FrequencyType.Weeks:
        return Duration(days: value * 7);
    }
  }
}
