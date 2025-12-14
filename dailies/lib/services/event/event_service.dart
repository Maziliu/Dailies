import 'package:dailies_v2/database/daos/event_dao.dart';
import 'package:dailies_v2/database/database.dart';
import 'package:dailies_v2/models/event.dart';
import 'package:dailies_v2/utils/result.dart';

class EventService {
  final EventDao _dao;

  EventService({EventDao? dao}) : _dao = dao ?? EVENT_DAO;

  Future<Result<List<EventModel>>> getAllEvents() async {
    final Result<List<Event>> result = await guardedAsyncExecute(
      _dao.getAll,
      DatabaseFailure('Failed to retreive all events'),
    );

    switch (result) {
      case Ok<List<Event>>(value: final List<Event> events):
        return await guardedAsyncExecute(
          () async => events.map((e) => e.toModel()).toList(),
          ConversionFailure('Failed to convert events list into models'),
        );
      case Error<List<Event>>(failure: final Failure error):
        return Result.error(error);
    }
  }

  Future<Result<void>> deleteEvent(int? eventId) async {
    if (eventId == null) {
      return Result.error(
        ValidationFailure('Event id is null. Must be positive or zero'),
      );
    }

    if (eventId < 0) {
      return Result.error(
        ValidationFailure(
          'Event id: $eventId is invalid. Must be positive or zero',
        ),
      );
    }

    return await guardedAsyncExecute(
      () => _dao.deleteEvent(eventId),
      DatabaseFailure('Failed to delete event $eventId'),
    );
  }

  Future<Result<int>> insertEvent(EventModel event) async {
    if (event.id != null) {
      return Result.error(
        ValidationFailure('Inserting event should not have an id'),
      );
    }

    return await guardedAsyncExecute(
      () => _dao.insert(event.toCompanion()),
      DatabaseFailure('Failed to insert event'),
    );
  }
}
