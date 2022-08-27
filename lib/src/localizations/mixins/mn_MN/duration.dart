import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/mn_MN/units.dart';

mixin MnMnDuration on MnMnUnits {
  /// If overriden, must implement for all [UnitStringForm]s
  Map<UnitStringForm, String> get durationDelimiter => {
        UnitStringForm.full: " ",
        UnitStringForm.mid: " ",
        UnitStringForm.short: " ",
      };

  @override
  String duration(
    Duration duration, {
    bool round = true,
    bool omitZeros = true,
    bool includeWeeks = false,
    UnitStringForm form = UnitStringForm.full,
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

      final String unitString = getUnit(interval, form,
          dropPrefixOrSuffix: !last || dropPrefixOrSuffix);

      if (!(omitZeros && unitValue == 0)) {
        result.add(unitString.replaceAll(srDelta, unitValue.toString()));
      }

      left -= Duration(microseconds: unit.microseconds * unitValue);
    }

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
