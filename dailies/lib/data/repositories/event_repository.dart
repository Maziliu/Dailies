import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/dao/event_dao.dart';
import 'package:dailies/data/mapper/event_mapper.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/repositories/mixin/crud_operations_mixin.dart';

class EventRepository<TIncomingDatabaseModel, TOutgoingDatabaseModel>
    with
        RepositoryCRUDOperationsMixin<
          TIncomingDatabaseModel,
          TOutgoingDatabaseModel
        > {
  final EventDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> _dao;
  final EventMapper<TIncomingDatabaseModel, TOutgoingDatabaseModel> _mapper;

  EventRepository({
    required EventDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> dao,
    required EventMapper<TIncomingDatabaseModel, TOutgoingDatabaseModel> mapper,
  }) : _dao = dao,
       _mapper = mapper;

  Future<Result<List<AppModel>>> getAllEventsWithIds(List<int> ids) async {
    final Result<List<TIncomingDatabaseModel>> results =
        await guardedAsyncExcecute(() => _dao.getAllEventsWithIds(ids));

    return performOperationOnResultIfNotError(
      results,
      (results) =>
          results.map(_mapper.convertIncomingDatabaseModelToAppModel).toList(),
    );
  }

  @override
  EventDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> get dao => _dao;

  @override
  EventMapper<TIncomingDatabaseModel, TOutgoingDatabaseModel> get mapper =>
      _mapper;
}
