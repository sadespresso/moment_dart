import 'package:moment_dart/moment_dart.dart';

/// This mixin provides:
///
/// * [formattersForMonthNames] - getter for set of formatters related to month names
mixin MonthNames on MomentLocalization {
  /// Month name from month number (1-12) (January, Febuary, ..., December)
  Map<int, String> get monthNames;

  /// Short month name from month (1-12) (Jan, Feb, ..., Dec)
  Map<int, String> get monthNamesShort;

  /// Min month name from month (1-12) (01, 02, ..., 12)
  Map<int, String>? get monthNamesMin => null;

  /// Overrides:
  ///
  /// `MMM` and `MMMM`
  Map<FormatterToken, FormatterTokenFn> get formattersForMonthNames => {
        if (monthNamesMin != null)
          FormatterToken.MM: (dateTime) => monthNamesMin![dateTime.month]!,
        FormatterToken.MMM: (dateTime) => monthNamesShort[dateTime.month]!,
        FormatterToken.MMMM: (dateTime) => monthNames[dateTime.month]!,
      };
}
