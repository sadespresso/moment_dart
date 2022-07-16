enum DurationUnit {
  microsecond(0),
  millisecond(1),
  second(2),
  minute(3),
  hour(4),
  day(5),

  /// Doesn't take timezone into account.
  month(6),

  /// Doesn't take timezone into account.
  year(7);

  final int value;

  const DurationUnit(this.value);
}
