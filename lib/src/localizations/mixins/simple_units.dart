import 'package:moment_dart/moment_dart.dart';

/// [units] is used by following mixins: `simple_relative`, and `simple_duration`.
///
///
/// This mixin provides:
///
/// * [srDelta] - string getter;
/// * [units] - map of unit translations that use [srDelta] as unit placeholder
/// * [durationUnits] - map of unit translations used by `simple_duration`
/// * [relativePast] - A function suffixes/prefixes given duration
/// * [relativeFuture] - A function suffixes/prefixes given duration
mixin SimpleUnits on MomentLocalization {
  /// This is used as a placeholder for unit in plural expressions
  String get srDelta => "%";

  Map<DurationInterval, UnitString> get units;

  /// Unit translations used by `simple_duration`. Defaults to [units].
  ///
  /// [units] serves fuzzy relative time ("in an hour"), while `duration()` is
  /// precise, so override this to spell singular units with the number
  /// ("in 1 hour 1 minute" rather than "in an hour a minute").
  Map<DurationInterval, UnitString> get durationUnits => units;

  String relativePast(String unit);
  String relativeFuture(String unit);
}

abstract class UnitString {
  const UnitString();

  String get(Abbreviation form, bool dropPrefixOrSuffix);

  factory UnitString.withForm(String full, String mid, String short) =>
      UnitStringWithForm._default(full, mid, short);

  factory UnitString.duo(String full, String shorter) =>
      UnitStringWithForm._default(full, shorter, shorter);

  /// Use same text for all forms.
  factory UnitString.single(String value) => UnitStringSingle._default(value);
}

/// Unit string in full, mid, short forms.
///
/// An example:
/// * full: "16 minutes"
/// * mid: "16 mins"
/// * short: "16m"
class UnitStringWithForm extends UnitString {
  final String full;
  final String mid;
  final String short;

  const UnitStringWithForm._default(
    this.full,
    this.mid,
    this.short,
  ) : super();

  @override
  String get(Abbreviation form, bool dropPrefixOrSuffix) {
    switch (form) {
      case Abbreviation.none:
        return full;
      case Abbreviation.semi:
        return mid;
      case Abbreviation.full:
        return short;
    }
  }
}

class UnitStringSingle extends UnitString {
  final String value;

  const UnitStringSingle._default(this.value) : super();

  @override
  String get(Abbreviation form, bool dropPrefixOrSuffix) => value;
}
