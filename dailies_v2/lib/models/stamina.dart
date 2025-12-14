import 'package:dailies_v2/database/database.dart';
import 'package:drift/drift.dart';

class StaminaModel {
  int? id;
  final Duration _rechargeTime;
  final int _maxStamina;
  final String _gachaTitle;
  final String? _imageName;
  DateTime timeOfLastReset;
  int staminaOfLastestReset;

  StaminaModel({
    this.id,
    required Duration rechargeTime,
    required int maxStamina,
    required String gachaTitle,
    required String? imageName,
    required this.timeOfLastReset,
    required this.staminaOfLastestReset,
  }) : _rechargeTime = rechargeTime,
       _maxStamina = maxStamina,
       _gachaTitle = gachaTitle,
       _imageName = imageName;

  int get maxStamina => _maxStamina;
  Duration get rechargeTime => _rechargeTime;
  String get gachaTitle => _gachaTitle;
  String? get imageName => _imageName;
}

extension StaminaRowMapper on Stamina {
  StaminaModel toModel() {
    return StaminaModel(
      id: id,
      gachaTitle: title,
      rechargeTime: Duration(seconds: rechargeTime),
      maxStamina: maxStamina,
      staminaOfLastestReset: staminaOfLastReset,
      timeOfLastReset: timeOfLastReset,
      imageName: imageName,
    );
  }
}

extension StaminaModelToCompanion on StaminaModel {
  StaminasCompanion toCompanion() {
    return StaminasCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      title: Value(gachaTitle),
      rechargeTime: Value(rechargeTime.inSeconds),
      maxStamina: Value(maxStamina),
      staminaOfLastReset: Value(staminaOfLastestReset),
      timeOfLastReset: Value(timeOfLastReset.toUtc()),
      imageName: Value(imageName),
    );
  }
}
