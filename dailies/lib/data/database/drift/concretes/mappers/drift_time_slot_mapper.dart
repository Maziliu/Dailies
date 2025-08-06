import 'package:dailies/data/database/drift/drift_database.dart';
import 'package:dailies/data/mapper/time_slot_mapper.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:drift/drift.dart';

class DriftTimeSlotMapper extends TimeSlotMapper<DriftTimeSlot, DriftTimeSlotsCompanion> {
  @override
  DriftTimeSlotsCompanion convertAppModelToOutgoingDatabaseModel(AppModel appModel) {
    TimeSlot timeSlot = appModel as TimeSlot;

    return DriftTimeSlotsCompanion(
      id: (timeSlot.isNotSaved) ? const Value.absent() : Value(timeSlot.id),
      nextTimeSlotId: (timeSlot.hasNextNode) ? Value(timeSlot.nextTimeSlotId) : const Value.absent(),
      date: Value(timeSlot.dateOfTimeSlot),
      startTime: Value(timeSlot.startTime),
      endTime: Value(timeSlot.endTime),
    );
  }

  @override
  AppModel convertIncomingDatabaseModelToAppModel(DriftTimeSlot incomingDatabaseModel) {
    return TimeSlot(
      id: incomingDatabaseModel.id,
      nextTimeSlotId: incomingDatabaseModel.nextTimeSlotId,
      dateOfTimeSlot: incomingDatabaseModel.date,
      startTime: incomingDatabaseModel.startTime,
      endTime: incomingDatabaseModel.endTime,
    );
  }
}
