import 'package:dailies/common/utils/result.dart';
import 'package:dailies/common/utils/result_helpers.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/stamina.dart';
import 'package:dailies/data/repositories/stamina_repository.dart';
import 'package:dailies/service/notification/notification_service.dart';

class StaminaRepositoryService {
  final StaminaRepository _repository;
  final NotificationService _notificationService;

  StaminaRepositoryService({required StaminaRepository repository, required NotificationService notificationService})
    : _repository = repository,
      _notificationService = notificationService;

  Future<Result<List<Stamina>>> fetchAllStaminas() async {
    Result<List<AppModel>> results = await _repository.getAllStamina();

    return performOperationOnResultIfNotError(results, (resultList) => resultList.map((result) => result as Stamina).toList());
  }

  Future<Result<int>> saveStamina(Stamina stamina) async {
    Result<int> staminaResult = await _repository.insert(stamina);

    if (staminaResult is Ok) {
      stamina.id = (staminaResult as Ok).value;

      await guardedAsyncExcecute(() {
        final DateTime notificationTime = _calculateNotificationTime(stamina);
        return _notificationService.scheduleGachaTimerNotification(stamina, notificationTime, _calculateNotificationStamina(stamina));
      });
    }

    return staminaResult;
  }

  Future<Result<bool>> updateStamina(Stamina updatedStamina) async {
    Result<bool> updateResult = await _repository.update(updatedStamina);

    if (updateResult is Ok) {
      guardedAsyncExcecute(() {
        final DateTime notificationTime = _calculateNotificationTime(updatedStamina);
        return _notificationService.scheduleGachaTimerNotification(updatedStamina, notificationTime, _calculateNotificationStamina(updatedStamina));
      });
    }

    return updateResult;
  }

  Future<Result<int>> deleteStamina(Stamina stamina) async {
    guardedAsyncExcecute(() => _notificationService.cancelScheduledNotification(stamina.id));

    return _repository.deleteById(stamina.id);
  }

  int _calculateNotificationStamina(Stamina stamina) => (stamina.maxStamina * 0.95) ~/ 1;

  DateTime _calculateNotificationTime(Stamina stamina) {
    int notificationStamina = _calculateNotificationStamina(stamina);
    int timeToNotifyInSeconds = (notificationStamina - stamina.staminaOfLastestReset) * stamina.rechargeTime.inSeconds;

    print(timeToNotifyInSeconds);

    return stamina.timeOfLastReset.toUtc().add(Duration(seconds: timeToNotifyInSeconds));
  }
}
