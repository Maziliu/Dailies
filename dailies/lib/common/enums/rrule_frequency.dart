enum RRuleFrequency {
  Daily('DAILY', units: 'Days'),
  Weekly('WEEKLY', units: 'Weeks'),
  Monthly('MONTHLY', units: 'Months'),
  Yearly('YEARLY', units: 'Years');

  const RRuleFrequency(this.value, {this.units = ''});
  final String value;
  final String units;

  static RRuleFrequency fromString(String freq) {
    return RRuleFrequency.values.firstWhere(
      (f) => f.value == freq.toUpperCase(),
      orElse: () => throw ArgumentError('Invalid FREQ value: $freq'),
    );
  }
}
