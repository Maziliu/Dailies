import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/data/models/time_slot_pattern.dart';
import 'package:dailies/data/repositories/time_slot_repository.dart';

class TimeSlotRepositoryService {
  final TimeSlotRepository _timeSlotRepository;

  TimeSlotRepositoryService({required TimeSlotRepository<dynamic, dynamic> timeSlotRepository}) : _timeSlotRepository = timeSlotRepository;

  Future<Result<int>> saveTimeSlot(TimeSlot timeSlot) async => await _timeSlotRepository.insert(timeSlot);

  Future<void> deleteTimeSlot(int timeSlotId) => _timeSlotRepository.deleteById(timeSlotId);

  Future<Result<List<TimeSlot>>> fetchTimeSlotsBetweenDates(DateTime lowerBound, DateTime upperBound) async {
    Result<List<AppModel>> results = await _timeSlotRepository.getTimeSlotsBetween(lowerBound, upperBound);

    return performOperationOnResultIfNotError(results, (results) => results.map((result) => result as TimeSlot).toList());
  }

  Future<Result<void>> saveAllTimeSlots(List<TimeSlot> timeSlots) async => await _timeSlotRepository.insertAllTimeSlots(timeSlots);

  Future<Result<void>> generateTimeSlotsForNextYear(int eventId, TimeSlotPattern pattern) async {
    List<TimeSlot> timeSlots = [...pattern.anchorPointsList];

    if (pattern.isReacurring) {
      DateTime limit = DateTime.now().add(const Duration(days: 365));
      Duration patternFrequency = pattern.frequency!;
      Duration totalOffset = patternFrequency;

      for (final TimeSlot timeSlot in pattern.anchorPointsList) {
        DateTime currentDate = _normalizeDate(timeSlot.dateOfTimeSlot);
        int offsetCount = 1;

        while (true) {
          Duration currentOffset = totalOffset * offsetCount;
          DateTime nextDate = currentDate.toUtc().add(currentOffset);
          print(_normalizeDate(nextDate));

          if (nextDate.isAfter(limit) || (pattern.isFinite && nextDate.isAfter(pattern.endPatternDate!))) {
            break;
          }

          timeSlots.add(
            TimeSlot(
              patternId: pattern.id,
              eventId: eventId,
              dateOfTimeSlot: _normalizeDate(nextDate),
              startTime: timeSlot.startTime,
              endTime: timeSlot.endTime,
            ),
          );

          offsetCount++;
        }
      }
    }

    return await _timeSlotRepository.insertAllTimeSlots(timeSlots);
  }

  DateTime _normalizeDate(DateTime date) => DateTime(date.year, date.month, date.day);
}
