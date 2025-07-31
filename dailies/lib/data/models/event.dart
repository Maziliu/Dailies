import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/time_slot.dart';

class Event extends AppModel implements Comparable<Event> {
  final String _eventName;
  final String? _location;
  final List<TimeSlot> _timeSlots;

  Event({
    required super.id,
    required String eventName,
    required String? location,
    required List<TimeSlot> timeSlots,
  }) : _eventName = eventName,
       _location = location,
       _timeSlots = timeSlots;

  String get eventName => _eventName;
  String? get location => _location;
  List<TimeSlot> get timeSlots => _timeSlots;
  int get timeSlotHeadId => _timeSlots[0].id;
  bool get isRecurring => _timeSlots.length > 1;

  @override
  int compareTo(Event other) {
    return _timeSlots.first.compareTo(other._timeSlots.first);
  }
}
