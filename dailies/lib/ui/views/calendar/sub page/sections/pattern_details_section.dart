import 'package:dailies/common/enums/frequency_type.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/calendar/sub%20page/components/listenable_row_toggle.dart';
import 'package:dailies/ui/views/calendar/sub%20page/components/multi_select_calendar.dart';
import 'package:dailies/ui/views/calendar/sub%20page/sections/view%20models/pattern_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

const String FREQUENCY_FIELD_TAG = 'frequencyFieldTag';
const String FREQUENCY_TYPE_FIELD_TAG = 'frequencyTypeFieldTag';
const String END_DATE_FIELD_TAG = 'endDateFieldTag';

class PatternDetailsSection extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey;
  final PatternDetailsSectionViewModel _patternDetailsSectionViewModel;

  const PatternDetailsSection({super.key, required GlobalKey<FormBuilderState> formKey, required PatternDetailsSectionViewModel patternDetailsSectionViewModel})
    : _formKey = formKey,
      _patternDetailsSectionViewModel = patternDetailsSectionViewModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: UIFormating.mediumPadding(),
        child: ValueListenableBuilder(
          valueListenable: _patternDetailsSectionViewModel.patternSectionToggle,
          builder: (context, isSectionVisible, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListenableRowToggle(
                  toggleListenable: _patternDetailsSectionViewModel.patternSectionToggle,
                  labelText: 'Pattern',
                  toggledWidget: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        ListenableRowToggle(toggleListenable: _patternDetailsSectionViewModel.daylightSavingToggle, labelText: 'Daylight Savings'),
                        UIFormating.smallVerticalSpacing(),
                        ListenableRowToggle(
                          toggleListenable: _patternDetailsSectionViewModel.repeatablePatternToggle,
                          labelText: 'Repeatable',
                          toggledWidget: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: FormBuilderTextField(
                                      name: FREQUENCY_FIELD_TAG,
                                      decoration: const InputDecoration(labelText: 'Time Until Next Repeat', border: OutlineInputBorder()),
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) return 'Required';
                                        if (int.tryParse(value)! <= 0) return 'Must be greater than 0';

                                        return null;
                                      },
                                    ),
                                  ),
                                  UIFormating.mediumHorizontalSpacing(),
                                  Expanded(
                                    flex: 3,
                                    child: FormBuilderDropdown<FrequencyType>(
                                      name: FREQUENCY_TYPE_FIELD_TAG,
                                      decoration: const InputDecoration(labelText: 'Units', border: OutlineInputBorder()),
                                      items: FrequencyType.values.map((type) => DropdownMenuItem(value: type, child: Text(type.name))).toList(),
                                      validator: FormBuilderValidators.required(errorText: 'Required'),
                                    ),
                                  ),
                                ],
                              ),
                              UIFormating.smallVerticalSpacing(),
                              ListenableRowToggle(
                                toggleListenable: _patternDetailsSectionViewModel.finitePatternToggle,
                                labelText: 'Finite',
                                toggledWidget: FormBuilderDateTimePicker(
                                  name: END_DATE_FIELD_TAG,
                                  inputType: InputType.date,
                                  decoration: const InputDecoration(
                                    labelText: 'Pattern End Date',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.calendar_today_rounded),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        UIFormating.mediumVerticalSpacing(),
                        MultiSelectCalendar(viewModel: _patternDetailsSectionViewModel.calendarViewModel),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
