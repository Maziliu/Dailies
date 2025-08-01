import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/ui/views/calendar/calendar_view_model.dart';
import 'package:dailies/ui/views/components/add%20event/hero_dialog_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

const String _addEventHeroTag = 'Add event';

class AddEventPopupCard extends StatefulWidget {
  const AddEventPopupCard({super.key, required this.calendarViewModel, required this.onActionComplete});
  final CalendarViewModel calendarViewModel;
  final Function onActionComplete;
  @override
  State<AddEventPopupCard> createState() => _AddEventPopupCardState();
}

class _AddEventPopupCardState extends State<AddEventPopupCard> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final List<bool> _timeSlotSelection = [for (final TimeSlotType type in TimeSlotType.values) (type == TimeSlotType.Unspecified)];
  int _selectedTimeSlotIndex = TimeSlotType.values.indexOf(TimeSlotType.Unspecified);
  TimeOfDay pickedDeadline = TimeOfDay.now();
  TimeOfDay pickedStartTime = TimeOfDay.now();
  TimeOfDay pickedEndTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTogglePressed(int index) {
    setState(() {
      _selectedTimeSlotIndex = index;
      for (int i = 0; i < _timeSlotSelection.length; i++) {
        _timeSlotSelection[i] = (i == index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Hero(
          tag: _addEventHeroTag,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(16),
            color: colorScheme.surface,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              child: Padding(
                padding: const EdgeInsets.all(24),

                child: GestureDetector(
                  onTap: () {
                    if (FocusScope.of(context).hasFocus) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            'Create New Event',
                            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                          ),
                        ),
                        const SizedBox(height: 24),
                        FormBuilderTextField(
                          name: 'eventNameField',
                          decoration: const InputDecoration(labelText: 'Event Name'),
                          validator: (value) => (value == null) ? "Required" : null,
                        ),
                        const SizedBox(height: 16),
                        FormBuilderTextField(name: 'locationField', decoration: const InputDecoration(labelText: 'Location')),
                        const SizedBox(height: 24),
                        Text('Event Type', style: theme.textTheme.bodyMedium),
                        const SizedBox(height: 8),
                        FittedBox(
                          child: ToggleButtons(
                            isSelected: _timeSlotSelection,
                            onPressed: _onTogglePressed,
                            borderRadius: BorderRadius.circular(8),
                            children:
                                TimeSlotType.values
                                    .map(
                                      (type) =>
                                          Padding(padding: const EdgeInsets.all(8.0), child: Text(_formatTimeSlotLabel(type), textAlign: TextAlign.center)),
                                    )
                                    .toList(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Visibility(
                          visible: _selectedTimeSlotIndex == TimeSlotType.values.indexOf(TimeSlotType.Interval),
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    TimeOfDay? newTime = await showTimePicker(context: context, initialTime: pickedStartTime);
                                    if (newTime != null) {
                                      setState(() {
                                        pickedStartTime = newTime;
                                      });
                                    }
                                  },
                                  child: Text(pickedStartTime.format(context)),
                                ),
                                const Text('to'),
                                TextButton(
                                  onPressed: () async {
                                    TimeOfDay? newTime = await showTimePicker(context: context, initialTime: pickedEndTime);
                                    if (newTime != null) {
                                      setState(() {
                                        pickedEndTime = newTime;
                                      });
                                    }
                                  },
                                  child: Text(pickedEndTime.format(context)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _selectedTimeSlotIndex == TimeSlotType.values.indexOf(TimeSlotType.Deadline),
                          child: TextButton(
                            onPressed: () async {
                              TimeOfDay? newTime = await showTimePicker(context: context, initialTime: pickedDeadline);
                              if (newTime != null) {
                                setState(() {
                                  pickedDeadline = newTime;
                                });
                              }
                            },
                            child: Text(pickedDeadline.format(context)),
                          ),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              widget.onActionComplete();
                              Navigator.of(context).pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary, foregroundColor: colorScheme.onPrimary),
                          child: const Text('Create Event'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimeSlotLabel(TimeSlotType type) {
    return type.name.replaceAll('_', ' ').replaceFirstMapped(RegExp(r'^.'), (m) => m.group(0)!.toUpperCase());
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.onActionButtonComplete,
    this.rightPadding = 16,
    this.bottomPadding = 20,
    this.buttonIcon = Icons.add,
    this.isVisible = true,
  });

  final VoidCallback onActionButtonComplete;
  final double rightPadding;
  final double bottomPadding;
  final IconData buttonIcon;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: FloatingActionButton(
        heroTag: _addEventHeroTag,
        onPressed: () {
          final CalendarViewModel calendarViewModel = context.read<CalendarViewModel>();
          Navigator.of(context).push(
            HeroDialogRoute(
              builder: (context) {
                return AddEventPopupCard(calendarViewModel: calendarViewModel, onActionComplete: onActionButtonComplete);
              },
            ),
          );
        },
        child: Icon(buttonIcon),
      ),
    );
  }
}
