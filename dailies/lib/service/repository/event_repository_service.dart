import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/data/repositories/event_repository.dart';
import 'package:dailies/service/repository/time_slot_pattern_repository_service.dart';
import 'package:dailies/service/repository/time_slot_repository_service.dart';

class EventRepositoryService {
  final TimeSlotRepositoryService _timeSlotService;
  final TimeSlotPatternRepositoryService _patternService;
  final EventRepository _eventRepository;

  EventRepositoryService({
    required TimeSlotRepositoryService timeSlotService,
    required TimeSlotPatternRepositoryService patternService,
    required EventRepository eventRepository,
  }) : _timeSlotService = timeSlotService,
       _patternService = patternService,
       _eventRepository = eventRepository;

  Future<Result<int>> saveEvent(Event event) async {
    final Result<int> eventResult = await _eventRepository.insert(event);

    switch (eventResult) {
      case Ok<int>(value: final int eventId):
        event.id = eventId;
        event.pattern.eventId = eventId;
      case Error<int>():
        return eventResult;
    }

    final Result<int> patternResult = await _patternService.savePattern(event.pattern);

    switch (patternResult) {
      case Ok<int>(value: final int patternId):
        event.pattern.id = patternId;
        for (final TimeSlot timeSlot in event.pattern.anchorPointsList) {
          timeSlot.eventId = event.id;
          timeSlot.patternId = patternId;
        }
      case Error<int>():
        return patternResult;
    }

    final Result<void> timeSlotResult = await _timeSlotService.generateTimeSlotsForNextYear(event.id, event.pattern);

    if (timeSlotResult is Error) return Result.error(timeSlotResult.error);

    return eventResult;
  }

  Future<Result<List<Event>>> fetchAllEventsBetweenDates(DateTime lowerBound, DateTime upperBound) async {
    final Result timeSlotsResult = await _timeSlotService.fetchTimeSlotsBetweenDates(lowerBound, upperBound);
    if (timeSlotsResult is Error) return Result.error(timeSlotsResult.error);

    final List<int> eventIds = [for (final TimeSlot timeSlot in (timeSlotsResult as Ok).value) timeSlot.eventId];
    final Result<List<AppModel>> eventsResult = await _eventRepository.getAllEventsWithIds(eventIds);

    final Result<List<Event>> events = performOperationOnResultIfNotError(eventsResult, (eventsResult) => eventsResult.map((event) => event as Event).toList());
    if (events is Error) return events;

    final List<TimeSlot> timeSlots = timeSlotsResult.value;

    for (final Event event in (events as Ok).value) {
      for (final TimeSlot timeSlot in timeSlots) {
        if (timeSlot.eventId == event.id) {
          event.timeSlots.add(timeSlot);
        }
      }
    }

    return events;
  }

  Future<Result<void>> deleteEvent(Event event) => _eventRepository.deleteById(event.id);
}
