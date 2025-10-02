import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/ru_RU/units.dart';

mixin RuRuRelative on RuRuUnits {
  @override
  String relative(
    Duration duration, {
    bool dropPrefixOrSuffix = false,
    Abbreviation form = Abbreviation.none,
  }) {
    final bool past = duration.isNegative;

    duration = duration.abs();

    DurationInterval interval = MomentLocalization.relativeThreshold(duration);

    String value = (units[interval]?.get(form, dropPrefixOrSuffix,
            DurationUnit.relativeDuration(duration, interval.unit)) ??
        "¯\\_(ツ)_/¯");

    if (!interval.singular) {
      value = value.replaceAll(
        srDelta,
        DurationUnit.relativeDuration(duration, interval.unit).toString(),
      );
    }

    if (dropPrefixOrSuffix) return value;

    return past ? relativePast(value) : relativeFuture(value);
  }
}
