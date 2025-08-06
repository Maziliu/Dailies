import 'package:dailies/data/database/drift/drift_database.dart';
import 'package:dailies/data/mapper/event_mapper.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/event.dart';
import 'package:drift/drift.dart';

class DriftEventMapper extends EventMapper<DriftEvent, DriftEventsCompanion> {
  @override
  DriftEventsCompanion convertAppModelToOutgoingDatabaseModel(AppModel appModel) {
    Event event = appModel as Event;

    return DriftEventsCompanion(
      id: (event.isNotSaved) ? const Value.absent() : Value(event.id),
      eventName: Value(event.eventName),
      location: Value(event.location),
      timeSlotId: Value(event.timeSlotHeadId),
    );
  }

  @override
  AppModel convertIncomingDatabaseModelToAppModel(DriftEvent incomingDatabaseModel) {
    return Event(
      id: incomingDatabaseModel.id,
      eventName: incomingDatabaseModel.eventName,
      location: incomingDatabaseModel.location,
      timeSlotHeadId: incomingDatabaseModel.timeSlotId,
    );
  }
}
