import 'package:dailies/data/database/drift/tables/drift_events.dart';
import 'package:dailies/data/database/drift/tables/drift_staminas.dart';
import 'package:dailies/data/database/drift/tables/drift_time_slot_patterns.dart';
import 'package:dailies/data/database/drift/tables/drift_time_slots.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
part 'drift_database.g.dart';

@DriftDatabase(
  tables: [DriftEvents, DriftTimeSlots, DriftStaminas, DriftTimeSlotPatterns],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator migrator) async {
      await migrator.createAll();
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'drift_database',
      native: DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
        setup: (rawDb) {
          rawDb.execute('PRAGMA foreign_keys = ON;');
          rawDb.execute('PRAGMA journal_mode = WAL;');
        },
      ),
    );
  }
}
