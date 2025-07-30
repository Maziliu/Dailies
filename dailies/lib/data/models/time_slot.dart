import 'package:dailies/common/enums/time_slot_type.dart';

class TimeSlot {
  final int _id;
  final int? _nextTimeSlot;
  final DateTime _dateOfTimeSlot;
  final DateTime? _startTime;
  final DateTime? _endTime;

  TimeSlot({
    required int id,
    required int? nextTimeSlotId,
    required DateTime dateOfTimeSlot,
    required DateTime? startTime,
    required DateTime? endTime,
  }) : _id = id,
       _nextTimeSlot = nextTimeSlotId,
       _dateOfTimeSlot = dateOfTimeSlot,
       _startTime = startTime,
       _endTime = endTime;

  int get id => _id;
  int get nextTimeSlot => _nextTimeSlot!;
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

  bool get isReaccuring => _nextTimeSlot == null;
}
