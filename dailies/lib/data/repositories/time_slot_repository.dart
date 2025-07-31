import 'package:dailies/data/dao/time_slot_dao.dart';
import 'package:dailies/data/mapper/time_slot_mapper.dart';
import 'package:dailies/data/repositories/mixin/crud_operations_mixin.dart';

class TimeSlotRepository with CRUDOperationsMixin {
  final TimeSlotDao _dao;
  final TimeSlotMapper _mapper;

  TimeSlotRepository({required TimeSlotDao dao, required TimeSlotMapper mapper})
    : _dao = dao,
      _mapper = mapper;

  @override
  TimeSlotDao get dao => _dao;

  @override
  TimeSlotMapper get mapper => _mapper;
}
