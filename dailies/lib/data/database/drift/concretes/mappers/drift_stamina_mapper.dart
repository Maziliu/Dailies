import 'package:dailies/data/database/drift/drift_database.dart';
import 'package:dailies/data/mapper/stamina_mapper.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/stamina.dart';
import 'package:drift/drift.dart';

class DriftStaminaMapper implements StaminaMapper<DriftStamina, DriftStaminasCompanion> {
  @override
  DriftStaminasCompanion convertAppModelToOutgoingDatabaseModel(AppModel appModel) {
    Stamina stamina = appModel as Stamina;

    return DriftStaminasCompanion(
      id: stamina.isNotSaved ? const Value.absent() : Value(stamina.id),
      gachaName: Value(stamina.gachaTitle),
      maxStamina: Value(stamina.maxStamina),
      rechargeTimeInSeconds: Value(stamina.rechargeTime.inSeconds),
      staminaOfLatestReset: Value(stamina.staminaOfLastestReset),
      timeOfLastReset: Value(stamina.timeOfLastReset),
      imageName: (stamina.imageName == null) ? const Value.absent() : Value(stamina.imageName),
    );
  }

  @override
  Stamina convertIncomingDatabaseModelToAppModel(DriftStamina incomingDatabaseModel) => Stamina(
    id: incomingDatabaseModel.id,
    rechargeTime: Duration(seconds: incomingDatabaseModel.rechargeTimeInSeconds),
    maxStamina: incomingDatabaseModel.maxStamina,
    gachaTitle: incomingDatabaseModel.gachaName,
    imageName: incomingDatabaseModel.imageName,
    timeOfLastReset: incomingDatabaseModel.timeOfLastReset,
    staminaOfLastestReset: incomingDatabaseModel.staminaOfLatestReset,
  );
}
