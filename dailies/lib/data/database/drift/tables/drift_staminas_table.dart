import 'package:drift/drift.dart';

class DriftStaminas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get gachaName => text()();
  IntColumn get maxStamina => integer()();
  IntColumn get rechargeTimeInSeconds => integer()();
  IntColumn get staminaOfLatestReset => integer()();
  DateTimeColumn get timeOfLastReset => dateTime()();
  TextColumn get imageName => text().nullable()();
}
