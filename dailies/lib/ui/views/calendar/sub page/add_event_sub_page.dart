import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/calendar/sub%20page/add_event_facade.dart';
import 'package:dailies/ui/views/calendar/sub%20page/sections/event_details_section.dart';
import 'package:dailies/ui/views/calendar/sub%20page/sections/event_type_section.dart';
import 'package:dailies/ui/views/calendar/sub%20page/sections/pattern_details_section.dart';
import 'package:dailies/ui/views/calendar/sub%20page/sections/submit_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddEventSubPage extends StatelessWidget {
  final DateTime _selectedDay;

  const AddEventSubPage({super.key, required DateTime selectedDay}) : _selectedDay = selectedDay;

  @override
  Widget build(BuildContext context) {
    final AddEventFacade viewModelFacade = AddEventFacade(selectedDay: _selectedDay);
    final GlobalKey<FormBuilderState> detailsFormKey = GlobalKey<FormBuilderState>();
    final GlobalKey<FormBuilderState> patternFormKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Create New Event'), centerTitle: true, elevation: 1),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Padding(
          padding: UIFormating.largePadding(),
          child: Column(
            children: [
              EventDetailsSection(formKey: detailsFormKey),
              UIFormating.smallVerticalSpacing(),
              EventTypeSection(viewModel: viewModelFacade.eventTypeSectionViewModel),
              UIFormating.smallVerticalSpacing(),
              PatternDetailsSection(formKey: patternFormKey, patternDetailsSectionViewModel: viewModelFacade.patternDetailsSectionViewModel),
              UIFormating.extraLargeVerticalSpacing(),
              SubmitSection(detailsFormKey: detailsFormKey, patternFormKey: patternFormKey, viewModelFacade: viewModelFacade, selectedDay: _selectedDay),
            ],
          ),
        ),
      ),
    );
  }
}
