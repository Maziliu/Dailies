import 'dart:io';

import 'package:dailies_v2/database/tables/calendars.dart';
import 'package:dailies_v2/database/tables/events.dart';
import 'package:dailies_v2/database/tables/staminas.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Events, Calendars, Staminas])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File('${dir.path}/drift_database.sqlite');

    return NativeDatabase(
      file,
      setup: (rawDb) {
        rawDb.execute('PRAGMA foreign_keys = ON;');
        rawDb.execute('PRAGMA journal_mode = WAL;');
      },
    );
  });
}

final Database APP_DATABASE = Database();
