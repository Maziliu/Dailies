import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/models/time_slot_pattern.dart';
import 'package:dailies/data/repositories/time_slot_pattern_repository.dart';

class TimeSlotPatternRepositoryService {
  final TimeSlotPatternRepository _patternRepository;

  TimeSlotPatternRepositoryService({
    required TimeSlotPatternRepository patternRepository,
  }) : _patternRepository = patternRepository;

  Future<Result<int>> savePattern(TimeSlotPattern pattern) async =>
      _patternRepository.insert(pattern);
}
