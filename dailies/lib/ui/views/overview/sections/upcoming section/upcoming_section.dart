import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:dailies/common/app_constants.dart';
import 'package:dailies/common/utils/build_context_extensions.dart';
import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/ui/components/schedule/schedule_item_widget.dart';
import 'package:dailies/ui/components/schedule/schedule_list_view_widget.dart';
import 'package:dailies/ui/views/shared/events_view_model.dart';
import 'package:flutter/material.dart';

class UpcomingSection extends StatelessWidget {
  final EventsViewModel _eventsViewModel;

  const UpcomingSection({super.key, required EventsViewModel eventsViewModel}) : _eventsViewModel = eventsViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsetsGeometry.fromLTRB(8, 8, 8, 12), child: Text('Upcoming', style: context.textTheme.headlineLarge)),
        SizedBox(
          height: MAX_SECTION_HEIGHT,
          child: ValueListenableBuilder<SplayTreeMap<DateTime, HeapPriorityQueue<TimeSlot>>>(
            valueListenable: _eventsViewModel.dateToTimeSlotsMap,
            builder: (context, map, _) {
              return ScheduleListViewWidget(
                pairs:
                    _eventsViewModel
                        .getUpcomingEvents()
                        .map((TimeSlot timeSlot) => EventTimeSlotPair(first: _eventsViewModel.eventLookup(timeSlot.eventId)!, second: timeSlot))
                        .toList(),
                builder: (pair) => ScheduleItemWidget(eventTimeSlotPair: pair, showDate: true),
              );
            },
          ),
        ),
      ],
    );
  }
}
