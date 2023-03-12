import 'package:moment_dart/moment_dart.dart';

/// [units] is used by following mixins: `simple_relative`, and `simple_duration`.
///
///
/// This mixin provides:
///
/// * [srDelta] - string getter;
/// * [units] - map of unit translations that use [srDelta] as unit placeholder
/// * [relativePast] - A function suffixes/prefixes given duration
/// * [relativeFuture] - A function suffixes/prefixes given duration
mixin SimpleUnits on MomentLocalization {
  /// This is used as a placeholder for unit in plural expressions
  String get srDelta => "%";

  Map<DurationInterval, UnitString> get units;

  String relativePast(String unit);
  String relativeFuture(String unit);
}

abstract class UnitString {
  const UnitString();

  String get(UnitStringForm form, bool dropPrefixOrSuffix);

  factory UnitString.withForm(String full, String mid, String short) =>
      UnitStringWithForm._default(full, mid, short);

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
  String get(UnitStringForm form, bool dropPrefixOrSuffix) {
    switch (form) {
      case UnitStringForm.full:
        return full;
      case UnitStringForm.mid:
        return mid;
      case UnitStringForm.short:
        return short;
    }
  }
}

class UnitStringSingle extends UnitString {
  final String value;

  const UnitStringSingle._default(this.value) : super();

  @override
  String get(UnitStringForm form, bool dropPrefixOrSuffix) => value;
}
