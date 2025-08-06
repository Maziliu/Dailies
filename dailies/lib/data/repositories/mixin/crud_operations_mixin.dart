import 'package:dailies/common/exceptions/database_exceptions.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/dao/generic_dao.dart';
import 'package:dailies/data/mapper/model_mapper.dart';
import 'package:dailies/data/models/app_model.dart';

mixin RepositoryCRUDOperationsMixin<TIncomingDatabaseModel, TOutgoingDatabaseModel> {
  GenericDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> get dao;
  ModelMapper<TIncomingDatabaseModel, TOutgoingDatabaseModel> get mapper;

  Future<Result<int>> insert(AppModel object) async {
    TOutgoingDatabaseModel insertObject = mapper.convertAppModelToOutgoingDatabaseModel(object);
    return await guardedAsyncExcecute(() => dao.insertEntry(insertObject));
  }

  Future<Result<bool>> update(AppModel updatedObject) async {
    TOutgoingDatabaseModel insertObject = mapper.convertAppModelToOutgoingDatabaseModel(updatedObject);
    return await guardedAsyncExcecute(() => dao.updateEntry(insertObject));
  }

  Future<Result<int>> deleteById(int id) async {
    return await guardedAsyncExcecute(() => dao.deleteEntryById(id));
  }

  Future<Result<AppModel>> getEntryById(int id) async {
    Result<TIncomingDatabaseModel?> databaseResult = await guardedAsyncExcecute(() => dao.getEntryById(id));

    switch (databaseResult) {
      case Ok(value: final TIncomingDatabaseModel result):
        AppModel convertedResult = mapper.convertIncomingDatabaseModelToAppModel(result);
        return Result.ok(convertedResult);

      default:
        return Result.error(DatabaseEntryNotFoundException());
    }
  }
}
