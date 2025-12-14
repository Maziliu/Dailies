import 'package:dailies_v2/database/database.dart';
import 'package:dailies_v2/database/tables/events.dart';
import 'package:drift/drift.dart';

part 'event_dao.g.dart';

@DriftAccessor(tables: [Events])
class EventDao extends DatabaseAccessor<Database> with _$EventDaoMixin {
  EventDao(super.db);

  Future<List<Event>> getAll() => select(events).get();

  Future<void> deleteEvent(int id) =>
      (delete(events)..where((e) => e.id.equals(id))).go();

  Future<int> insert(EventsCompanion data) => into(events).insert(data);
}

final EventDao EVENT_DAO = EventDao(APP_DATABASE);
