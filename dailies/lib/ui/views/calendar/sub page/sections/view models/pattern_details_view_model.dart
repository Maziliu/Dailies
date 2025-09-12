import 'package:dailies/common/enums/days_of_the_week.dart';
import 'package:dailies/common/enums/rrule_frequency.dart';
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
  ValueNotifier<List<bool>> selectedDays = ValueNotifier(
    DaysOfTheWeek.values.map((_) => false).toList(),
  );

  List<bool> get getSelectedDays => selectedDays.value;

  void toggleSelectedDay(int index) {
    final List<bool> updatedDays = List.from(selectedDays.value);
    updatedDays[index] = !updatedDays[index];
    selectedDays.value = updatedDays;
  }

  PatternDetailsSectionViewModel({required DateTime selectedDay})
    : calendarViewModel = MultiSelectCalendarViewModel(
        initialSelectedDay: selectedDay,
      );

  TimeSlotPattern constructTimeSlotPattern(
    int? frequencyValue,
    RRuleFrequency? frequencyType,
    DateTime? patternEndDate,
    TimeSlot referenceTimeSlot,
  ) {
    final bool isDaylightSaving = daylightSavingToggle.value;
    final bool isRepeatable = repeatablePatternToggle.value;

    String rrule = '';

    if (isRepeatable) {
      final selectedDaysOfWeek =
          DaysOfTheWeek.values
              .asMap()
              .entries
              .where((entry) => selectedDays.value[entry.key])
              .map((entry) => entry.value)
              .toList();

      if (selectedDaysOfWeek.isNotEmpty) {
        rrule +=
            'FREQ=${frequencyType.toString().split('.').last.toUpperCase()};INTERVAL=$frequencyValue;BYDAY=${selectedDaysOfWeek.map((day) => day.icalCode).join(',')}';
      } else {
        rrule +=
            'FREQ=${frequencyType.toString().split('.').last.toUpperCase()};INTERVAL=$frequencyValue';
      }

      if (finitePatternToggle.value && patternEndDate != null) {
        final untilString =
            '${patternEndDate.toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '').split('.').first}Z';
        rrule += ';UNTIL=$untilString';
      }
    }

    print('Generated RRULE: $rrule');

    return TimeSlotPattern.UnSaved(
      recurranceRule: rrule.isNotEmpty ? rrule : null,
      endPatternDate: patternEndDate,
      timeZoneId: isDaylightSaving ? DateTime.now().timeZoneName : null,
      anchorPointsList: calendarViewModel.generateAnchorPoints(
        referenceTimeSlot,
      ),
    );
  }
}
