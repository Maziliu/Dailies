import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/stamina.dart';
import 'package:dailies/data/repositories/stamina_repository.dart';

class StaminaRepositoryService {
  final StaminaRepository _repository;

  StaminaRepositoryService({required StaminaRepository repository}) : _repository = repository;

  Future<Result<List<Stamina>>> fetchAllStaminas() async {
    Result<List<AppModel>> results = await _repository.getAllStamina();

    return performOperationOnResultIfNotError(results, (resultList) => resultList.map((result) => result as Stamina).toList());
  }

  Future<Result<int>> saveStamina(Stamina stamina) async => await _repository.insert(stamina);

  Future<Result<bool>> updateStamina(Stamina updatedStamina) async => await _repository.update(updatedStamina);

  Future<Result<int>> deleteStamina(Stamina stamina) async => await _repository.deleteById(stamina.id);
}
