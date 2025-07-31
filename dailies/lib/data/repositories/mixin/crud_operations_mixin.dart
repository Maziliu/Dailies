import 'package:dailies/common/exceptions/database_exceptions.dart';
import 'package:dailies/common/utils/safe_executers.dart';
import 'package:dailies/common/utils/result.dart';
import 'package:dailies/data/dao/generic_dao.dart';
import 'package:dailies/data/mapper/model_mapper.dart';
import 'package:dailies/data/models/app_model.dart';

mixin CRUDOperationsMixin {
  GenericDao get dao;
  ModelMapper get mapper;

  Future<Result<int>> insert(AppModel object) async {
    dynamic insertObject = mapper.convertAppModelToInputModel(object);
    return await guardedAsyncExcecute(() => dao.insertEntry(insertObject));
  }

  Future<Result<bool>> update(AppModel updatedObject) async {
    dynamic insertObject = mapper.convertAppModelToInputModel(updatedObject);
    return await guardedAsyncExcecute(() => dao.updateEntry(insertObject));
  }

  Future<Result<int>> deleteById(int id) async {
    return await guardedAsyncExcecute(() => dao.deleteEntryById(id));
  }

  Future<Result<AppModel>> getEntryById(int id) async {
    Result<dynamic> databaseResult = await guardedAsyncExcecute(
      () => dao.getEntryById(id),
    );

    switch (databaseResult) {
      case Ok(value: final dynamic result):
        AppModel convertedResult = mapper.convertOutputToAppModel(result);
        return Result.ok(convertedResult);

      default:
        return Result.error(DatabaseEntryNotFoundException());
    }
  }
}
