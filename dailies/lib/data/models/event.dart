import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/time_slot.dart';
import 'package:dailies/data/models/time_slot_pattern.dart';

class Event extends AppModel {
  final String _eventName;
  final String? _location;
  late final TimeSlotPattern pattern;
  List<TimeSlot> timeSlots = []; //For the ui

  Event({super.id, required String eventName, required String? location}) : _eventName = eventName, _location = location;

  String get eventName => _eventName;
  String? get location => _location;

  bool get isReaccuring => timeSlots.length > 1;

  @override
  String toString() {
    return 'Event{id: $id, eventName: "$_eventName", location: ${_location != null ? '"$_location"' : 'null'}, isRecurring: $isReaccuring, timeSlots: ${timeSlots.toString()}, pattern: ${pattern.toString() ?? 'uninitialized'}}';
  }
}
