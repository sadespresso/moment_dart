import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/ru_RU/units.dart';

mixin RuRuDuration on RuRuUnits {
  /// If overriden, must implement for all [Abbreviation]s
  Map<Abbreviation, String> get durationDelimiter => {
        Abbreviation.none: " и ",
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

    Duration left = duration.abs();

    if (format.isAuto) {
      format = DurationFormat.resolveAuto(duration, includeWeeks);
    }

    final List<String> result = [];

    for (int i = 0; i < format.length; i++) {
      final bool last = i == format.length - 1;

      final DurationUnit unit = format.units[i];

      final int unitValue = last
          ? (_roundOrTruncate(left.inMicroseconds / unit.microseconds, round))
          : (left.inMicroseconds ~/ unit.microseconds);

      final DurationInterval interval =
          DurationInterval.findByUnit(unitValue, unit);

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
      value = result.join(delimiter ?? durationDelimiter[form]!);
    }

    if (dropPrefixOrSuffix) return value;

    return past ? relativePast(value) : relativeFuture(value);
  }

  int _roundOrTruncate(num x, bool round) {
    return round ? x.round() : x.toInt();
  }
}
