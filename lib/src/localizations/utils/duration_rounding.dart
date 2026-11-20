import 'package:moment_dart/src/localizations/utils/duration_format.dart';
import 'package:moment_dart/src/localizations/utils/duration_unit.dart';

class RoundedDuration {
  final DurationFormat format;

  /// Absolute value, a whole multiple of [format]'s smallest unit
  final Duration duration;

  const RoundedDuration(this.format, this.duration);
}

/// Rounds (or truncates) [duration] to the smallest unit of the format before
/// it is split into units, so 59m59.6s becomes "1 hour" and not
/// "59 minutes 60 seconds".
RoundedDuration roundDurationForFormat(
  Duration duration,
  DurationFormat format, {
  required bool includeWeeks,
  required bool round,
}) {
  final Duration abs = duration.abs();

  if (!format.isAuto) {
    return RoundedDuration(format, _roundLast(abs, format, round));
  }

  DurationFormat resolved = DurationFormat.resolveAuto(abs, includeWeeks);
  Duration rounded = _roundLast(abs, resolved, round);

  final DurationFormat carried =
      DurationFormat.resolveAuto(rounded, includeWeeks);

  if (carried.units.first != resolved.units.first) {
    resolved = carried;
    rounded = _roundLast(abs, resolved, round);
  }

  return RoundedDuration(resolved, rounded);
}

/// Leading units are truncated exactly like the formatting loop does; only
/// the remainder is rounded to the last unit. Rounding the whole duration
/// would misplace values, since a year is not a whole number of months.
Duration _roundLast(Duration abs, DurationFormat format, bool round) {
  int remainder = abs.inMicroseconds;

  for (final DurationUnit unit in format.units.take(format.length - 1)) {
    remainder %= unit.microseconds;
  }

  final int step = format.last.microseconds;
  final int count = round ? (remainder / step).round() : remainder ~/ step;

  return Duration(
    microseconds: abs.inMicroseconds - remainder + count * step,
  );
}
