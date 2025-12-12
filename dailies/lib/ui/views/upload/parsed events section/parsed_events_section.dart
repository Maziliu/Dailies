import 'package:collection/collection.dart';
import 'package:dailies/common/app_constants.dart';
import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/ui/components/schedule/schedule_item_widget.dart';
import 'package:dailies/ui/components/schedule/schedule_list_view_widget.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/upload/parsed%20events%20section/parsed_events_view_model.dart';
import 'package:flutter/material.dart';

class ParsedEventsSection extends StatelessWidget {
  final ParsedEventsViewModel _parsedEventsViewModel;

  const ParsedEventsSection({
    super.key,
    required ParsedEventsViewModel parsedEventsViewModel,
  }) : _parsedEventsViewModel = parsedEventsViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: _parsedEventsViewModel.foundEvents,
          builder: (context, events, clearButton) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '    Found (${events.expand((event) => event.timeSlots).length})',
                    ),
                    if (clearButton != null) clearButton,
                  ],
                ),
                SizedBox(
                  height: MAX_SECTION_HEIGHT,
                  child: ScheduleListViewWidget(
                    pairs: events
                        .expand(
                          (Event event) => event.timeSlots.map(
                            (TimeSlot timeSlot) => EventTimeSlotPair(
                              first: event,
                              second: timeSlot,
                            ),
                          ),
                        )
                        .sorted((a, b) => a.second.compareTo(b.second)),
                    builder:
                        (pair) => ScheduleItemWidget(
                          eventTimeSlotPair: pair,
                          showDate: true,
                        ),
                  ),
                ),
                if (events.isNotEmpty) _buildActionButtons(),
              ],
            );
          },
          child: TextButton(
            onPressed: _parsedEventsViewModel.clearFoundEvents,
            child: const Text('Clear'),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Center(
        child: Column(
          children: [
            UIFormating.mediumVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Edit'),
                  ),
                ),
                UIFormating.smallHorizontalSpacing(),
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        () async => _parsedEventsViewModel.saveAllEvents(),
                    child: const Text('Add Events'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
