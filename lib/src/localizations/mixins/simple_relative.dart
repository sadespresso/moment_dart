import 'package:moment_dart/src/extension.dart';
import 'package:moment_dart/src/localizations.dart';

mixin SimpleRelative on MomentLocalization {
  /// This is used as a placeholder for unit in plural expressions
  String get srDelta => "%";

  Map<RelativeInterval, String> get relativeUnits;

  String relativePast(String unit);
  String relativeFuture(String unit);

  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) {
    final bool past = duration.isNegative;

    duration = duration.abs();

    RelativeInterval interval = MomentLocalization.relativeThreshold(duration);

    String value = (relativeUnits[interval] ?? "¯\\_(ツ)_/¯");

    if (!interval.singular) {
      value = value.replaceAll(srDelta,
          DurationUnit.relativeDuration(duration, interval.unit).toString());
    }

    if (dropPrefixOrSuffix) return value;

    return past ? relativePast(value) : relativeFuture(value);
  }
}
