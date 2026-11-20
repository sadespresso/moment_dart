import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/utils/duration_rounding.dart';
import 'package:moment_dart/src/localizations/mixins/pl_PL/units.dart';

mixin PlPlDuration on PlPlUnits {
  /// If overriden, must implement for all [Abbreviation]s
  Map<Abbreviation, String> get durationDelimiter => {
        Abbreviation.none: " i ",
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

    final List<String> result = [];

    for (int i = 0; i < format.length; i++) {
      final bool last = i == format.length - 1;

      final DurationUnit unit = format.units[i];

      final int unitValue = last
          ? (_roundOrTruncate(left.inMicroseconds / unit.microseconds, round))
          : (left.inMicroseconds ~/ unit.microseconds);

      // The full singular strings are relative-time wording without the
      // number ("час назад"); durations always show it ("1 час и 5 минут").
      final DurationInterval interval = DurationInterval.findByUnit(
        unitValue == 1 && form == Abbreviation.none ? 2 : unitValue,
        unit,
      );

      final String unitString =
          units[interval]?.get(form, dropPrefixOrSuffix, unitValue) ??
              "¯\\_(ツ)_/¯";

      if (!(omitZeros && unitValue == 0)) {
        result.add(unitString.replaceAll(srDelta, unitValue.toString()));
      }

      left -= Duration(microseconds: unit.microseconds * unitValue);
    }

    late final String value;

    if (result.isEmpty) {
      final String unitString = units[DurationInterval.lessThanASecond]
              ?.get(form, dropPrefixOrSuffix) ??
          "¯\\_(ツ)_/¯";

      value = unitString;
    } else {
      value = _join(result, form, delimiter);
    }

    if (dropPrefixOrSuffix) return value;

    return past ? relativePast(value) : relativeFuture(value);
  }

  String _join(List<String> parts, Abbreviation form, String? delimiter) {
    if (delimiter != null || form != Abbreviation.none || parts.length < 3) {
      return parts.join(delimiter ?? durationDelimiter[form]!);
    }

    return "${parts.sublist(0, parts.length - 1).join(", ")}"
        "${durationDelimiter[form]!}${parts.last}";
  }

  int _roundOrTruncate(num x, bool round) {
    return round ? x.round() : x.toInt();
  }
}
