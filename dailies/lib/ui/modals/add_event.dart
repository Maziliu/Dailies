import 'package:dailies_v2/enums/event_type.dart';
import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

extension EventTypeLabels on EventType {
  String get label {
    switch (this) {
      case EventType.INTERVAL:
        return 'Interval';
      case EventType.DEADLINE:
        return 'Deadline';
      case EventType.MULTI_DAY:
        return 'Multi-day';
      case EventType.REACCURING:
        return 'Recurring';
      case EventType.INDEFINITE:
        return 'Indefinite';
      case EventType.UNDEFINED:
        return 'Undefined';
    }
  }
}

enum DaysOfTheWeek { SU, MO, TU, WE, TH, FR, SA }

enum Recurrance { DAILY, WEEKLY, MONTHLY }

extension RecurranceLabels on Recurrance {
  String get label {
    switch (this) {
      case Recurrance.DAILY:
        return 'Daily';
      case Recurrance.WEEKLY:
        return 'Weekly';
      case Recurrance.MONTHLY:
        return 'Monthly';
    }
  }

  String get rrule {
    switch (this) {
      case Recurrance.DAILY:
        return 'FREQ=DAILY';
      case Recurrance.WEEKLY:
        return 'FREQ=WEEKLY';
      case Recurrance.MONTHLY:
        return 'FREQ=MONTHLY';
    }
  }
}

const _TITLE_TAG = 'TITLE_TAG';
const _DESCRIPTION_TAG = 'DESCRIPTION_TAG';
const _LOCATION_TAG = 'LOCATION_TAG';
const _DATE_TAG = 'DATE_TAG';
const _INTERVAL_START_TAG = 'INTERVAL_START_TAG';
const _INTERVAL_END_TAG = 'INTERVAL_END_TAG';
const _DEADLINE_TAG = 'DEADLINE_TAG';
const _MULTI_DAY_START_TIME_TAG = 'MULTI_DAY_START_TIME_TAG';
const _MULTI_DAY_END_DATE_TAG = 'MULTI_DAY_END_DATE_TAG';
const _MULTI_DAY_WEEKDAYS_TAG = 'MULTI_DAY_WEEKDAYS';
const _RECURRING_TAG = 'RECURRING_TAG';
final _FORM_KEY = GlobalKey<FormBuilderState>();

class AddEventModal extends StatefulWidget {
  const AddEventModal({super.key});

  @override
  State<AddEventModal> createState() => _AddEventModalState();
}

class _AddEventModalState extends State<AddEventModal> {
  EventType _selectedType = EventType.INTERVAL;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      child: SingleChildScrollView(
        padding: UIFormating.largePadding(),
        child: FormBuilder(
          key: _FORM_KEY,
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Event',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              FormBuilderTextField(
                name: _TITLE_TAG,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),

              FormBuilderTextField(
                name: _LOCATION_TAG,
                decoration: const InputDecoration(labelText: 'Location'),
              ),

              FormBuilderTextField(
                name: _DESCRIPTION_TAG,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 5,
              ),
              FormBuilderDateTimePicker(
                name: _DATE_TAG,
                inputType: InputType.date,
                decoration: const InputDecoration(labelText: 'Date'),
              ),

              UIFormating.smallVerticalSpacing(),

              EventTypeSection(
                initialValue: _selectedType,
                onChanged: (t) => _selectedType = t,
              ),

              ElevatedButton(onPressed: _submit, child: const Text('Create')),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    final state = _FORM_KEY.currentState;
    if (state == null || !state.saveAndValidate()) return;

    final String title = state.fields[_TITLE_TAG]?.value as String;
    final String location = state.fields[_LOCATION_TAG]?.value as String;
    final String description = state.fields[_DESCRIPTION_TAG]?.value as String;
    final DateTime date = state.fields[_DATE_TAG]?.value as DateTime;

    DateTime? startTime, endTime;
    String? rrule;

    switch (_selectedType) {
      case EventType.REACCURING:
        final Recurrance recurrance =
            state.fields[_RECURRING_TAG]?.value as Recurrance;
        rrule = recurrance.rrule;

      case EventType.DEADLINE:
        endTime = state.fields[_DEADLINE_TAG]?.value as DateTime;

      case EventType.INTERVAL:
        startTime = state.fields[_INTERVAL_START_TAG]?.value as DateTime;
        endTime = state.fields[_INTERVAL_END_TAG]?.value as DateTime;

      case EventType.MULTI_DAY:
        startTime = state.fields[_MULTI_DAY_START_TIME_TAG]?.value as DateTime;
        endTime = state.fields[_MULTI_DAY_END_DATE_TAG]?.value as DateTime;
        final Set<int> dayIndexes =
            state.fields[_MULTI_DAY_WEEKDAYS_TAG]?.value as Set<int>;

        rrule =
            'BYDAY=${dayIndexes.map((i) => DaysOfTheWeek.values[i].name).toList().join(',')};';

      default:
    }

    final EventInfoModel eventInfo = EventInfoModel(
      calendarId: 'Main',
      uid: 'sdsadsada',
      title: title,
      location: location,
      description: description,
      date: date,
      start: startTime,
      end: endTime,
      rrule: rrule,
      type: _selectedType,
      createdAt: DateTime.now(),
      lastModified: DateTime.now(),
    );

    Navigator.of(context, rootNavigator: true).pop<EventInfoModel>(eventInfo);
  }
}

class EventTypeSection extends StatefulWidget {
  final EventType initialValue;
  final ValueChanged<EventType> onChanged;

  const EventTypeSection({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<EventTypeSection> createState() => _EventTypeSectionState();
}

class _EventTypeSectionState extends State<EventTypeSection> {
  late EventType? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  void _select(EventType type) {
    setState(() => _selected = (_selected == type) ? null : type);
    widget.onChanged(type);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Type',
            textAlign: TextAlign.left,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Wrap(
            spacing: 8,
            children: EventType.values.map((type) {
              if (type == EventType.UNDEFINED) return const SizedBox.shrink();
              return ChoiceChip(
                label: Text(type.label),
                selected: _selected == type,
                onSelected: (_) => _select(type),
              );
            }).toList(),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _buildFields(),
          ),
        ],
      ),
    );
  }

  Widget _buildFields() {
    switch (_selected) {
      case EventType.INTERVAL:
        return const _IntervalFields(key: ValueKey('interval'));
      case EventType.DEADLINE:
        return const _DeadlineFields(key: ValueKey('deadline'));
      case EventType.MULTI_DAY:
        return const _MultiDayFields(key: ValueKey('multi'));
      case EventType.REACCURING:
        return const _RecurringFields(key: ValueKey('recurring'));
      default:
        return const SizedBox.shrink();
    }
  }
}

class _IntervalFields extends StatelessWidget {
  const _IntervalFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        FormBuilderDateTimePicker(
          name: _INTERVAL_START_TAG,
          decoration: const InputDecoration(labelText: 'Start Time'),
        ),
        FormBuilderDateTimePicker(
          name: _INTERVAL_END_TAG,
          decoration: const InputDecoration(labelText: 'End Time'),
        ),
      ],
    );
  }
}

class _DeadlineFields extends StatelessWidget {
  const _DeadlineFields({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      inputType: InputType.time,
      name: _DEADLINE_TAG,
      decoration: const InputDecoration(labelText: 'Deadline'),
    );
  }
}

class _WeekdayPicker extends StatelessWidget {
  const _WeekdayPicker();

  static const double _size = 40;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormBuilderField<Set<int>>(
      name: _MULTI_DAY_WEEKDAYS_TAG,
      initialValue: const {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Select at least one day';
        }
        return null;
      },
      builder: (field) {
        final selected = field.value ?? {};

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: DaysOfTheWeek.values.map((d) {
            final day = d.toString();
            final isSelected = selected.contains(d.index);

            return InkWell(
              borderRadius: BorderRadius.circular(_size / 2),
              onTap: () {
                final updated = Set<int>.from(selected);
                isSelected ? updated.remove(d.index) : updated.add(d.index);
                field.didChange(updated);
              },
              child: AnimatedContainer(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 200),
                width: _size,
                height: _size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? theme.colorScheme.secondary
                      : theme.colorScheme.surface,
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.secondary
                        : theme.dividerColor,
                  ),
                ),
                child: Text(
                  day,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _MultiDayFields extends StatelessWidget {
  const _MultiDayFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        FormBuilderDateTimePicker(
          name: _MULTI_DAY_START_TIME_TAG,
          inputType: InputType.time,
          decoration: const InputDecoration(labelText: 'Start Time'),
        ),
        FormBuilderDateTimePicker(
          name: _MULTI_DAY_END_DATE_TAG,
          inputType: InputType.date,
          decoration: const InputDecoration(labelText: 'End Date'),
        ),

        const _WeekdayPicker(),
      ],
    );
  }
}

class _RecurringFields extends StatelessWidget {
  const _RecurringFields({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<Recurrance>(
      initialValue: Recurrance.DAILY,
      name: _RECURRING_TAG,
      decoration: const InputDecoration(labelText: 'Repeat'),
      items: Recurrance.values
          .map((r) => DropdownMenuItem(value: r, child: Text(r.label)))
          .toList(),
    );
  }
}
