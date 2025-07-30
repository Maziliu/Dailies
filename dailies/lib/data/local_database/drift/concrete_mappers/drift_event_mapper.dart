import 'package:dailies/data/local_database/drift/drift_database.dart';
import 'package:dailies/data/local_database/interfaces/mappers/event_mapper.dart';
import 'package:dailies/data/models/event.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:drift/drift.dart';

class DriftEventMapper implements EventMapper<DriftEventsCompanion> {
  @override
  DriftEventsCompanion toDataModel(Event domainModel) {
    return DriftEventsCompanion(
      id: Value(domainModel.id),
      location: Value(domainModel.location),
      eventName: Value(domainModel.eventName),
      timeSlotId: Value(domainModel.timeSlotHeadId),
    );
  }

  @override
  Event toDomainModel(
    DriftEventsCompanion dataModel,
    List<TimeSlot> timeSlots,
  ) {
    return Event(
      id: dataModel.id.value,
      eventName: dataModel.eventName.value,
      location: dataModel.location.value,
      timeSlots: timeSlots,
    );
  }
}
