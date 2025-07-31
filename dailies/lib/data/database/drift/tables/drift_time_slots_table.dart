import 'package:drift/drift.dart';

class DriftTimeSlots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get nextTimeSlotId =>
      integer().nullable().references(
        DriftTimeSlots,
        #id,
        onDelete: KeyAction.cascade,
      )();

  DateTimeColumn get date => dateTime()();
  DateTimeColumn get startTime => dateTime().nullable()();
  DateTimeColumn get endTime => dateTime().nullable()();
}
