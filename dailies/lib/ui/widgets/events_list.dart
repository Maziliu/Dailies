import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/ui/modals/add_update_event.dart';
import 'package:dailies_v2/ui/modals/delete_event.dart';
import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/widgets/item_list.dart';
import 'package:dailies_v2/ui/widgets/schedule_list_item.dart';
import 'package:flutter/material.dart';

class EventsList extends StatelessWidget {
  final List<EventUIModel> events;
  final bool showDate, disableOnHold;

  const EventsList({
    super.key,
    required this.events,
    this.showDate = false,
    this.disableOnHold = false,
  });

  void _handleOnHold(EventUIModel event, BuildContext context) async {
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
  }

  void _pushInfoModal(EventUIModel event, BuildContext context) async {}

  void _pushUpdateModal(EventUIModel event, BuildContext context) async {
    final EventInfoModel? result = await showDialog(
      context: context,
      builder: (_) => AddOrUpdateEventModal(eventInfoToUpdate: event),
    );

    if (result == null) {
      return;
    }

    await EVENTS_VIEW_MODEL.deleteAllEventsInSeries(event.seriesId);
    EVENTS_VIEW_MODEL.createEvent(result);
  }

  @override
  Widget build(BuildContext context) {
    return ItemList<EventUIModel>(
      items: events,
      itemBuilder: (event) {
        return ScheduleItem(
          onTap: event.seriesId != null
              ? () => _pushInfoModal(event, context)
              : null,
          onDoubleTap: event.seriesId != null
              ? () => _pushUpdateModal(event, context)
              : null,
          onHold: () => _handleOnHold(event, context),
          title: event.title,
          date: event.date,
          start: event.start,
          end: event.end,
          location: event.location,
          type: event.type,
          showDate: showDate,
          disableOnHold: disableOnHold,
        );
      },
    );
  }
}
