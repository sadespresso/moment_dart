import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';

/// Depends on [SimpleUnits]
///
/// This mixin provides:
///
/// * [durationDelimiter] - getter for delimeters of each [Abbreviation]
///
/// And **overrides** [MomentLocalization.duration]
mixin SimpleDuration on SimpleUnits {
  /// If overriden, must implement for all [Abbreviation]s
  Map<Abbreviation, String> get durationDelimiter => {
        Abbreviation.none: " ",
        Abbreviation.semi: " ",
        Abbreviation.full: " ",
      };

  /// "and" keyword.
  ///
  /// Used to connect last two elements of duration list items. Will be appended after [durationDelimiter] For example:
  ///
  /// When null -->
  /// 2 minutes 3 seconds
  ///
  /// When equal to 'and' -->
  /// 2 minutes _and_ 3 seconds
  String? get delimeterConnector => null;

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

      final UnitString? unitString = units[interval];

      if (unitString == null) {
        throw MomentException(
            "UnitString implementation is missing for $interval in localization $locale");
      }

      if (!(omitZeros && unitValue == 0)) {
        result.add(unitString
            .get(form, dropPrefixOrSuffix)
            .replaceAll(srDelta, unitValue.toString()));
      }

      left -= Duration(microseconds: unit.microseconds * unitValue);
    }

    late final String value;

    if (result.isEmpty) {
      final UnitString? unitString = units[DurationInterval.lessThanASecond];

      if (unitString == null) {
        throw MomentException(
            "UnitString implementation is missing for ${DurationInterval.lessThanASecond} in localization $locale");
      }

      value = unitString.get(form, dropPrefixOrSuffix);
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
