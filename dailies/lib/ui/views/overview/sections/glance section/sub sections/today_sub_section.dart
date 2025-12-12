import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/ui/components/schedule/schedule_item_widget.dart';
import 'package:dailies/ui/components/schedule/schedule_list_view_widget.dart';
import 'package:dailies/ui/views/shared/events_view_model.dart';
import 'package:flutter/material.dart';

class TodaySubSection extends StatelessWidget {
  final EventsViewModel _eventsViewModel;

  const TodaySubSection({super.key, required EventsViewModel eventsViewModel})
    : _eventsViewModel = eventsViewModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<
      SplayTreeMap<DateTime, HeapPriorityQueue<TimeSlot>>
    >(
      valueListenable: _eventsViewModel.dateToTimeSlotsMap,
      builder: (context, map, _) {
        final DateTime now = DateTime.now(),
            normalized = DateTime(now.year, now.month, now.day);

        return ScheduleListViewWidget(
          pairs:
              map[normalized]
                  ?.toList()
                  .map(
                    (TimeSlot timeslot) => EventTimeSlotPair(
                      first: _eventsViewModel.eventLookup(timeslot.eventId)!,
                      second: timeslot,
                    ),
                  )
                  .toList() ??
              [],
          builder: (pair) => ScheduleItemWidget(eventTimeSlotPair: pair),
        );
      },
    );
  }
}
