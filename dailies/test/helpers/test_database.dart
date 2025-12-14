import 'package:dailies_v2/database/database.dart';
import 'package:drift/native.dart';

Database createTestDatabase() {
  return Database.forTesting(NativeDatabase.memory());
}
