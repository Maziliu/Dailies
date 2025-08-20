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
    Result<int> eventResult = await _eventRepository.insert(event);

    if (eventResult is Error) return eventResult;

    Result<int> patternResult = await _patternService.savePattern(event.pattern);

    if (patternResult is Error) return patternResult;

    Result<void> timeSlotResult = await _timeSlotService.generateTimeSlotsForNextYear(event.id, event.pattern);

    if (timeSlotResult is Error) return Result.error(timeSlotResult.error);

    return eventResult;
  }

  Future<Result<List<Event>>> fetchAllEventsBetweenDates(DateTime lowerBound, DateTime upperBound) async {
    throw UnimplementedError();
  }

  Future<void> deleteEvent(Event event) => _eventRepository.deleteById(event.id);

  //Assumes timeSlots is a random assortment of times that may or may not belong to the given event
  //Note: TimeSlot is stored in linked list structure and this prob can be done more efficiently at the db level and is subject to change dep on current performance
  void _constructEventWithTimes(Event event, List<TimeSlot> timeSlots) {
    throw UnimplementedError();
  }
}
