import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
part 'drift_database.g.dart';

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

class DriftEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get eventName => text()();
  TextColumn get location => text().nullable()();
  BoolColumn get isReaccuring => boolean().withDefault(const Constant(false))();
  IntColumn get timeSlotId =>
      integer().references(DriftTimeSlots, #id, onDelete: KeyAction.cascade)();
}

class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'drift_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
