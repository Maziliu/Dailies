import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/ui/views/widgets/item_list.dart';
import 'package:dailies_v2/ui/views/widgets/schedule_list_item.dart';
import 'package:flutter/material.dart';

class EventsList extends StatelessWidget {
  final List<EventModel> events;

  const EventsList({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return ItemList<EventModel>(
      items: events,
      itemBuilder: (event) {
        return ScheduleItem(
          title: event.title,
          start: event.start,
          end: event.resolvedEnd,
          location: event.location,
        );
      },
    );
  }
}
