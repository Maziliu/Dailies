import 'package:dailies_v2/enums/event_type.dart';
import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:dailies_v2/utils/utils.dart';
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

enum Recurrance { SECONDLY, MINUTELY, HOURLY, DAILY, WEEKLY, MONTHLY, YEARLY }

extension RecurranceLabels on Recurrance {
  String get label {
    switch (this) {
      case Recurrance.SECONDLY:
        return 'Secondly';
      case Recurrance.MINUTELY:
        return 'Minutely';
      case Recurrance.HOURLY:
        return 'Hourly';
      case Recurrance.DAILY:
        return 'Daily';
      case Recurrance.WEEKLY:
        return 'Weekly';
      case Recurrance.MONTHLY:
        return 'Monthly';
      case Recurrance.YEARLY:
        return 'Yearly';
    }
  }

  String get rrule {
    switch (this) {
      case Recurrance.SECONDLY:
        return 'FREQ=SECONDLY';
      case Recurrance.MINUTELY:
        return 'FREQ=MINUTELY';
      case Recurrance.HOURLY:
        return 'FREQ=HOURLY';
      case Recurrance.DAILY:
        return 'FREQ=DAILY';
      case Recurrance.WEEKLY:
        return 'FREQ=WEEKLY';
      case Recurrance.MONTHLY:
        return 'FREQ=MONTHLY';
      case Recurrance.YEARLY:
        return 'FREQ=YEARLY';
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
const _RECURRING_UNTIL_TAG = 'RECURRING_UNTIL_TAG';
final _FORM_KEY = GlobalKey<FormBuilderState>();

class AddOrUpdateEventModal extends StatefulWidget {
  final EventInfoModel? eventInfoToUpdate;

  const AddOrUpdateEventModal({super.key, this.eventInfoToUpdate});

  @override
  State<AddOrUpdateEventModal> createState() => _AddOrUpdateEventModalState();
}

class _AddOrUpdateEventModalState extends State<AddOrUpdateEventModal> {
  EventType _selectedType = EventType.INTERVAL;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final EventInfoModel? eventInfoToUpdate = widget.eventInfoToUpdate;
    final bool isEditMode = eventInfoToUpdate != null;

    if (isEditMode) {
      _selectedType = eventInfoToUpdate.type;
    }

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
                isEditMode ? 'Edit Event' : 'Add Event',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              FormBuilderTextField(
                name: _TITLE_TAG,
                initialValue: eventInfoToUpdate?.title,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),

              FormBuilderTextField(
                name: _LOCATION_TAG,
                initialValue: eventInfoToUpdate?.location,
                decoration: const InputDecoration(labelText: 'Location'),
              ),

              FormBuilderTextField(
                name: _DESCRIPTION_TAG,
                initialValue: eventInfoToUpdate?.description,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 5,
              ),
              FormBuilderDateTimePicker(
                name: _DATE_TAG,
                initialValue: CALENDAR_VIEW_MODEL.selectedDay,
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
    final String? location = state.fields[_LOCATION_TAG]?.value as String?;
    final String? description =
        state.fields[_DESCRIPTION_TAG]?.value as String?;
    final DateTime date = state.fields[_DATE_TAG]?.value as DateTime;

    DateTime? startTime, endTime;
    String? rrule;

    switch (_selectedType) {
      case EventType.REACCURING:
        final Recurrance recurrance =
            state.fields[_RECURRING_TAG]?.value as Recurrance;

        final DateTime until =
            state.fields[_RECURRING_UNTIL_TAG]?.value as DateTime;

        rrule = '${recurrance.rrule};UNTIL=${formatDateToICS(until)}';

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
  final EventInfoModel? eventInfoToUpdate;

  const EventTypeSection({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.eventInfoToUpdate,
  });

  @override
  State<EventTypeSection> createState() => _EventTypeSectionState();
}

class _EventTypeSectionState extends State<EventTypeSection> {
  late EventType? _selected;
  late EventInfoModel? _eventInfoToUpdate;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
    _eventInfoToUpdate = widget.eventInfoToUpdate;
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
              if (type == EventType.UNDEFINED || type == EventType.MULTI_DAY) {
                return const SizedBox.shrink();
              }
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
        return _IntervalFields(
          key: const ValueKey('interval'),
          start: _eventInfoToUpdate?.start,
          end: _eventInfoToUpdate?.end,
        );
      case EventType.DEADLINE:
        return _DeadlineFields(
          key: const ValueKey('deadline'),
          due: _eventInfoToUpdate?.end,
        );
      case EventType.REACCURING:
        return _RecurringFields(
          key: const ValueKey('recurring'),
          rrule: _eventInfoToUpdate?.rrule,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _IntervalFields extends StatelessWidget {
  final DateTime? start, end;

  const _IntervalFields({super.key, this.start, this.end});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        FormBuilderDateTimePicker(
          initialValue: start,
          inputType: InputType.time,
          name: _INTERVAL_START_TAG,
          decoration: const InputDecoration(labelText: 'Start Time'),
          validator: (date) => date == null ? 'Required' : null,
        ),
        FormBuilderDateTimePicker(
          initialValue: end,
          inputType: InputType.time,
          name: _INTERVAL_END_TAG,
          decoration: const InputDecoration(labelText: 'End Time'),
          validator: (date) => date == null ? 'Required' : null,
        ),
      ],
    );
  }
}

class _DeadlineFields extends StatelessWidget {
  final DateTime? due;

  const _DeadlineFields({super.key, this.due});

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      initialValue: due,
      inputType: InputType.time,
      name: _DEADLINE_TAG,
      decoration: const InputDecoration(labelText: 'Deadline'),
      validator: (date) => date == null ? 'Required' : null,
    );
  }
}

class _RecurringFields extends StatelessWidget {
  final String? rrule;

  const _RecurringFields({super.key, this.rrule});

  @override
  Widget build(BuildContext context) {
    final parts = rrule != null
        ? {
            for (final p in rrule!.split(';'))
              if (p.contains('=')) p.split('=').first: p.split('=').last,
          }
        : null;

    return Column(
      children: [
        FormBuilderDropdown<Recurrance?>(
          initialValue: parts != null && parts.containsKey('FREQ')
              ? Recurrance.values.firstWhere(
                  (x) => x.name == parts['FREQ'],
                  orElse: () => Recurrance.SECONDLY,
                )
              : null,
          name: _RECURRING_TAG,
          decoration: const InputDecoration(labelText: 'Repeat'),
          items: Recurrance.values
              .map((r) => DropdownMenuItem(value: r, child: Text(r.label)))
              .toList(),
          validator: (date) => date == null ? 'Required' : null,
        ),
        const SizedBox(height: 8),
        FormBuilderDateTimePicker(
          name: _RECURRING_UNTIL_TAG,
          initialValue: parts != null && parts.containsKey('UNTIL')
              ? DateTime.tryParse(parts['UNTIL']!)
              : null,
          inputType: InputType.date,
          decoration: const InputDecoration(labelText: 'End Date'),
          validator: (date) => date == null ? 'Required' : null,
        ),
      ],
    );
  }
}
