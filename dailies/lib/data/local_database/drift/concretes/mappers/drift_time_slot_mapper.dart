import 'package:dailies/data/local_database/drift/drift_database.dart';
import 'package:dailies/data/local_database/interfaces/mapper/model_mapper.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:drift/drift.dart';

class DriftTimeSlotMapper
    extends ModelMapper<DriftTimeSlotsCompanion, DriftTimeSlot> {
  @override
  DriftTimeSlotsCompanion convertAppModelToInputModel(AppModel appModel) {
    TimeSlot timeSlot = appModel as TimeSlot;

    return DriftTimeSlotsCompanion(
      id: Value(timeSlot.id),
      nextTimeSlotId: Value(timeSlot.nextTimeSlotId),
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
