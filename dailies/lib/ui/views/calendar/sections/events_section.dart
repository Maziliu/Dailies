import 'package:dailies/common/app_constants.dart';
import 'package:dailies/common/utils/build_context_extensions.dart';
import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/ui/components/popup%20cards/delete_confirmation_popup_card.dart';
import 'package:dailies/ui/components/schedule/schedule_item_widget.dart';
import 'package:dailies/ui/components/schedule/schedule_list_view_widget.dart';
import 'package:dailies/ui/views/calendar/sub%20page/add_event_sub_page.dart';
import 'package:dailies/ui/views/shared/events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsSection extends StatelessWidget {
  final EventsViewModel _eventsViewModel;

  const EventsSection({super.key, required EventsViewModel eventsViewModel})
    : _eventsViewModel = eventsViewModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _eventsViewModel.selectedDayNotifier,
      builder: (context, selectedDay, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsetsGeometry.fromLTRB(8, 8, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.MMMMEEEEd().format(selectedDay),
                    style: context.textTheme.headlineLarge,
                  ),
                  IconButton(
                    onPressed: () async {
                      final Event? newEvent = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  AddEventSubPage(selectedDay: selectedDay),
                        ),
                      );

                      if (newEvent != null) {
                        _eventsViewModel.addEvent(newEvent);
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MAX_SECTION_HEIGHT * 1.5),
              child: ScheduleListViewWidget(
                pairs:
                    _eventsViewModel
                        .timeSlotsLookup(selectedDay)
                        .map(
                          (TimeSlot timeSlot) => EventTimeSlotPair(
                            first:
                                _eventsViewModel.eventLookup(timeSlot.eventId)!,
                            second: timeSlot,
                          ),
                        )
                        .toList(),
                builder:
                    (pair) => InkWell(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteConfirmationDialog(
                              itemName: pair.first.eventName,
                              onDelete: () async {
                                await _eventsViewModel.deleteEvent(pair.first);
                              },
                            );
                          },
                        );
                      },
                      onTap: () {},
                      child: ScheduleItemWidget(eventTimeSlotPair: pair),
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
