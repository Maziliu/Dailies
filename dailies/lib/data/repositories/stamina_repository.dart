import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/dao/stamina_dao.dart';
import 'package:dailies/data/mapper/stamina_mapper.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/stamina.dart';
import 'package:dailies/data/repositories/mixin/crud_operations_mixin.dart';

class StaminaRepository<TIncomingDatabaseModel, TOutgoingDatabaseModel> with RepositoryCRUDOperationsMixin<TIncomingDatabaseModel, TOutgoingDatabaseModel> {
  final StaminaDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> _dao;
  final StaminaMapper<TIncomingDatabaseModel, TOutgoingDatabaseModel> _mapper;

  StaminaRepository({
    required StaminaDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> dao,
    required StaminaMapper<TIncomingDatabaseModel, TOutgoingDatabaseModel> mapper,
  }) : _dao = dao,
       _mapper = mapper;

  Future<Result<List<AppModel>>> getAllStamina() async {
    Result<List<TIncomingDatabaseModel>> results = await guardedAsyncExcecute(() => _dao.getAllStaminaEntries());

    return performOperationOnResultIfNotError(
      results,
      (resultList) => resultList.map((result) => _mapper.convertIncomingDatabaseModelToAppModel(result)).toList(),
    );
  }

  @override
  StaminaDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> get dao => _dao;

  @override
  StaminaMapper<TIncomingDatabaseModel, TOutgoingDatabaseModel> get mapper => _mapper;
}
