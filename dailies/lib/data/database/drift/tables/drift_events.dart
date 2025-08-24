import 'package:drift/drift.dart';

class DriftEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get eventName => text()();
  TextColumn get location => text().nullable()();
}
