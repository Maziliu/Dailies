import 'package:dailies/common/enums/time_slot_type.dart';
import 'package:dailies/data/models/app_model.dart';

class TimeSlot extends AppModel implements Comparable<TimeSlot> {
  int? nextTimeSlotId;
  final DateTime _dateOfTimeSlot;
  final DateTime? _startTime;
  final DateTime? _endTime;

  TimeSlot({super.id, this.nextTimeSlotId, startTime, DateTime? endTime, required DateTime dateOfTimeSlot})
    : _dateOfTimeSlot = dateOfTimeSlot,
      _startTime = startTime,
      _endTime = endTime;

  factory TimeSlot.fromDateTime({required DateTime dateTime}) => TimeSlot(dateOfTimeSlot: DateTime(dateTime.year, dateTime.month, dateTime.day));

  DateTime? get startTime => _startTime;
  DateTime? get endTime => _endTime;
  DateTime get dateOfTimeSlot => DateTime(_dateOfTimeSlot.year, _dateOfTimeSlot.month, _dateOfTimeSlot.day);

  TimeSlotType get timeSlotType {
    if (_startTime == null) {
      if (_endTime == null) {
        return TimeSlotType.Unspecified;
      }

      return TimeSlotType.Deadline;
    }

    return TimeSlotType.Interval;
  }

  bool get hasNextNode => nextTimeSlotId != null;

  bool isSameDay(DateTime other) {
    final thisDate = DateTime(_dateOfTimeSlot.year, _dateOfTimeSlot.month, _dateOfTimeSlot.day);
    final otherDate = DateTime(other.year, other.month, other.day);

    return thisDate.compareTo(otherDate) == 0;
  }

  @override
  int compareTo(TimeSlot other) {
    final thisDate = DateTime(_dateOfTimeSlot.year, _dateOfTimeSlot.month, _dateOfTimeSlot.day);
    final otherDate = DateTime(other._dateOfTimeSlot.year, other._dateOfTimeSlot.month, other._dateOfTimeSlot.day);

    if (!isSameDay(otherDate)) return thisDate.compareTo(otherDate);

    //The abouve filters diff days and the same days must be diffed by endtime
    //Note: 0 --> Same, -1 --> isBefore, 1 --> isAfter
    if (_endTime == null && other._endTime == null) return 0;
    if (_endTime == null) return 1;
    if (other._endTime == null) return -1;

    return _endTime.compareTo(other._endTime);
  }
}
