import 'package:dailies/data/database/drift/drift_database.dart';
import 'package:dailies/data/mapper/time_slot_mapper.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:drift/drift.dart';

class DriftTimeSlotMapper
    extends TimeSlotMapper<DriftTimeSlot, DriftTimeSlotsCompanion> {
  @override
  DriftTimeSlotsCompanion convertAppModelToOutgoingDatabaseModel(
    AppModel appModel,
  ) {
    final TimeSlot timeSlot = appModel as TimeSlot;

    return DriftTimeSlotsCompanion(
      id: (timeSlot.isNotSaved) ? const Value.absent() : Value(timeSlot.id),
      patternId: Value.absentIfNull(timeSlot.patternId),
      date: Value(timeSlot.dateOfTimeSlot),
      startTime: Value(timeSlot.startTime),
      endTime: Value(timeSlot.endTime),
      eventId: Value.absentIfNull(timeSlot.eventId),
    );
  }

  @override
  TimeSlot convertIncomingDatabaseModelToAppModel(
    DriftTimeSlot incomingDatabaseModel,
  ) => TimeSlot(
    id: incomingDatabaseModel.id,
    eventId: incomingDatabaseModel.eventId,
    patternId: incomingDatabaseModel.patternId,
    dateOfTimeSlot: incomingDatabaseModel.date,
    startTime: incomingDatabaseModel.startTime,
    endTime: incomingDatabaseModel.endTime,
  );
}
