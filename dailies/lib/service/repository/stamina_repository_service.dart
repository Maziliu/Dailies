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
    final Result<List<AppModel>> results = await _repository.getAllStamina();

    return performOperationOnResultIfNotError(results, (resultList) => resultList.map((result) => result as Stamina).toList());
  }

  Future<Result<int>> saveStamina(Stamina stamina) async {
    final Result<int> staminaResult = await _repository.insert(stamina);

    if (staminaResult is Ok) {
      stamina.id = (staminaResult as Ok).value;

      final Result notificationResult = await guardedAsyncExcecute(() {
        final DateTime notificationTime = _calculateNotificationTime(stamina);
        return _notificationService.scheduleGachaTimerNotification(stamina, notificationTime, _calculateNotificationStamina(stamina));
      });

      if (notificationResult is Error) return Result.error(notificationResult.error);
    }

    return staminaResult;
  }

  Future<Result<bool>> updateStamina(Stamina updatedStamina) async {
    final Result<bool> updateResult = await _repository.update(updatedStamina);

    if (updateResult is Ok) {
      final Result notificationResult = await guardedAsyncExcecute(() {
        final DateTime notificationTime = _calculateNotificationTime(updatedStamina);
        return _notificationService.scheduleGachaTimerNotification(updatedStamina, notificationTime, _calculateNotificationStamina(updatedStamina));
      });

      if (notificationResult is Error) return Result.error(notificationResult.error);
    }

    return updateResult;
  }

  Future<Result<int>> deleteStamina(Stamina stamina) async {
    final Result notificationResult = await guardedAsyncExcecute(() => _notificationService.cancelScheduledNotification(stamina.id));

    if (notificationResult is Error) return Result.error(notificationResult.error);

    return _repository.deleteById(stamina.id);
  }

  int _calculateNotificationStamina(Stamina stamina) => (stamina.maxStamina * 0.95) ~/ 1;

  DateTime _calculateNotificationTime(Stamina stamina) {
    final int notificationStamina = _calculateNotificationStamina(stamina);
    final int timeToNotifyInSeconds = (notificationStamina - stamina.staminaOfLastestReset) * stamina.rechargeTime.inSeconds;

    print(timeToNotifyInSeconds);

    return stamina.timeOfLastReset.toUtc().add(Duration(seconds: timeToNotifyInSeconds * 2));
  }
}
