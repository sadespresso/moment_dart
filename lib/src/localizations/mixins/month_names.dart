import 'package:moment_dart/moment_dart.dart';

mixin MonthNames on MomentLocalization {
  /// Month name from month number (1-12)
  Map<int, String> get monthNames;

  /// Short month name from month number (1-12)
  Map<int, String> get monthNamesShort;

  Map<FormatterToken, FormatterTokenFn> get formattersForMonthNames => {
        FormatterToken.MMM: (dateTime) => monthNamesShort[dateTime.month]!,
        FormatterToken.MMMM: (dateTime) => monthNames[dateTime.month]!,
      };
}
