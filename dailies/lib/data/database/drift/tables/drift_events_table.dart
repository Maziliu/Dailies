import 'package:dailies/data/database/drift/tables/drift_time_slots_table.dart';
import 'package:drift/drift.dart';

class DriftEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get eventName => text()();
  TextColumn get location => text().nullable()();
  IntColumn get timeSlotId =>
      integer().references(DriftTimeSlots, #id, onDelete: KeyAction.cascade)();
}
