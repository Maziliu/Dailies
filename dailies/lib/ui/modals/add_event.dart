import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddEventModal extends StatefulWidget {
  const AddEventModal({super.key});

  @override
  State<AddEventModal> createState() => _AddEventModalState();
}

class _AddEventModalState extends State<AddEventModal> {
  final _formKey = GlobalKey<FormBuilderState>();
  final String _TITLE_TAG = 'titleTag';
  final String _DESCRIPTION_TAG = 'descriptionTag';
  final String _LOCATION_TAG = 'locationTag';
  final String _START_TIME_TAG = 'startTimeTag';
  final String _END_TIME_TAG = 'endTimeTag';
  final String _DURATION_TAG = 'durationTag';
  final String _TYPE_TAG = 'typeTag';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      child: SingleChildScrollView(
        child: Padding(
          padding: UIFormating.largePadding(),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Add New Event',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                UIFormating.largeVerticalSpacing(),

                FormBuilderTextField(
                  name: _TITLE_TAG,
                  decoration: const InputDecoration(labelText: 'Title'),
                  autofocus: true,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Required'
                      : null,
                ),

                UIFormating.smallVerticalSpacing(),

                FormBuilderTextField(
                  name: _DESCRIPTION_TAG,
                  decoration: const InputDecoration(labelText: 'Description'),
                  autofocus: true,
                ),

                UIFormating.smallVerticalSpacing(),

                FormBuilderTextField(
                  name: _LOCATION_TAG,
                  decoration: const InputDecoration(labelText: 'Location'),
                  autofocus: true,
                ),

                UIFormating.mediumVerticalSpacing(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    onPressed: _submit,
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final state = _formKey.currentState;
    if (state == null || !state.validate()) return;

    final fields = state.fields;

    Navigator.of(context).pop<EventModel?>();
  }
}
