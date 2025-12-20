import 'package:dailies_v2/enums/event_type.dart';
import 'package:drift/drift.dart';

class EventTypeConverter extends TypeConverter<EventType, String> {
  const EventTypeConverter();

  @override
  EventType fromSql(String fromDb) {
    return EventType.values.firstWhere((e) => e.name == fromDb);
  }

  @override
  String toSql(EventType value) {
    return value.name;
  }
}

class EventInfos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get calendarId => text()();

  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get location => text().nullable()();

  TextColumn get type => text().map(const EventTypeConverter())();

  IntColumn get date => integer()();

  IntColumn get dtStart => integer().nullable()();

  IntColumn get dtEnd => integer().nullable()();

  TextColumn get timezone => text().nullable()();

  TextColumn get rrule => text().nullable()();

  IntColumn get until => integer().nullable()();

  IntColumn get createdAt => integer()();
  IntColumn get lastModified => integer()();
}

class EventCacheInstances extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get eventInfoId =>
      integer().references(EventInfos, #id, onDelete: KeyAction.cascade)();

  IntColumn get date => integer()();
  IntColumn get instanceStart => integer().nullable()();
  IntColumn get instanceEnd => integer().nullable()();
}
