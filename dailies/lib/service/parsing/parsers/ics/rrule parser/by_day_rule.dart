import 'package:dailies/common/enums/days_of_the_week.dart';

class ByDayRule {
  final int? position;
  final DaysOfTheWeek weekday;

  const ByDayRule(this.weekday, [this.position]);

  static List<ByDayRule> parse(String byDay) {
    return byDay.split(',').map((spec) {
      spec = spec.trim();
      final match = RegExp(r'(-?\d+)?([A-Z]{2})').firstMatch(spec);
      if (match == null) {
        throw ArgumentError('Invalid BYDAY spec: $spec');
      }

      final position = match.group(1) != null ? int.parse(match.group(1)!) : null;
      final weekday = DaysOfTheWeek.fromIcalCode(match.group(2)!);

      return ByDayRule(weekday, position);
    }).toList();
  }

  @override
  String toString() {
    return '${position ?? ''}${weekday.icalCode}';
  }
}
