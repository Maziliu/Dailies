import 'package:drift/drift.dart';

class Staminas extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();
  TextColumn get imageName => text().nullable()();

  IntColumn get rechargeTime => integer()();
  IntColumn get maxStamina => integer()();
  IntColumn get staminaOfLastReset => integer()();

  DateTimeColumn get timeOfLastReset => dateTime()();
}
