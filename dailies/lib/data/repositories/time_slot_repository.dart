import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/dao/time_slot_dao.dart';
import 'package:dailies/data/mapper/time_slot_mapper.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/repositories/mixin/crud_operations_mixin.dart';

class TimeSlotRepository with CRUDOperationsMixin {
  final TimeSlotDao _dao;
  final TimeSlotMapper _mapper;

  TimeSlotRepository({required TimeSlotDao dao, required TimeSlotMapper mapper}) : _dao = dao, _mapper = mapper;

  Future<Result<List<AppModel>>> getTimeSlotsBetween(DateTime lowerBound, DateTime upperBound) async {
    Result results = await guardedAsyncExcecute(() => dao.getTimeSlotsInDateTimeRange(lowerBound, upperBound));

    return performOperationOnResultIfNotError(results, (results) => results.map((result) => mapper.convertOutputToAppModel(result)).toList());
  }

  @override
  TimeSlotDao get dao => _dao;

  @override
  TimeSlotMapper get mapper => _mapper;
}
