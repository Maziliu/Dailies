import 'package:dailies/data/database/drift/drift_database.dart';
import 'package:dailies/data/mapper/event_mapper.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/event.dart';
import 'package:drift/drift.dart';

class DriftEventMapper extends EventMapper<DriftEventsCompanion, DriftEvent> {
  @override
  DriftEventsCompanion convertAppModelToInputModel(AppModel appModel) {
    Event event = appModel as Event;

    return DriftEventsCompanion(
      id: Value(event.id),
      eventName: Value(event.eventName),
      location: Value(event.location),
      timeSlotId: Value(event.timeSlotHeadId),
    );
  }

  @override
  AppModel convertOutputToAppModel(DriftEvent outputModel) {
    return Event(id: outputModel.id, eventName: outputModel.eventName, location: outputModel.location, timeSlots: [], timeSlotHeadId: outputModel.timeSlotId);
  }
}
