import 'package:dailies/data/database/drift/tables/drift_events.dart';
import 'package:drift/drift.dart';

class DriftTimeSlotPatterns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get eventId => integer().references(DriftEvents, #id, onDelete: KeyAction.cascade)();
  TextColumn get anchorPoints => text().nullable()();
  TextColumn get exclusionDates => text().nullable()();
  IntColumn get frequencyInSeconds => integer().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get timeZoneId => text().nullable()();
  TextColumn get rrule => text().nullable()();
}
