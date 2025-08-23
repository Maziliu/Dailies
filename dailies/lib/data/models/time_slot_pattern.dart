import 'package:collection/collection.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/time_slot.dart';

class TimeSlotPattern extends AppModel {
  final DateTime? _endPatternDate;
  final HeapPriorityQueue<TimeSlot> _anchorPoints = HeapPriorityQueue<TimeSlot>();
  final String? _timeZoneId;
  final Duration? _frequency;
  late final int eventId;

  TimeSlotPattern({super.id, required this.eventId, DateTime? endPatternDate, String? anchorPointsString, String? timeZoneId, int? frequencyInSeconds})
    : _endPatternDate = endPatternDate,
      _timeZoneId = timeZoneId,
      _frequency = (frequencyInSeconds == null) ? null : Duration(seconds: frequencyInSeconds) {
    anchorPoints = anchorPointsString;
  }

  TimeSlotPattern.UnSaved({
    super.id,
    DateTime? endPatternDate,
    String? anchorPointsString,
    String? timeZoneId,
    int? frequencyInSeconds,
    List<TimeSlot>? anchorPointsList,
  }) : _endPatternDate = endPatternDate,
       _timeZoneId = timeZoneId,
       _frequency = (frequencyInSeconds == null) ? null : Duration(seconds: frequencyInSeconds) {
    anchorPoints = anchorPointsString;
    addAnchorPoints(anchorPointsList ?? []);
  }

  DateTime? get endPatternDate => _endPatternDate;
  String? get timeZoneId => _timeZoneId;
  Duration? get frequency => _frequency;

  bool get isAffectedByDaylightSavings => _timeZoneId != null;
  bool get isReacurring => _frequency != null && endPatternDate != null;
  bool get isFinite => endPatternDate != null;

  List<TimeSlot> get anchorPointsList => _anchorPoints.toList();

  String? get anchorPointsAsString {
    if (_anchorPoints.isEmpty) return null;
    final HeapPriorityQueue<TimeSlot> copy = HeapPriorityQueue()..addAll(_anchorPoints.toList());

    final List<String> stringTriples = [];

    while (copy.isNotEmpty) {
      final timeSlot = copy.removeFirst();
      stringTriples.add('${timeSlot.startTime ?? ''};${timeSlot.endTime ?? ''};${timeSlot.dateOfTimeSlot}');
    }
    return stringTriples.join(',');
  }

  set anchorPoints(String? encodedString) {
    if (encodedString == null) return;

    List<String> triples = encodedString.split(',');

    for (final String triple in triples) {
      List<String> separated = triple.split(';');
      _anchorPoints.add(
        TimeSlot(
          patternId: id,
          eventId: eventId,
          dateOfTimeSlot: DateTime.parse(separated[2]),
          startTime: DateTime.tryParse(separated[0]),
          endTime: DateTime.tryParse(separated[1]),
        ),
      );
    }
  }

  void addAnchorPoint(TimeSlot anchorPoint) {
    _anchorPoints.add(anchorPoint);
  }

  void addAnchorPoints(List<TimeSlot> anchorPoints) {
    _anchorPoints.addAll(anchorPoints);
  }
}
