import 'package:dailies/common/enums/frequency_type.dart';
import 'package:dailies/common/exceptions/ui_exceptions.dart';
import 'package:dailies/common/utils/ui_helpers.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/data/models/time_slot_pattern.dart';
import 'package:dailies/ui/views/calendar/sub%20page/add_event_facade.dart';
import 'package:dailies/ui/views/calendar/sub%20page/sections/event_details_section.dart';
import 'package:dailies/ui/views/calendar/sub%20page/sections/pattern_details_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SubmitSection extends StatelessWidget {
  final GlobalKey<FormBuilderState> _detailsFormKey, _patternFormKey;
  final AddEventFacade _viewModelFacade;
  final DateTime _selectedDay;

  const SubmitSection({
    super.key,
    required GlobalKey<FormBuilderState> detailsFormKey,
    required GlobalKey<FormBuilderState> patternFormKey,
    required AddEventFacade viewModelFacade,
    required DateTime selectedDay,
  }) : _detailsFormKey = detailsFormKey,
       _patternFormKey = patternFormKey,
       _viewModelFacade = viewModelFacade,
       _selectedDay = selectedDay;

  Event _onPressedEventCreate(Map detailFields, Map? patternFields) {
    final String eventName = detailFields[EVENT_NAME_FIELD_TAG]?.value;
    final String? locationName = detailFields[LOCATION_NAME_FIELD_TAG]?.value;

    final Event event = Event(eventName: eventName, location: locationName);

    final TimeSlot referenceTimeSlot = _viewModelFacade.eventTypeSectionViewModel.constructTimeSlot(_selectedDay);
    TimeSlotPattern pattern = TimeSlotPattern.UnSaved(anchorPointsList: [referenceTimeSlot]);

    if (patternFields != null) {
      final int? frequencyValue = int.tryParse(patternFields[FREQUENCY_FIELD_TAG]?.value as String);
      final FrequencyType frequencyType = patternFields[FREQUENCY_TYPE_FIELD_TAG]?.value as FrequencyType;
      final DateTime patternEndDate = patternFields[END_DATE_FIELD_TAG]?.value as DateTime;

      pattern = _viewModelFacade.patternDetailsSectionViewModel.constructTimeSlotPattern(frequencyValue, frequencyType, patternEndDate, referenceTimeSlot);
    }

    event.pattern = pattern;
    event.timeSlots.addAll(pattern.anchorPointsList);

    return event;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ElevatedButton(
        onPressed: () {
          final bool hasPattern = _viewModelFacade.patternDetailsSectionViewModel.patternSectionToggle.value;

          if ((_detailsFormKey.currentState?.validate() ?? false) == false) {
            showErrorSnackbar(exception: IncompleteFormException(specificForm: 'Event Details'));
            return;
          }
          if ((_patternFormKey.currentState?.validate() ?? false) == false && hasPattern) {
            showErrorSnackbar(exception: IncompleteFormException(specificForm: 'Event Pattern'));
            return;
          }

          final Map? detailFields = _detailsFormKey.currentState?.fields;
          final Map? patternFields = _patternFormKey.currentState?.fields;

          Event event = _onPressedEventCreate(detailFields!, patternFields);

          Navigator.pop(context, event);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Create Event'),
      ),
    );
  }
}
