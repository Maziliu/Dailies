import 'package:dailies/data/local_database/drift/drift_database.dart';
import 'package:dailies/data/local_database/interfaces/mappers/time_slot_mapper.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:drift/drift.dart';

class DriftTimeSlotMapper implements TimeSlotMapper<DriftTimeSlotsCompanion> {
  @override
  DriftTimeSlotsCompanion toDataModel(TimeSlot domainModel) {
    return DriftTimeSlotsCompanion(
      id: Value(domainModel.id),
      nextTimeSlotId: Value(domainModel.nextTimeSlot),
      date: Value(domainModel.dateOfTimeSlot),
      startTime: Value(domainModel.startTime),
      endTime: Value(domainModel.endTime),
    );
  }

  @override
  TimeSlot toDomainModel(DriftTimeSlotsCompanion dataModel) {
    return TimeSlot(
      id: dataModel.id.value,
      nextTimeSlotId: dataModel.nextTimeSlotId.value,
      dateOfTimeSlot: dataModel.date.value,
      startTime: dataModel.startTime.value,
      endTime: dataModel.endTime.value,
    );
  }
}
