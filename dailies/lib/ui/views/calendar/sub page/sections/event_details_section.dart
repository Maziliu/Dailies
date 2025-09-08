import 'package:dailies/common/utils/build_context_extensions.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

const String EVENT_NAME_FIELD_TAG = 'eventNameField';
const String LOCATION_NAME_FIELD_TAG = 'locationNameField';

class EventDetailsSection extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey;

  const EventDetailsSection({super.key, required GlobalKey<FormBuilderState> formKey}) : _formKey = formKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: UIFormating.mediumPadding(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Event Details', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              UIFormating.smallVerticalSpacing(),
              FormBuilderTextField(
                name: EVENT_NAME_FIELD_TAG,
                decoration: const InputDecoration(labelText: 'Event Name', border: OutlineInputBorder()),
                validator: (value) => (value == null) ? 'Required' : null,
              ),
              UIFormating.mediumVerticalSpacing(),
              FormBuilderTextField(name: LOCATION_NAME_FIELD_TAG, decoration: const InputDecoration(labelText: 'Location', border: OutlineInputBorder())),
            ],
          ),
        ),
      ),
    );
  }
}
