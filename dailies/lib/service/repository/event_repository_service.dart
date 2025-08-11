import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/data/repositories/event_repository.dart';
import 'package:dailies/service/repository/time_slot_repository_service.dart';

class EventRepositoryService {
  final TimeSlotRepositoryService _timeSlotService;
  final EventRepository _eventRepository;

  EventRepositoryService({required TimeSlotRepositoryService timeSlotService, required EventRepository<dynamic, dynamic> eventRepository})
    : _eventRepository = eventRepository,
      _timeSlotService = timeSlotService;

  Future<Result<int>> saveEvent(Event event) async {
    List<TimeSlot> times = event.timeSlots;

    for (int i = times.length - 1; i >= 0; i--) {
      Result<int> result = await _timeSlotService.saveTimeSlot(times[i]);

      switch (result) {
        case Ok<int>(value: int id):
          if (i > 0) {
            times[i - 1].nextTimeSlotId = id;
          } else {
            times[i].id = id;
          }
        case Error<int>():
          return result;
      }
    }

    event.timeSlotHeadId = times.first.id;

    return await _eventRepository.insert(event);
  }

  Future<Result<List<Event>>> fetchAllEventsBetweenDates(DateTime lowerBound, DateTime upperBound) async {
    Result<List<TimeSlot>> timeSlotsResult = await _timeSlotService.fetchTimeSlotsBetweenDates(lowerBound, upperBound);
    List<TimeSlot> timeSlots;
    switch (timeSlotsResult) {
      case Ok<List<TimeSlot>>(value: final List<TimeSlot> values):
        timeSlots = values;

      case Error<List<TimeSlot>>(error: final Exception error):
        return Result.error(error);
    }
    Result<List<AppModel>> results = await _eventRepository.getEventsWithTimeSlotIds([for (final TimeSlot timeSlot in timeSlots) timeSlot.id]);

    Result<List<Event>> eventsResult = performOperationOnResultIfNotError(results, (results) => results.map((result) => result as Event).toList());

    List<Event> events;
    switch (eventsResult) {
      case Ok<List<Event>>(value: final List<Event> values):
        events = values;
      case Error<List<Event>>(error: final Exception error):
        return Result.error(error);
    }

    for (final Event event in events) {
      _constructEventWithTimes(event, timeSlots);
    }

    return Result.ok((events));
  }

  //Since the fk relation for event and timeslot is event references timeslot onDeleteCascade, I have to delete the timeslot to delete the event
  Future<void> deleteEvent(Event event) => _timeSlotService.deleteTimeSlot(event.timeSlotHeadId);

  //Assumes timeSlots is a random assortment of times that may or may not belong to the given event
  //Note: TimeSlot is stored in linked list structure and this prob can be done more efficiently at the db level and is subject to change dep on current performance
  void _constructEventWithTimes(Event event, List<TimeSlot> timeSlots) {
    int? currentId = event.timeSlotHeadId;

    while (currentId != null) {
      TimeSlot currentTimeSlot = timeSlots.where((timeSlot) => timeSlot.id == currentId).single;
      event.timeSlots.add(currentTimeSlot);
      currentId = currentTimeSlot.nextTimeSlotId;
    }
  }
}
