import 'package:moment_dart/moment_dart.dart';

extension DurationExtra on Duration {
  static const int daysPerWeek = 7;

  /// Only returns whole weeks. Here, a week equals [daysPerWeek] days
  int get inWeeks => inDays ~/ daysPerWeek;

  static const int daysPerMonth = 30;

  /// Precise number for nerds
  static const double daysPerMonthPrecise = 30.4368499;

  /// Only returns whole months. Here, a month equals [daysPerMonth] days
  int get inMonths => inDays ~/ daysPerMonth;

  static const int daysPerYear = 365;

  /// Precise number for nerds
  static const double daysPerYearPrecise = 365.242199;

  /// Only returns whole years
  int get inYears => inDays ~/ daysPerYear;

  static const int weeksPerYear = 52;

  /// Precise number for nerds
  static const double weeksPerYearPrecise = 52.177457;

  static const int monthsPerYear = 12;

  String toDurationString(
    MomentLocalization localization, {
    bool round = true,
    bool omitZeros = true,
    bool includeWeeks = false,
    UnitStringForm form = UnitStringForm.full,
    String? delimiter,
    DurationFormat format = DurationFormat.auto,
    bool dropPrefixOrSuffix = false,
  }) {
    return localization.duration(
      this,
      round: round,
      omitZeros: omitZeros,
      includeWeeks: includeWeeks,
      form: form,
      delimiter: delimiter,
      format: format,
      dropPrefixOrSuffix: dropPrefixOrSuffix,
    );
  }
}
