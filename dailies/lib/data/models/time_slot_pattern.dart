import 'package:collection/collection.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/time_slot.dart';

class TimeSlotPattern extends AppModel {
  final DateTime? _endPatternDate;
  final HeapPriorityQueue<TimeSlot> _anchorPoints =
      HeapPriorityQueue<TimeSlot>();
  final List<DateTime> _exclusionDates = [];
  final String? _timeZoneId;
  final Duration? _frequency;
  final String? _recurranceRule;
  late int eventId;

  TimeSlotPattern({
    super.id,
    required this.eventId,
    DateTime? endPatternDate,
    String? anchorPointsString,
    String? timeZoneId,
    int? frequencyInSeconds,
    String? recurranceRule,
    String? exclusionDateString,
    List<DateTime>? exclusionDates,
  }) : _endPatternDate = endPatternDate,
       _timeZoneId = timeZoneId,
       _frequency =
           (frequencyInSeconds == null)
               ? null
               : Duration(seconds: frequencyInSeconds),
       _recurranceRule = recurranceRule {
    anchorPoints = anchorPointsString;
    _exclusionDates.addAll(exclusionDates ?? []);
    _exclusionDates.addAll(
      exclusionDateString?.split(';').map(DateTime.parse).toList() ?? [],
    );
  }

  TimeSlotPattern.UnSaved({
    super.id,
    DateTime? endPatternDate,
    String? anchorPointsString,
    String? timeZoneId,
    int? frequencyInSeconds,
    String? recurranceRule,
    List<TimeSlot>? anchorPointsList,
    List<DateTime>? exclusionDates,
  }) : _endPatternDate = endPatternDate,
       _timeZoneId = timeZoneId,
       _frequency =
           (frequencyInSeconds == null)
               ? null
               : Duration(seconds: frequencyInSeconds),
       _recurranceRule = recurranceRule {
    anchorPoints = anchorPointsString;
    addAnchorPoints(anchorPointsList ?? []);
    _exclusionDates.addAll(exclusionDates ?? []);
  }

  DateTime? get endPatternDate => _endPatternDate;
  String? get timeZoneId => _timeZoneId;
  Duration? get frequency => _frequency;
  String? get recurranceRule => _recurranceRule;

  bool get isAffectedByDaylightSavings => _timeZoneId != null;
  bool get isReacurring => _frequency != null;
  bool get isFinite => endPatternDate != null;
  bool get hasRecurranceRule => _recurranceRule != null;

  List<TimeSlot> get anchorPointsList => _anchorPoints.toList();

  String? get anchorPointsAsString {
    if (_anchorPoints.isEmpty) return null;
    final HeapPriorityQueue<TimeSlot> copy =
        HeapPriorityQueue()..addAll(_anchorPoints.toList());

    final List<String> stringTriples = [];

    while (copy.isNotEmpty) {
      final timeSlot = copy.removeFirst();
      stringTriples.add(
        '${timeSlot.startTime ?? ''};${timeSlot.endTime ?? ''};${timeSlot.dateOfTimeSlot}',
      );
    }
    return stringTriples.join(',');
  }

  String? get exclusionDatesAsString =>
      (_exclusionDates.isNotEmpty) ? _exclusionDates.join(';') : null;

  set anchorPoints(String? encodedString) {
    if (encodedString == null) return;

    final List<String> triples = encodedString.split(',');

    for (final String triple in triples) {
      final List<String> separated = triple.split(';');
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
