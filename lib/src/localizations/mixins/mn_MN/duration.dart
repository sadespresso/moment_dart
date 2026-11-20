import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/utils/duration_rounding.dart';
import 'package:moment_dart/src/localizations/mixins/mn_MN/units.dart';

mixin MnMnDuration on MnMnUnits {
  /// If overriden, must implement for all [Abbreviation]s
  Map<Abbreviation, String> get durationDelimiter => {
        Abbreviation.none: " ",
        Abbreviation.semi: " ",
        Abbreviation.full: " ",
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

    final List<DurationInterval> intervals = [];
    final List<int> values = [];

    for (int i = 0; i < format.length; i++) {
      final bool last = i == format.length - 1;

      final DurationUnit unit = format.units[i];

      final int unitValue = last
          ? (_roundOrTruncate(left.inMicroseconds / unit.microseconds, round))
          : (left.inMicroseconds ~/ unit.microseconds);

      if (!(omitZeros && unitValue == 0)) {
        intervals.add(DurationInterval.findByUnit(unitValue, unit));
        values.add(unitValue);
      }

      left -= Duration(microseconds: unit.microseconds * unitValue);
    }

    // Only the last word before "өмнө"/"дараа" takes the genitive, so the
    // suffix goes on the last part that is actually printed
    final List<String> result = [
      for (int i = 0; i < values.length; i++)
        getUnit(intervals[i], form,
                dropPrefixOrSuffix:
                    i != values.length - 1 || dropPrefixOrSuffix)
            .replaceAll(srDelta, values[i].toString()),
    ];

    late final String value;

    if (result.isEmpty) {
      final String unitString = getUnit(DurationInterval.lessThanASecond, form,
          dropPrefixOrSuffix: dropPrefixOrSuffix);

      value = unitString;
    } else {
      value = result.join(delimiter ?? durationDelimiter[form]!);
    }

    if (dropPrefixOrSuffix) return value;

    return past ? relativePast(value) : relativeFuture(value);
  }

  int _roundOrTruncate(num x, bool round) {
    return round ? x.round() : x.toInt();
  }
}
