import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/utils/duration_rounding.dart';
import 'package:moment_dart/src/localizations/mixins/ar_PS/units.dart';

mixin ArPsDuration on ArPsUnits {
  /// If overriden, must implement for all [Abbreviation]s
  Map<Abbreviation, String> get durationDelimiter => {
        Abbreviation.none: " و",
        Abbreviation.semi: " و",
        Abbreviation.full: " و",
      };

  @override
  String duration(
    Duration duration, {
    bool round = true,
    bool omitZeros = true,
    bool includeWeeks = false,
    Abbreviation form = Abbreviation.none,
    String? delimiter,
    DurationFormat format = DurationFormat.auto,
    bool dropPrefixOrSuffix = false,
  }) {
    final bool past = duration.isNegative;

    final RoundedDuration rounded = roundDurationForFormat(
      duration,
      format,
      includeWeeks: includeWeeks,
      round: round,
    );

    format = rounded.format;

    Duration left = rounded.duration;

    final List<String> result = [];

    for (int i = 0; i < format.length; i++) {
      final bool last = i == format.length - 1;

      final DurationUnit unit = format.units[i];

      final int unitValue = last
          ? (_roundOrTruncate(left.inMicroseconds / unit.microseconds, round))
          : (left.inMicroseconds ~/ unit.microseconds);

      final DurationInterval interval =
          DurationInterval.findByUnit(unitValue, unit);

      if (!(omitZeros && unitValue == 0)) {
        result.add(units[interval]!
            .get(form, dropPrefixOrSuffix, unitValue)
            .replaceAll(srDelta, unitValue.toString()));
      }

      left -= Duration(microseconds: unit.microseconds * unitValue);
    }

    final String value = result.isEmpty
        ? units[DurationInterval.lessThanASecond]!.get(form, dropPrefixOrSuffix)
        : result.join(delimiter ?? durationDelimiter[form]!);

    if (dropPrefixOrSuffix) return value;

    return past ? relativePast(value) : relativeFuture(value);
  }

  int _roundOrTruncate(num x, bool round) {
    return round ? x.round() : x.toInt();
  }
}
