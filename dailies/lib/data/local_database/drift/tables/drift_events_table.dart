import 'package:dailies/data/local_database/drift/tables/drift_time_slots_table.dart';
import 'package:drift/drift.dart';

class DriftEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get eventName => text()();
  TextColumn get location => text().nullable()();
  BoolColumn get isReaccuring => boolean().withDefault(const Constant(false))();
  IntColumn get timeSlotId =>
      integer().references(DriftTimeSlots, #id, onDelete: KeyAction.cascade)();
}
