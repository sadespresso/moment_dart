import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/types.dart';

/// This mixin provides set of formatters named `formattersForWeekdayShortForms`
mixin WeekdayShortForms on MomentLocalization {
  Map<int, String> get weekdayNameShort;

  Map<int, String>? get weekdayNameMin => null;

  FormatSet get formattersForWeekdayShortForms => {
        FormatterToken.DDD: (DateTime dateTime) =>
            weekdayNameShort[dateTime.weekday]!,
        if (weekdayNameMin != null)
          FormatterToken.DD: (DateTime dateTime) =>
              weekdayNameMin![dateTime.weekday]!,
      };
}
