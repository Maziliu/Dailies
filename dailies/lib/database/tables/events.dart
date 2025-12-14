import 'package:drift/drift.dart';

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uid => text().unique()();
  TextColumn get calendarId => text()();

  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get location => text().nullable()();

  IntColumn get dtStart => integer()();
  IntColumn get dtEnd => integer().nullable()();
  IntColumn get duration => integer().nullable()();

  TextColumn get timezone => text().nullable()();
  TextColumn get rrule => text().nullable()();

  TextColumn get status => text().withDefault(const Constant('CONFIRMED'))();

  IntColumn get createdAt => integer()();
  IntColumn get lastModified => integer()();
}
