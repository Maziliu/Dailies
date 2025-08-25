enum DaysOfTheWeek {
  Monday(1, 'MO'),
  Tuesday(2, 'TU'),
  Wednesday(3, 'WE'),
  Thursday(4, 'TH'),
  Friday(5, 'FR'),
  Saturday(6, 'SA'),
  Sunday(7, 'SU');

  const DaysOfTheWeek(this.value, this.icalCode);

  final int value;
  final String icalCode;

  static DaysOfTheWeek fromDateTime(DateTime dateTime) {
    return DaysOfTheWeek.values.firstWhere((day) => day.value == dateTime.weekday);
  }

  static DaysOfTheWeek fromIcalCode(String code) {
    return DaysOfTheWeek.values.firstWhere((day) => day.icalCode == code.toUpperCase(), orElse: () => throw ArgumentError('Invalid iCal day code: $code'));
  }

  static List<DaysOfTheWeek> fromIcalCodes(String codes) {
    return codes.split(',').map((code) => fromIcalCode(code.trim())).toList();
  }
}
