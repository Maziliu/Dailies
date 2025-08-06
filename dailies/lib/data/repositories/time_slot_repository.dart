import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/dao/time_slot_dao.dart';
import 'package:dailies/data/mapper/time_slot_mapper.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/repositories/mixin/crud_operations_mixin.dart';

class TimeSlotRepository<TIncomingDatabaseModel, TOutgoingDatabaseModel> with RepositoryCRUDOperationsMixin<TIncomingDatabaseModel, TOutgoingDatabaseModel> {
  final TimeSlotDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> _dao;
  final TimeSlotMapper<TIncomingDatabaseModel, TOutgoingDatabaseModel> _mapper;

  TimeSlotRepository({
    required TimeSlotDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> dao,
    required TimeSlotMapper<TIncomingDatabaseModel, TOutgoingDatabaseModel> mapper,
  }) : _dao = dao,
       _mapper = mapper;

  Future<Result<List<AppModel>>> getTimeSlotsBetween(DateTime lowerBound, DateTime upperBound) async {
    Result<List<TIncomingDatabaseModel>> results = await guardedAsyncExcecute(() => _dao.getTimeSlotsInDateTimeRange(lowerBound, upperBound));

    return performOperationOnResultIfNotError(results, (results) => results.map((result) => mapper.convertIncomingDatabaseModelToAppModel(result)).toList());
  }

  @override
  TimeSlotDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> get dao => _dao;

  @override
  TimeSlotMapper<TIncomingDatabaseModel, TOutgoingDatabaseModel> get mapper => _mapper;
}
