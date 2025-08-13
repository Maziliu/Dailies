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
    if (_startTime == null && _endTime == null) return TimeSlotType.Unspecified;

    if (_startTime == null) return TimeSlotType.Deadline;

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
    //uses the enum order first
    final enumIndexComparison = timeSlotType.index.compareTo(other.timeSlotType.index);
    if (enumIndexComparison != 0) return enumIndexComparison;

    final thisDate = DateTime(_dateOfTimeSlot.year, _dateOfTimeSlot.month, _dateOfTimeSlot.day);
    final otherDate = DateTime(other._dateOfTimeSlot.year, other._dateOfTimeSlot.month, other._dateOfTimeSlot.day);

    //same type so compare by date if not same day
    final dateComparison = thisDate.compareTo(otherDate);
    if (dateComparison != 0) return dateComparison;

    //same day so compare by start time
    //Note: 0 --> Same, -1 --> isBefore, 1 --> isAfter
    if (_startTime == null && other._startTime == null) return 0;
    if (_startTime == null) return 1;
    if (other._startTime == null) return -1;

    return _startTime.compareTo(other._startTime);
  }
}
