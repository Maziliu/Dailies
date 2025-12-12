import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/ui/components/schedule/schedule_item_widget.dart';
import 'package:dailies/ui/views/shared/events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekSubSection extends StatelessWidget {
  final EventsViewModel _eventsViewModel;

  const WeekSubSection({super.key, required EventsViewModel eventsViewModel})
    : _eventsViewModel = eventsViewModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<
      SplayTreeMap<DateTime, HeapPriorityQueue<TimeSlot>>
    >(
      valueListenable: _eventsViewModel.dateToTimeSlotsMap,
      builder: (context, _, _) {
        final DateTime now = DateTime.now(),
            sevenDaysLater = now.add(const Duration(days: 7)),
            lowerBound = DateTime(now.year, now.month, now.day),
            upperBound = DateTime(
              sevenDaysLater.year,
              sevenDaysLater.month,
              sevenDaysLater.day,
            );

        final Map<DateTime, List<TimeSlot>> timeSlots = _eventsViewModel
            .timeSlotRangeLookup(lowerBound, upperBound);

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final entry in timeSlots.entries)
                if (entry.value.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsetsGeometry.fromLTRB(8, 8, 0, 0),
                    child: Text(
                      DateFormat.yMMMMd().format(entry.key),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  ...entry.value.map(
                    (timeslot) => ScheduleItemWidget(
                      eventTimeSlotPair: EventTimeSlotPair(
                        first: _eventsViewModel.eventLookup(timeslot.eventId)!,
                        second: timeslot,
                      ),
                    ),
                  ),
                ],
            ],
          ),
        );
      },
    );
  }
}
