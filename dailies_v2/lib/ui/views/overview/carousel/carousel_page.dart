import 'package:dailies_v2/models/event_model.dart';
import 'package:dailies_v2/ui/views/overview/carousel/schedule_list_item.dart';
import 'package:dailies_v2/ui/views/overview/carousel/schedule_list.dart';
import 'package:flutter/material.dart';

class CarouselPage extends StatelessWidget {
  final List<EventModel> events;

  const CarouselPage({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return ScheduleList<EventModel>(
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
