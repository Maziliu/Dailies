import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/dao/event_dao.dart';
import 'package:dailies/data/mapper/event_mapper.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/repositories/mixin/crud_operations_mixin.dart';

class EventRepository with CRUDOperationsMixin {
  final EventDao _dao;
  final EventMapper _mapper;

  EventRepository({required EventDao dao, required EventMapper mapper}) : _dao = dao, _mapper = mapper;

  @override
  EventDao get dao => _dao;

  @override
  EventMapper get mapper => _mapper;

  Future<Result<List<AppModel>>> getEventsWithTimeSlotIds(List<int> timeSlotIds) async {
    Result results = await guardedAsyncExcecute(() => dao.getEventsWithTimeSlotIds(timeSlotIds));

    return performOperationOnResultIfNotError(results, (results) => results.map((result) => mapper.convertOutputToAppModel(result)).toList());
  }
}
