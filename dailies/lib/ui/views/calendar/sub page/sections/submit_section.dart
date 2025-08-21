import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/ui/views/calendar/sub%20page/add_event_facade.dart';
import 'package:dailies/ui/views/calendar/sub%20page/add_event_sub_page.dart';
import 'package:dailies/ui/views/calendar/sub%20page/sections/event_details_section.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ElevatedButton(
        onPressed: () {
          if (_detailsFormKey.currentState?.validate() ?? false) {
            final fields = _detailsFormKey.currentState?.fields;

            final String eventName = fields?[EVENT_NAME_FIELD_TAG]?.value;
            final String? locationName = fields?[LOCATION_NAME_FIELD_TAG]?.value;

            DateTime? startTime;
            DateTime? endTime;

            if (_viewModelFacade.eventTypeSectionViewModel.selectedTimeSlotIndex.value == TimeSlotType.values.indexOf(TimeSlotType.Interval)) {
              startTime = DateTime(
                _selectedDay.year,
                _selectedDay.month,
                _selectedDay.day,
                _viewModelFacade.eventTypeSectionViewModel.pickedStartTime.value.hour,
                _viewModelFacade.eventTypeSectionViewModel.pickedStartTime.value.minute,
              );
              endTime = DateTime(
                _selectedDay.year,
                _selectedDay.month,
                _selectedDay.day,
                _viewModelFacade.eventTypeSectionViewModel.pickedEndTime.value.hour,
                _viewModelFacade.eventTypeSectionViewModel.pickedEndTime.value.minute,
              );
            } else if (_viewModelFacade.eventTypeSectionViewModel.selectedTimeSlotIndex.value == TimeSlotType.values.indexOf(TimeSlotType.Deadline)) {
              endTime = DateTime(
                _selectedDay.year,
                _selectedDay.month,
                _selectedDay.day,
                _viewModelFacade.eventTypeSectionViewModel.pickedDeadline.value.hour,
                _viewModelFacade.eventTypeSectionViewModel.pickedDeadline.value.minute,
              );
            }

            Navigator.pop(context, Event(eventName: eventName, location: locationName));
          }
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
