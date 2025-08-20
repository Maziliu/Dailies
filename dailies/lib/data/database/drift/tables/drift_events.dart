import 'package:dailies/data/database/drift/tables/drift_time_slot_patterns.dart';
import 'package:dailies/data/database/drift/tables/drift_time_slots.dart';
import 'package:drift/drift.dart';

class DriftEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get eventName => text()();
  TextColumn get location => text().nullable()();
}
