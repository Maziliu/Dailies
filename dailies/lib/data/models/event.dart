import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/time_slot.dart';

class Event extends AppModel implements Comparable<Event> {
  final String _eventName;
  final String? _location;
  final int? _timeSlotHeadId;
  final List<TimeSlot> _timeSlots = [];

  Event({super.id, int? timeSlotHeadId, required String eventName, required String? location, TimeSlot? timeSlot})
    : _eventName = eventName,
      _location = location,
      _timeSlotHeadId = timeSlotHeadId {
    if (timeSlot != null) _timeSlots.add(timeSlot);
  }

  String get eventName => _eventName;
  String? get location => _location;
  List<TimeSlot> get timeSlots => _timeSlots;
  int get timeSlotHeadId => _timeSlotHeadId ?? -1;
  bool get isRecurring => _timeSlots.length > 1;

  void appendTimeSlot(TimeSlot timeSlot) {
    _timeSlots.add(timeSlot);
  }

  @override
  int compareTo(Event other) {
    return _timeSlots.first.compareTo(other._timeSlots.first);
  }
}
