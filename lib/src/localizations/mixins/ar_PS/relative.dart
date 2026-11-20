import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/ar_PS/units.dart';

mixin ArPsRelative on ArPsUnits {
  @override
  String relative(
    Duration duration, {
    bool dropPrefixOrSuffix = false,
    Abbreviation form = Abbreviation.none,
  }) {
    final bool past = duration.isNegative;

    duration = duration.abs();

    final DurationInterval interval =
        MomentLocalization.relativeThreshold(duration);

    final int count = interval.singular
        ? 1
        : DurationUnit.relativeDuration(duration, interval.unit);

    final String value = units[interval]!
        .get(form, dropPrefixOrSuffix, count)
        .replaceAll(srDelta, count.toString());

    if (dropPrefixOrSuffix) return value;

    return past ? relativePast(value) : relativeFuture(value);
  }
}
