import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/ui/views/components/add%20event/hero_dialog_route.dart';
import 'package:flutter/material.dart';

const String _addEventHeroTag = 'Add event';

class AddEventPopupCard extends StatefulWidget {
  const AddEventPopupCard({super.key});

  @override
  State<AddEventPopupCard> createState() => _AddEventPopupCardState();
}

class _AddEventPopupCardState extends State<AddEventPopupCard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  late List<bool> _timeSlotSelection;
  int _selectedTimeSlotIndex = 0;
  TimeOfDay pickedDeadline = TimeOfDay.now();
  TimeOfDay pickedStartTime = TimeOfDay.now();
  TimeOfDay pickedEndTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _timeSlotSelection = List.generate(TimeSlotType.values.length, (index) => (index == 0));
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _locationController.dispose();
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
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                  currentFocus.unfocus();
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
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
                        _buildTextField(controller: _eventNameController, label: 'Event Name', validatorMessage: 'Please enter an event name'),
                        const SizedBox(height: 16),
                        _buildTextField(controller: _locationController, label: 'Location', validatorMessage: 'Please enter a location'),
                        const SizedBox(height: 24),
                        Text('Event Type', style: theme.textTheme.bodyMedium),
                        const SizedBox(height: 8),
                        Center(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final int buttonCount = TimeSlotType.values.length;
                              final double spacing = 8.0;
                              final double totalSpacing = spacing * (buttonCount - 1);
                              final double availableWidth = constraints.maxWidth - totalSpacing;
                              final double buttonWidth = (availableWidth / buttonCount).floorToDouble();

                              return ToggleButtons(
                                isSelected: _timeSlotSelection,
                                onPressed: _onTogglePressed,
                                borderRadius: BorderRadius.circular(8),
                                constraints: BoxConstraints(minHeight: 40, minWidth: buttonWidth),
                                children: TimeSlotType.values.map((type) => Text(_formatTimeSlotLabel(type), textAlign: TextAlign.center)).toList(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (_selectedTimeSlotIndex == TimeSlotType.values.indexOf(TimeSlotType.Interval))
                          Row(
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
                        if (_selectedTimeSlotIndex == TimeSlotType.values.indexOf(TimeSlotType.Deadline))
                          TextButton(
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

                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  Navigator.of(context).pop();
                                }
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary, foregroundColor: colorScheme.onPrimary),
                              child: const Text('Create Event'),
                            ),
                          ],
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

  Widget _buildTextField({required TextEditingController controller, required String label, required String validatorMessage}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      validator: (value) => (value == null || value.trim().isEmpty) ? validatorMessage : null,
    );
  }

  String _formatTimeSlotLabel(TimeSlotType type) {
    return type.name.replaceAll('_', ' ').replaceFirstMapped(RegExp(r'^.'), (m) => m.group(0)!.toUpperCase());
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    this.onButtonPress,
    this.rightPadding = 16,
    this.bottomPadding = 20,
    this.buttonIcon = Icons.add,
    this.isVisible = true,
  });

  final VoidCallback? onButtonPress;
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
          onButtonPress?.call();
          Navigator.of(context).push(HeroDialogRoute(builder: (context) => const AddEventPopupCard()));
        },
        child: Icon(buttonIcon),
      ),
    );
  }
}
