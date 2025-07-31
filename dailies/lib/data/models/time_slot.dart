import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/data/models/app_model.dart';

class TimeSlot extends AppModel implements Comparable<TimeSlot> {
  final int? _nextTimeSlotId;
  final DateTime _dateOfTimeSlot;
  final DateTime? _startTime;
  final DateTime? _endTime;

  TimeSlot({
    required super.id,
    required int? nextTimeSlotId,
    required DateTime dateOfTimeSlot,
    required DateTime? startTime,
    required DateTime? endTime,
  }) : _nextTimeSlotId = nextTimeSlotId,
       _dateOfTimeSlot = dateOfTimeSlot,
       _startTime = startTime,
       _endTime = endTime;

  int get nextTimeSlotId => _nextTimeSlotId!;
  DateTime get dateOfTimeSlot => _dateOfTimeSlot;
  DateTime get startTime => _startTime!;
  DateTime get endTime => _endTime!;

  TimeSlotType get timeSlotType {
    if (_startTime == null) {
      if (_endTime == null) {
        return TimeSlotType.AllDay;
      }

      return TimeSlotType.Deadline;
    }

    return TimeSlotType.Interval;
  }

  bool get isReaccuring => _nextTimeSlotId == null;

  @override
  int compareTo(TimeSlot other) {
    if (_dateOfTimeSlot.compareTo(other._dateOfTimeSlot) != 0) {
      return _dateOfTimeSlot.compareTo(other._dateOfTimeSlot);
    }

    //Specific times matter if both they are on the same day
    if (_endTime == null && other._endTime == null) {
      return 0;
    } else if (_endTime == null) {
      return 1;
    } else if (other._endTime == null) {
      return -1;
    } else {
      return _endTime.compareTo(other._endTime);
    }
  }
}
