import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/ui/modals/delete_event.dart';
import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/widgets/item_list.dart';
import 'package:dailies_v2/ui/widgets/schedule_list_item.dart';
import 'package:flutter/material.dart';

class EventsList extends StatelessWidget {
  final List<EventUIModel> events;
  final bool showDate;

  const EventsList({super.key, required this.events, this.showDate = false});

  @override
  Widget build(BuildContext context) {
    return ItemList<EventUIModel>(
      items: events,
      itemBuilder: (event) {
        return ScheduleItem(
          onHold: () async {
            final EventDeleteOptions? result = await showDialog(
              context: context,
              builder: (_) => DeleteEventModal(
                title: 'Delete ${event.title}?',
                message: 'This action cannot be undone.',
              ),
            );

            if (result == null) {
              return;
            }

            switch (result) {
              case EventDeleteOptions.CANCEL:
                return;
              case EventDeleteOptions.DELETE_SERIES:
                EVENTS_VIEW_MODEL.deleteAllEventsInSeries(event.seriesId);
              case EventDeleteOptions.DELETE_INSTANCE:
                EVENTS_VIEW_MODEL.deleteEventInstance(event.instanceId);
            }
          },
          title: event.title,
          date: event.date,
          start: event.start,
          end: event.end,
          location: event.location,
          type: event.type,
          showDate: showDate,
        );
      },
    );
  }
}
