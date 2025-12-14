import 'package:dailies_v2/enums/event_type.dart';
import 'package:drift/drift.dart';

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uid => text()();
  TextColumn get calendarId => text()();

  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get location => text().nullable()();

  IntColumn get dtStart => integer()(); // milliseconds since epoch
  IntColumn get dtEnd => integer().nullable()(); // milliseconds
  IntColumn get duration => integer().nullable()(); // seconds

  TextColumn get timezone => text().nullable()();
  TextColumn get rrule => text().nullable()();

  TextColumn get status => text().withDefault(const Constant('CONFIRMED'))();

  TextColumn get eventType => text().map(const EventTypeConverter())();

  IntColumn get createdAt => integer()(); // milliseconds
  IntColumn get lastModified => integer()(); // milliseconds
}

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
