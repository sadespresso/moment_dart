import 'package:moment_dart/moment_dart.dart';

/// This mixin provides set of formatters named `formattersWithOrdinal`
///
/// And a function named `ordinalNumber`, which returns ordinal number string of any `int`
mixin EnglishLikeOrdinal on MomentLocalization {
  /// Ordinal suffixes in order:
  ///
  /// 1, 2, 3, other
  ///
  /// For example: ["st", "nd", "rd", "th"]
  List<String> get ordinalSuffixes;

  /// Returns ordinal number string.
  ///
  /// An example in English (US):
  ///
  /// * 1st
  /// * 12th
  /// * 2602nd
  /// * 303rd
  /// * 1000th
  String ordinalNumber(int n) {
    final int lastTwoDigit = n % 100;

    if (!(lastTwoDigit > 10 && lastTwoDigit < 14)) {
      final int lastDigit = n % 10;

      switch (lastDigit) {
        case 1:
          return "$n${ordinalSuffixes[1]}";
        case 2:
          return "$n${ordinalSuffixes[2]}";
        case 3:
          return "$n${ordinalSuffixes[3]}";
        default:
          break;
      }
    }

    return "$n${ordinalSuffixes[0]}";
  }

  /// Overrides:
  ///
  /// `Mo`, `Qo`, `Do`, `DDDo`, `d_o`, and `wo`
  Map<FormatterToken, FormatterTokenFn> get formattersWithOrdinal => {
        FormatterToken.Mo: (DateTime dateTime) => ordinalNumber(dateTime.month),
        FormatterToken.Qo: (DateTime dateTime) =>
            ordinalNumber(dateTime.quarter),
        FormatterToken.Do: (DateTime dateTime) => ordinalNumber(dateTime.day),
        FormatterToken.DDDo: (DateTime dateTime) =>
            ordinalNumber(dateTime.dayOfYear),
        FormatterToken.d_o: (DateTime dateTime) =>
            ordinalNumber(dateTime.weekday),
        FormatterToken.wo: (DateTime dateTime) => ordinalNumber(dateTime.week)
      };
}
