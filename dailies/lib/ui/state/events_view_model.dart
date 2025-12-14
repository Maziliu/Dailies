import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/services/event/event_service.dart';
import 'package:dailies_v2/utils/result.dart';

class EventsViewModel {
  final EventService _eventService = EventService();

  Future<void> getAllEvents() async {
    final Result<List<EventModel>> result = await _eventService.getAllEvents();

    switch (result) {
      case Ok<List<EventModel>>(value: final events):
        print('received $events');

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
}
