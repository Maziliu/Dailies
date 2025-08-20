import 'package:dailies/data/dao/time_slot_pattern_dao.dart';
import 'package:dailies/data/mapper/time_slot_pattern_mapper.dart';
import 'package:dailies/data/repositories/mixin/crud_operations_mixin.dart';

class TimeSlotPatternRepository with RepositoryCRUDOperationsMixin {
  final TimeSlotPatternDao _dao;
  final TimeSlotPatternMapper _mapper;

  TimeSlotPatternRepository({required TimeSlotPatternDao dao, required TimeSlotPatternMapper mapper}) : _dao = dao, _mapper = mapper;

  @override
  TimeSlotPatternDao get dao => _dao;

  @override
  TimeSlotPatternMapper get mapper => _mapper;
}
