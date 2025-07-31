import 'package:dailies/common/exceptions/database_exceptions.dart';
import 'package:dailies/common/utils/safe_executers.dart';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/local_database/interfaces/dao/generic_dao.dart';

mixin GenericCRUDMixin<TAppModel, TDatabaseModel, TInsertModel> {
  GenericDao<TDatabaseModel, TInsertModel> get dao;

  TInsertModel toInsertModel(TAppModel appModel) =>
      appModel
          as TInsertModel; // This is for db that dont have an intermediate like companion in drift
  TDatabaseModel toDatabaseModel(TAppModel appModel);
  TAppModel toAppModel(TDatabaseModel databaseModel);

  Future<Result<int>> insert(TAppModel object) async {
    TInsertModel insertObject = toInsertModel(object);
    return await guardedAsyncExcecute(() => dao.insertEntry(insertObject));
  }

  Future<Result<bool>> update(TAppModel updatedObject) async {
    TInsertModel insertObject = toInsertModel(updatedObject);
    return await guardedAsyncExcecute(() => dao.updateEntry(insertObject));
  }

  Future<Result<int>> deleteById(int id) async {
    return await guardedAsyncExcecute(() => dao.deleteEntryById(id));
  }

  Future<Result<TAppModel>> getEntryById(int id) async {
    Result<TDatabaseModel?> databaseResult = await guardedAsyncExcecute(
      () => dao.getEntryById(id),
    );

    switch (databaseResult) {
      case Ok(value: final TDatabaseModel result):
        TAppModel convertedResult = toAppModel(result);
        return Result.ok(convertedResult);

      default:
        return Result.error(DatabaseEntryNotFoundException());
    }
  }
}
