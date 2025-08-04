import 'package:dailies/data/database/drift/drift_database.dart';
import 'package:dailies/data/mapper/time_slot_mapper.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:drift/drift.dart';

class DriftTimeSlotMapper extends TimeSlotMapper<DriftTimeSlotsCompanion, DriftTimeSlot> {
  @override
  DriftTimeSlotsCompanion convertAppModelToInputModel(AppModel appModel) {
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
  AppModel convertOutputToAppModel(DriftTimeSlot outputModel) {
    return TimeSlot(
      id: outputModel.id,
      nextTimeSlotId: outputModel.nextTimeSlotId,
      dateOfTimeSlot: outputModel.date,
      startTime: outputModel.startTime,
      endTime: outputModel.endTime,
    );
  }
}
