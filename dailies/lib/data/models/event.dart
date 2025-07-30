import 'package:dailies/data/models/time_slot.dart';

class Event {
  final int _id;
  final String _eventName;
  final String? _location;
  final List<TimeSlot> _timeSlots;

  Event({
    required int id,
    required String eventName,
    required String? location,
    required List<TimeSlot> timeSlots,
  }) : _id = id,
       _eventName = eventName,
       _location = location,
       _timeSlots = timeSlots;

  int get id => _id;
  String get eventName => _eventName;
  String? get location => _location;
  List<TimeSlot> get timeSlots => _timeSlots;
  int get timeSlotHeadId => _timeSlots[0].id;
  bool get isReaccurring => _timeSlots.length > 1;
}
