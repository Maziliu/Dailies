import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/services/gacha/stamina_service.dart';
import 'package:dailies_v2/services/notifications/local_notification_service.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:dailies_v2/utils/snackbar.dart';
import 'package:flutter/foundation.dart';

class GachaViewModel extends ChangeNotifier {
  final ValueNotifier<List<StaminaModel>> staminas = ValueNotifier([]);
  final StaminaService _staminaService = StaminaService();

  void insertStamina(StaminaModel stamina) async {
    final Result<int> result = await _staminaService.insertStamina(stamina);

    switch (result) {
      case Ok<int>(value: final int id):
        stamina.id = id;
        staminas.value = [...staminas.value, stamina];
        showSuccessSnackbar('Added ${id.toString()} ${stamina.gachaTitle}');

        final Result<void> notificationResult = await LOCAL_NOTIFICATION_SERVICE
            .scheduleGachaNotification(stamina);

        switch (notificationResult) {
          case Error<void>(failure: final Failure failure):
            showErrorSnackbar(
              failure: failure,
              customMessage:
                  'Could not schedule notification ${stamina.id} ${failure.message}',
            );
          case Ok<void>():
        }

      case Error<int>(failure: final Failure failure):
        showErrorSnackbar(
          failure: failure,
          customMessage: 'Unable to add ${stamina} ${failure.message}',
        );
    }
  }

  Future<void> loadAllStaminas() async {
    final Result<List<StaminaModel>> result = await _staminaService
        .getAllStaminas();

    switch (result) {
      case Ok<List<StaminaModel>>(value: final List<StaminaModel> stams):
        staminas.value = [...stams];
      case Error<List<StaminaModel>>(failure: final Failure failure):
        showErrorSnackbar(
          failure: failure,
          customMessage: 'Unable to load staminas ${failure.message}',
        );
    }
  }

  void deleteStamina(StaminaModel stamina) async {
    final Result<void> result = await _staminaService.deleteStamina(stamina.id);

    switch (result) {
      case Ok<void>():
        staminas.value = staminas.value
            .where((s) => s.id != stamina.id)
            .toList();
        showSuccessSnackbar('Deleted ${stamina.id} ${stamina.gachaTitle}');

        final Result<void> notificationResult = await LOCAL_NOTIFICATION_SERVICE
            .descheduleNotification(stamina.id);

        switch (notificationResult) {
          case Error<void>(failure: final Failure failure):
            showErrorSnackbar(
              failure: failure,
              customMessage:
                  'Could not deschedule notification ${stamina.id} ${failure.message}',
            );
          case Ok<void>():
        }

      case Error<void>(failure: final Failure failure):
        showErrorSnackbar(
          failure: failure,
          customMessage:
              'Unable to delete ${stamina.id} ${stamina.gachaTitle} ${failure.message}',
        );
    }
  }

  void setStamina(StaminaModel stamina, {int? amount}) async {
    final Result<StaminaModel> result = await _staminaService.setStamina(
      stamina.id,
      amount,
    );

    switch (result) {
      case Ok<StaminaModel>(value: final updatedStamina):
        final list = List<StaminaModel>.from(staminas.value);

        final index = list.indexWhere((s) => s.id == stamina.id);
        if (index == -1) return;

        list[index] = updatedStamina;
        staminas.value = list;
        showSuccessSnackbar(
          'Set ${stamina.gachaTitle} stamina to ${updatedStamina.staminaOfLastestReset}',
        );

        final Result<void> rescheduleResult = await LOCAL_NOTIFICATION_SERVICE
            .rescheduleGachaNotification(updatedStamina);

        switch (rescheduleResult) {
          case Error<void>(failure: final Failure failure):
            showErrorSnackbar(
              failure: failure,
              customMessage:
                  'Could not reschedule notification ${stamina.id} ${failure.message}',
            );
          case Ok<void>():
        }

      case Error<StaminaModel>(failure: final Failure failure):
        showErrorSnackbar(
          failure: failure,
          customMessage:
              'Unable to set stamina of ${stamina.gachaTitle} ${failure.message}',
        );
    }
  }
}
