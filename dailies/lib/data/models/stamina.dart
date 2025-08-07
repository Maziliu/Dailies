import 'package:dailies/data/models/app_model.dart';

class Stamina extends AppModel {
  final Duration _rechargeTime;
  final int _maxStamina;
  final String _gachaTitle;
  final String? _imageName;
  DateTime timeOfLastReset;
  int staminaOfLastestReset;

  Stamina({
    super.id,
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
