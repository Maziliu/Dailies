import 'package:dailies/common/utils/typedefs.dart';
import 'package:dailies/data/models/app_model.dart';
import 'package:dailies/data/models/time_slot.dart';

class TimeSlotPattern extends AppModel {
  final DateTime? _endPatternDate;
  final List<TimeSlot> _anchorPoints = [];
  final String? _timeZoneId;
  final Duration? _frequency;
  int? eventId;

  TimeSlotPattern({super.id, this.eventId, DateTime? endPatternDate, String? anchorPointsString, String? timeZoneId, int? frequencyInSeconds})
    : _endPatternDate = endPatternDate,
      _timeZoneId = timeZoneId,
      _frequency = (frequencyInSeconds == null) ? null : Duration(seconds: frequencyInSeconds) {
    anchorPoints = anchorPointsString;
  }

  DateTime? get endPatternDate => _endPatternDate;
  String? get timeZoneId => _timeZoneId;
  Duration? get frequency => _frequency;

  bool get isAffectedByDaylightSavings => _timeZoneId != null;
  bool get isReacurring => _frequency != null && endPatternDate != null;
  bool get isFinite => endPatternDate != null;

  List<TimeSlot> get anchorPointsList => _anchorPoints;

  String? get anchorPointsAsString {
    if (_anchorPoints.isEmpty) return null;

    final List<String> stringTriples = [];

    for (final TimeSlot timeSlot in _anchorPoints) {
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
        TimeSlot(dateOfTimeSlot: DateTime.parse(separated[2]), startTime: DateTime.tryParse(separated[0]), endTime: DateTime.tryParse(separated[1])),
      );
    }

    _anchorPoints.sort();
  }
}
