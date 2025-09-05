import 'package:dailies/data/models/event.dart';
import 'package:dailies/ui/views/calendar/sub%20page/add_event_facade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SubmitSection extends StatelessWidget {
  final GlobalKey<FormBuilderState> _detailsFormKey, _patternFormKey;
  final AddEventFacade _viewModelFacade;

  const SubmitSection({
    super.key,
    required GlobalKey<FormBuilderState> detailsFormKey,
    required GlobalKey<FormBuilderState> patternFormKey,
    required AddEventFacade viewModelFacade,
  }) : _detailsFormKey = detailsFormKey,
       _patternFormKey = patternFormKey,
       _viewModelFacade = viewModelFacade;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ElevatedButton(
        onPressed: () {
          final Event? event = _viewModelFacade.createEvent(detailsFormKey: _detailsFormKey, patternFormKey: _patternFormKey);

          if (event != null) {
            Navigator.pop(context, event);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Create'),
      ),
    );
  }
}
