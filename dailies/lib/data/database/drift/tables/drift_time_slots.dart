import 'package:dailies/data/database/drift/tables/drift_events.dart';
import 'package:dailies/data/database/drift/tables/drift_time_slot_patterns.dart';
import 'package:drift/drift.dart';

class DriftTimeSlots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patternId =>
      integer().references(
        DriftTimeSlotPatterns,
        #id,
        onDelete: KeyAction.cascade,
      )();
  IntColumn get eventId =>
      integer().references(DriftEvents, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get startTime => dateTime().nullable()();
  DateTimeColumn get endTime => dateTime().nullable()();
}
