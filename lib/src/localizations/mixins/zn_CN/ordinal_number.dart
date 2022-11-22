import 'package:moment_dart/moment_dart.dart';

import 'chinese_numbers.dart';

/// This mixin provides set of formatters named `formattersWithZnCnOrdinal`
mixin ZnCnOrdinal on ChineseNumbers {
  String ordinalNumberDay(int n) => "$n日";
  String ordinalNumberWeek(int n) => "$n周";
  String ordinalNumberMonth(int n) => "$n月";

  /// Overrides:
  ///
  /// `Mo`, `Qo`, `Do`, `DDDo`, `d_o`, and `wo`
  Map<FormatterToken, FormatterTokenFn> get formattersWithZnCnOrdinal => {
        FormatterToken.Mo: (DateTime dateTime) =>
            ordinalNumberMonth(dateTime.month),
        FormatterToken.Qo: (DateTime dateTime) =>
            "${chineseNumbers[dateTime.quarter]}季度",
        FormatterToken.Do: (DateTime dateTime) =>
            ordinalNumberDay(dateTime.day),
        FormatterToken.DDDo: (DateTime dateTime) =>
            ordinalNumberDay(dateTime.dayOfYear),
        FormatterToken.d_o: (DateTime dateTime) =>
            ordinalNumberDay(dateTime.weekday),
        FormatterToken.wo: (DateTime dateTime) =>
            ordinalNumberWeek(dateTime.week)
      };
}
