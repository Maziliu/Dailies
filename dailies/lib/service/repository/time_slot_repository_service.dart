import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/data/repositories/time_slot_repository.dart';

class TimeSlotRepositoryService {
  final TimeSlotRepository timeSlotRepository;

  TimeSlotRepositoryService({required this.timeSlotRepository});

  Future<Result<int>> saveTimeSlot(TimeSlot timeSlot) async {
    return await timeSlotRepository.insert(timeSlot);
  }

  Future<Result<List<TimeSlot>>> fetchTimeSlotsBetweenDates(DateTime lowerBound, DateTime upperBound) async {
    Result results = await timeSlotRepository.getTimeSlotsBetween(lowerBound, upperBound);

    return performOperationOnResultIfNotError(results, (results) => results.map((result) => result as TimeSlot).toList());
  }
}
