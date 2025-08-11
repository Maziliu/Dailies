import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/time_slot.dart';
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
}
