import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/ui/components/interface/animatable_widget.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddEventPopupCard extends StatefulWidget implements AnimatableWidget {
  final String _heroTag;
  final DateTime _selectedDay;

  const AddEventPopupCard({super.key, required String heroTag, required DateTime selectedDay}) : _heroTag = heroTag, _selectedDay = selectedDay;

  @override
  State<AddEventPopupCard> createState() => _AddEventPopupCardState();

  @override
  String get heroTag => _heroTag;
}

class _AddEventPopupCardState extends State<AddEventPopupCard> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  final List<bool> _timeSlotSelection = [for (final TimeSlotType type in TimeSlotType.values) (type == TimeSlotType.Unspecified)];

  int _selectedTimeSlotIndex = TimeSlotType.values.indexOf(TimeSlotType.Unspecified);

  TimeOfDay _pickedDeadline = TimeOfDay.now(), _pickedStartTime = TimeOfDay.now(), _pickedEndTime = TimeOfDay.now();

  final String _eventNameFieldTag = 'eventNameField', _locationNameField = 'locationNameField';

  void _onTogglePressed(int index) {
    setState(() {
      _selectedTimeSlotIndex = index;
      for (int i = 0; i < _timeSlotSelection.length; i++) {
        _timeSlotSelection[i] = (i == index);
      }
    });
  }

  String _formatTimeSlotLabel(TimeSlotType type) {
    return type.name.replaceAll('_', ' ').replaceFirstMapped(RegExp(r'^.'), (match) => match.group(0)!.toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
      child: Padding(
        padding: UIFormating.largePadding(),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text('Create New Event', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
              ),
              UIFormating.largeVerticalSpacing(),
              FormBuilderTextField(
                name: _eventNameFieldTag,
                decoration: const InputDecoration(labelText: 'Event Name'),
                validator: (value) => (value == null) ? "Required" : null,
              ),
              UIFormating.mediumVerticalSpacing(),
              FormBuilderTextField(name: _locationNameField, decoration: const InputDecoration(labelText: 'Location')),
              UIFormating.largeVerticalSpacing(),
              Text('Event Type', style: theme.textTheme.bodyMedium),
              UIFormating.smallVerticalSpacing(),
              FittedBox(
                child: ToggleButtons(
                  isSelected: _timeSlotSelection,
                  onPressed: _onTogglePressed,
                  borderRadius: UIFormating.smallCircularBorderRadius(),
                  children:
                      TimeSlotType.values
                          .map((type) => Padding(padding: const EdgeInsets.all(8.0), child: Text(_formatTimeSlotLabel(type), textAlign: TextAlign.center)))
                          .toList(),
                ),
              ),
              UIFormating.smallVerticalSpacing(),
              Visibility(
                visible: _selectedTimeSlotIndex == TimeSlotType.values.indexOf(TimeSlotType.Interval),
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(context: context, initialTime: _pickedStartTime);
                          if (newTime != null) {
                            setState(() {
                              _pickedStartTime = newTime;
                            });
                          }
                        },
                        child: Text(_pickedStartTime.format(context)),
                      ),
                      const Text('to'),
                      TextButton(
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(context: context, initialTime: _pickedEndTime);
                          if (newTime != null) {
                            setState(() {
                              _pickedEndTime = newTime;
                            });
                          }
                        },
                        child: Text(_pickedEndTime.format(context)),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _selectedTimeSlotIndex == TimeSlotType.values.indexOf(TimeSlotType.Deadline),
                child: TextButton(
                  onPressed: () async {
                    TimeOfDay? newTime = await showTimePicker(context: context, initialTime: _pickedDeadline);
                    if (newTime != null) {
                      setState(() {
                        _pickedDeadline = newTime;
                      });
                    }
                  },
                  child: Text(_pickedDeadline.format(context)),
                ),
              ),
              UIFormating.extraLargeVerticalSpacing(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Map<String, dynamic>? fields = _formKey.currentState?.fields;

                    String eventName = fields?[_eventNameFieldTag].value;
                    String? locationName = fields?[_locationNameField].value;
                    DateTime? startTime;
                    DateTime? endTime;

                    if (_selectedTimeSlotIndex == TimeSlotType.values.indexOf(TimeSlotType.Interval)) {
                      startTime = DateTime(
                        widget._selectedDay.year,
                        widget._selectedDay.month,
                        widget._selectedDay.day,
                        _pickedStartTime.hour,
                        _pickedStartTime.minute,
                      );
                      endTime = DateTime(
                        widget._selectedDay.year,
                        widget._selectedDay.month,
                        widget._selectedDay.day,
                        _pickedEndTime.hour,
                        _pickedEndTime.minute,
                      );
                    } else if (_selectedTimeSlotIndex == TimeSlotType.values.indexOf(TimeSlotType.Deadline)) {
                      endTime = DateTime(
                        widget._selectedDay.year,
                        widget._selectedDay.month,
                        widget._selectedDay.day,
                        _pickedDeadline.hour,
                        _pickedDeadline.minute,
                      );
                    }

                    Navigator.pop(
                      context,
                      Event(
                        eventName: eventName,
                        location: locationName,
                        timeSlot: TimeSlot(dateOfTimeSlot: widget._selectedDay, startTime: startTime, endTime: endTime),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary, foregroundColor: colorScheme.onPrimary),
                child: const Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
