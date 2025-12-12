enum RRuleFrequency {
  Daily('DAILY'),
  Weekly('WEEKLY'),
  Monthly('MONTHLY'),
  Yearly('YEARLY');

  const RRuleFrequency(this.value);
  final String value;

  static RRuleFrequency fromString(String freq) {
    return RRuleFrequency.values.firstWhere(
      (f) => f.value == freq.toUpperCase(),
      orElse: () => throw ArgumentError('Invalid FREQ value: $freq'),
    );
  }
}
