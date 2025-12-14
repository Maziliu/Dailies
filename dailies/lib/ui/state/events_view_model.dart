import 'package:collection/collection.dart';
import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/services/event/event_service.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:flutter/foundation.dart';

typedef EventMapHeap = Map<DateTime, HeapPriorityQueue<EventModel>>;

class EventsViewModel extends ChangeNotifier {
  final EventService _eventService = EventService();

  final EventMapHeap eventMapHeap = EventMapHeap();

  Future<void> getAllEvents() async {
    final Result<List<EventModel>> result = await _eventService.getAllEvents();

    switch (result) {
      case Ok<List<EventModel>>(value: final events):
        for (final event in events) {
          _pushEventToHeap(event);
        }

        notifyListeners();

        print('received $events');
        print(eventMapHeap);

      case Error<List<EventModel>>(failure: final error):
        print('error: $error');
    }
  }

  Future<void> deleteEvent(int? id) async {
    final Result<void> result = await _eventService.deleteEvent(id);

    switch (result) {
      case Ok<void>():
        // TODO: Handle this case.
        throw UnimplementedError();
      case Error<void>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  Future<void> insertEvent(EventModel event) async {
    final Result<int> result = await _eventService.insertEvent(event);

    switch (result) {
      case Ok<int>(value: final int id):
        event.id = id;
        _pushEventToHeap(event);
        notifyListeners();

      case Error<int>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  List<EventModel> getEventsByDate(DateTime date) =>
      eventMapHeap[date]?.toList() ?? [];

  void _pushEventToHeap(EventModel event) {
    final DateTime date = DateTime(
      event.start.year,
      event.start.month,
      event.start.day,
    );

    final bool isNewKey = eventMapHeap[date] == null;

    if (isNewKey) {
      eventMapHeap[date] = HeapPriorityQueue();
    }

    eventMapHeap[date]?.add(event);
  }
}

final EventsViewModel EVENTS_VIEW_MODEL = EventsViewModel();
