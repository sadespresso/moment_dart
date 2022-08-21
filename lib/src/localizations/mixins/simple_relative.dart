import 'package:moment_dart/src/extensions.dart';
import 'package:moment_dart/src/localization.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';

/// Depends on [SimpleUnits]
///
/// This mixin **overrides** [MomentLocalization.relative]
mixin SimpleRelative on SimpleUnits {
  @override
  String relative(
    Duration duration, {
    bool dropPrefixOrSuffix = false,
    UnitStringForm form = UnitStringForm.full,
  }) {
    final bool past = duration.isNegative;

    duration = duration.abs();

    DurationInterval interval = MomentLocalization.relativeThreshold(duration);

    String value =
        (units[interval]?.get(form, dropPrefixOrSuffix) ?? "¯\\_(ツ)_/¯");

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
