import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:dailies/common/app_constants.dart';
import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/ui/components/schedule/schedule_item_widget.dart';
import 'package:dailies/ui/components/schedule/schedule_list_view_widget.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/shared/events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodaySection extends StatelessWidget {
  final EventsViewModel _eventsViewModel;

  const TodaySection({super.key, required EventsViewModel eventsViewModel}) : _eventsViewModel = eventsViewModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      children: [
        Padding(
          padding: UIFormating.smallPadding(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Expanded(child: Text('Today', style: textTheme.headlineLarge)), Text(DateFormat.yMMMMd().format(DateTime.now()))],
          ),
        ),
        SizedBox(
          height: MAX_SECTION_HEIGHT,
          child: ValueListenableBuilder<SplayTreeMap<DateTime, HeapPriorityQueue<TimeSlot>>>(
            valueListenable: _eventsViewModel.dateToTimeSlotsMap,
            builder: (context, map, _) {
              DateTime now = DateTime.now(), normalized = DateTime(now.year, now.month, now.day);

              return ScheduleListViewWidget(
                pairs:
                    map[normalized]
                        ?.toList()
                        .map((TimeSlot timeslot) => EventTimeSlotPair(first: _eventsViewModel.eventLookup(timeslot.eventId)!, second: timeslot))
                        .toList() ??
                    [],
                builder: (pair) => ScheduleItemWidget(eventTimeSlotPair: pair),
              );
            },
          ),
        ),
      ],
    );
  }
}
