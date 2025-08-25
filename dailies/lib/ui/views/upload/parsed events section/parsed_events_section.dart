import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/ui/components/schedule/schedule_item_widget.dart';
import 'package:dailies/ui/components/schedule/schedule_list_view_widget.dart';
import 'package:dailies/ui/components/section.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/upload/parsed%20events%20section/parsed_events_view_model.dart';
import 'package:flutter/material.dart';

class ParsedEventsSection extends StatelessWidget {
  final ParsedEventsViewModel _parsedEventsViewModel;

  const ParsedEventsSection({super.key, required ParsedEventsViewModel parsedEventsViewModel}) : _parsedEventsViewModel = parsedEventsViewModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Section(
            children: [
              const SectionHeader(title: 'Found Events'),
              SectionContent(
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _parsedEventsViewModel.foundEvents,
                      builder: (context, events, _) {
                        final Map<int, Event> idToEventMap = {for (final Event event in events) event.id: event};
                        final List<TimeSlot> timeSlots = [for (final Event event in events) ...event.timeSlots];

                        print(idToEventMap);
                        print(timeSlots);
                        print([for (var event in events) event.pattern]);
                        for (final Event event in events) {
                          event.timeSlots.clear();
                        }

                        return ScheduleListViewWidget(
                          pairs:
                              events
                                  .expand((Event event) => event.timeSlots.map((TimeSlot timeSlot) => EventTimeSlotPair(first: event, second: timeSlot)))
                                  .toList(),
                          builder: (pair) => ScheduleItemWidget(eventTimeSlotPair: pair),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: UIFormating.smallPadding(),
                  child: ElevatedButton(
                    onPressed: () {
                      _parsedEventsViewModel.foundEvents.value = [];
                    },
                    child: const Text('Clear'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: () => _parsedEventsViewModel.saveAllEvents, child: const Text('Add Found Events')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
