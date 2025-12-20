import 'package:dailies_v2/database/database.dart';
import 'package:drift/native.dart';

Database createTestDatabase() {
  final executor = NativeDatabase.memory(
    setup: (rawDb) async {
      rawDb.execute('PRAGMA foreign_keys = ON;');
    },
  );

  return Database.forTesting(executor);
}
