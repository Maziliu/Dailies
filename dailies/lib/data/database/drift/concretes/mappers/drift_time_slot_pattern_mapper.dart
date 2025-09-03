import 'package:dailies/data/database/drift/drift_database.dart';
import 'package:dailies/data/mapper/time_slot_pattern_mapper.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/time_slot_pattern.dart';
import 'package:drift/drift.dart';

class DriftTimeSlotPatternMapper implements TimeSlotPatternMapper<DriftTimeSlotPattern, DriftTimeSlotPatternsCompanion> {
  @override
  DriftTimeSlotPatternsCompanion convertAppModelToOutgoingDatabaseModel(AppModel appModel) {
    final TimeSlotPattern timeSlotPattern = appModel as TimeSlotPattern;

    return DriftTimeSlotPatternsCompanion(
      id: (timeSlotPattern.isNotSaved) ? const Value.absent() : Value(timeSlotPattern.id),
      eventId: Value.absentIfNull(timeSlotPattern.eventId),
      anchorPoints: Value.absentIfNull(timeSlotPattern.anchorPointsAsString),
      frequencyInSeconds: Value.absentIfNull(timeSlotPattern.frequency?.inSeconds),
      endDate: Value.absentIfNull(timeSlotPattern.endPatternDate),
      timeZoneId: Value.absentIfNull(timeSlotPattern.timeZoneId),
      rrule: Value.absentIfNull(timeSlotPattern.recurranceRule),
      exclusionDates: Value.absentIfNull(timeSlotPattern.exclusionDatesAsString),
    );
  }

  @override
  TimeSlotPattern convertIncomingDatabaseModelToAppModel(DriftTimeSlotPattern incomingDatabaseModel) => TimeSlotPattern(
    id: incomingDatabaseModel.id,
    eventId: incomingDatabaseModel.eventId,
    anchorPointsString: incomingDatabaseModel.anchorPoints,
    frequencyInSeconds: incomingDatabaseModel.frequencyInSeconds,
    endPatternDate: incomingDatabaseModel.endDate,
    timeZoneId: incomingDatabaseModel.timeZoneId,
    recurranceRule: incomingDatabaseModel.rrule,
    exclusionDateString: incomingDatabaseModel.exclusionDates,
  );
}
