import 'package:dailies/common/enums/frequency_type.dart';
import 'package:dailies/common/exceptions/ui_exceptions.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/data/models/time_slot_pattern.dart';
import 'package:dailies/ui/mixins/error_stream_mixin.dart';
import 'package:dailies/ui/views/calendar/sub%20page/sections/event_details_section.dart';
import 'package:dailies/ui/views/calendar/sub%20page/sections/pattern_details_section.dart';
import 'package:dailies/ui/views/calendar/sub%20page/sections/view%20models/event_type_section_view_model.dart';
import 'package:dailies/ui/views/calendar/sub%20page/sections/view%20models/pattern_details_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddEventFacade with ErrorStreamMixin {
  final EventTypeSectionViewModel eventTypeSectionViewModel;
  final PatternDetailsSectionViewModel patternDetailsSectionViewModel;

  final DateTime _selectedDay;

  DateTime get selectedDay => _selectedDay;

  AddEventFacade({required DateTime selectedDay})
    : _selectedDay = selectedDay,
      eventTypeSectionViewModel = EventTypeSectionViewModel(),
      patternDetailsSectionViewModel = PatternDetailsSectionViewModel(
        selectedDay: selectedDay,
      );

  Event? createEvent({
    required GlobalKey<FormBuilderState> detailsFormKey,
    required GlobalKey<FormBuilderState> patternFormKey,
  }) {
    if (!_validateForm(detailsFormKey)) {
      emitError(IncompleteFormException(specificForm: 'Event Details'));
      return null;
    }

    if (!_validateForm(patternFormKey) &&
        patternDetailsSectionViewModel.patternSectionToggle.value) {
      emitError(IncompleteFormException(specificForm: 'Event Pattern'));
      return null;
    }

    final Map? detailFields = detailsFormKey.currentState?.fields;
    final Map? patternFields = patternFormKey.currentState?.fields;

    return _constructEvent(detailFields!, patternFields);
  }

  Event _constructEvent(Map detailFields, Map? patternFields) {
    final String eventName = detailFields[EVENT_NAME_FIELD_TAG]?.value;
    final String? locationName = detailFields[LOCATION_NAME_FIELD_TAG]?.value;

    final Event event = Event(eventName: eventName, location: locationName);

    final TimeSlot referenceTimeSlot = eventTypeSectionViewModel
        .constructTimeSlot(_selectedDay);
    TimeSlotPattern pattern = TimeSlotPattern.UnSaved(
      anchorPointsList: [referenceTimeSlot],
    );

    if (patternFields != null) {
      final int? frequencyValue = int.tryParse(
        patternFields[FREQUENCY_FIELD_TAG]?.value ?? '',
      );
      final FrequencyType? frequencyType =
          patternFields[FREQUENCY_TYPE_FIELD_TAG]?.value;
      final DateTime? patternEndDate = patternFields[END_DATE_FIELD_TAG]?.value;

      pattern = patternDetailsSectionViewModel.constructTimeSlotPattern(
        frequencyValue,
        frequencyType,
        patternEndDate,
        referenceTimeSlot,
      );
    }

    event.pattern = pattern;
    event.timeSlots.addAll(pattern.anchorPointsList);

    return event;
  }

  bool _validateForm(GlobalKey<FormBuilderState> formKey) =>
      formKey.currentState?.validate() ?? false;
}
