import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/calendar/sub%20page/components/listenable_time_picker_button.dart';
import 'package:dailies/ui/views/calendar/sub%20page/sections/view%20models/event_type_section_view_model.dart';
import 'package:flutter/material.dart';

class EventTypeSection extends StatelessWidget {
  final EventTypeSectionViewModel _viewModel;

  const EventTypeSection({super.key, required EventTypeSectionViewModel viewModel}) : _viewModel = viewModel;

  String _formatTimeSlotLabel(TimeSlotType type) {
    return type.name.replaceAll('_', ' ').replaceFirstMapped(RegExp(r'^.'), (match) => match.group(0)!.toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: UIFormating.mediumPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Type', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            UIFormating.smallVerticalSpacing(),
            ValueListenableBuilder(
              valueListenable: _viewModel.selectedTimeSlotIndex,
              builder: (context, _, _) {
                return Column(
                  children: [
                    ToggleButtons(
                      isSelected: _viewModel.timeSlotSelection,
                      onPressed: _viewModel.onTogglePress,
                      borderRadius: UIFormating.smallCircularBorderRadius(),
                      constraints: const BoxConstraints(minWidth: 100, minHeight: 40),
                      children:
                          TimeSlotType.values
                              .map(
                                (type) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(_formatTimeSlotLabel(type), textAlign: TextAlign.center),
                                ),
                              )
                              .toList(),
                    ),

                    UIFormating.smallVerticalSpacing(),

                    Visibility(
                      visible: _viewModel.selectedTimeSlotIndex.value == TimeSlotType.values.indexOf(TimeSlotType.Interval),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListenableTimePickerButton(listenable: _viewModel.pickedStartTime),
                              const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text('to')),
                              ListenableTimePickerButton(listenable: _viewModel.pickedEndTime),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Visibility(
                      visible: _viewModel.selectedTimeSlotIndex.value == TimeSlotType.values.indexOf(TimeSlotType.Deadline),
                      child: Padding(padding: const EdgeInsets.only(top: 8.0), child: ListenableTimePickerButton(listenable: _viewModel.pickedDeadline)),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
