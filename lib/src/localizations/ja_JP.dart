// ignore_for_file: file_names
// Author: Batmend Ganbaatar (https://github.com/sadespresso)

import 'package:moment_dart/src/extensions.dart';
import 'package:moment_dart/src/extensions/constructor.dart';
import 'package:moment_dart/src/localizations/mixins/complex_calendar.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';
import 'package:moment_dart/src/localization.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/types.dart';

/// Language: Japanese
/// Country: Japan
class LocalizationJaJp extends MomentLocalization
    with SimpleUnits, SimpleRelative, SimpleDuration, ComplexCalendar {
  static LocalizationJaJp? _instance;

  LocalizationJaJp._internal() : super();

  factory LocalizationJaJp() {
    _instance ??= LocalizationJaJp._internal();

    return _instance!;
  }

  @override
  String get endonym => "日本語";

  @override
  String get languageCode => "ja";

  @override
  String get countryCode => "JP";

  @override
  String get languageNameInEnglish => "Japanese";

  @override
  String relativePast(String unit) => "$unit前";
  @override
  String relativeFuture(String unit) => "$unit後";

  // 평日 이름
  @override
  Map<int, String> get weekdayName => {
        DateTime.monday: "月曜日",
        DateTime.tuesday: "火曜日",
        DateTime.wednesday: "水曜日",
        DateTime.thursday: "木曜日",
        DateTime.friday: "金曜日",
        DateTime.saturday: "土曜日",
        DateTime.sunday: "日曜日",
      };

  Map<int, String> get weekdayNameShort => {
        DateTime.monday: "月",
        DateTime.tuesday: "火",
        DateTime.wednesday: "水",
        DateTime.thursday: "木",
        DateTime.friday: "金",
        DateTime.saturday: "土",
        DateTime.sunday: "日",
      };

  String monthName(int i) => "$i月";

  @override
  Map<Abbreviation, String> get durationDelimiter => {
        Abbreviation.none: "",
        Abbreviation.semi: "",
        Abbreviation.full: "",
      };

  @override
  FormatSetOptional overrideFormatters() {
    return {
      // Localization aware formats
      FormatterToken.L: (dateTime) => reformat(dateTime, "YYYY/MM/DD"),
      FormatterToken.l: (dateTime) => reformat(dateTime, "YYYY/MM/DD"),
      FormatterToken.LL: (dateTime) => reformat(dateTime, "YYYY年M月D日"),
      FormatterToken.ll: (dateTime) => reformat(dateTime, "YYYY年M月D日"),
      FormatterToken.LLL: (dateTime) => reformat(dateTime, "YYYY年M月D日 HH:mm"),
      FormatterToken.lll: (dateTime) => reformat(dateTime, "YYYY年M月D日 HH:mm"),
      FormatterToken.LLLL: (dateTime) =>
          reformat(dateTime, "YYYY年M月D日 dddd HH:mm"),
      FormatterToken.llll: (dateTime) =>
          reformat(dateTime, "YYYY年M月D日(ddd) HH:mm"),
      FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
      // Missings
      FormatterToken.A: (dateTime) => dateTime.hour < 12 ? "午前" : "午後",
      FormatterToken.a: (dateTime) => dateTime.hour < 12 ? "午前" : "午後",
      // Custom Ordinals
      FormatterToken.Mo: (dateTime) => "${dateTime.month}月",
      FormatterToken.Qo: (dateTime) => "${dateTime.quarter}분기",
      FormatterToken.Do: (dateTime) => "${dateTime.day}日",
      FormatterToken.DDDo: (dateTime) => "${dateTime.dayOfYear}日",
      FormatterToken.d_o: (dateTime) => "${dateTime.weekday}日",
      FormatterToken.wo: (dateTime) => "${dateTime.week}주째",
      // Weekday
      FormatterToken.dd: (dateTime) => weekdayNameShort[dateTime.weekday]!,
      // Controversial :))
      FormatterToken.ddd: (dateTime) => weekdayNameShort[dateTime.weekday]!,
      FormatterToken.dddd: (dateTime) => weekdayName[dateTime.weekday]!,
      // Month names
      FormatterToken.MMM: (dateTime) => monthName(dateTime.month),
      FormatterToken.MMMM: (dateTime) => monthName(dateTime.month),
    };
  }

  @override
  int get weekStart => DateTime.sunday;

  // Korean hangul is compact enough
  @override
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.lessThanASecond: UnitString.single("数秒"),
        DurationInterval.aSecond: UnitString.single("1秒"),
        DurationInterval.seconds: UnitString.single("$srDelta秒"),
        DurationInterval.aMinute: UnitString.single("1分"),
        DurationInterval.minutes: UnitString.single("$srDelta分"),
        DurationInterval.anHour: UnitString.single("1時間"),
        DurationInterval.hours: UnitString.single("$srDelta時間"),
        DurationInterval.aDay: UnitString.single("1日"),
        DurationInterval.days: UnitString.single("$srDelta日"),
        DurationInterval.aWeek: UnitString.single("1週間"),
        DurationInterval.weeks: UnitString.single("$srDelta週間"),
        DurationInterval.aMonth: UnitString.single("1ヶ月"),
        DurationInterval.months: UnitString.single("$srDeltaヶ月"),
        DurationInterval.aYear: UnitString.single("1年"),
        DurationInterval.years: UnitString.single("$srDelta年"),
      };

  @override
  ComplexCalenderLocalizationData get complexCalendarData =>
      ComplexCalenderLocalizationData(
        relativeDayNames: {
          -1: "昨日",
          0: "今日",
          1: "明日",
        },
        keywords: ComplexCalenderLocalizationKeywords(
          lastWeekday: (dateTime, {reference}) {
            final String dddd = reformat(dateTime, "dddd");
            final bool sameWeek = dateTime.isSameLocalWeekAs(
                reference ??
                    DateTimeConstructors.nowWithTimezone(dateTime.isUtc),
                weekStart);

            if (!sameWeek) {
              return "先週$dddd";
            }

            return dddd;
          },
          nextWeekday: (dateTime, {reference}) {
            final String dddd = reformat(dateTime, "dddd");
            final bool sameWeek = dateTime.isSameLocalWeekAs(
                reference ??
                    DateTimeConstructors.nowWithTimezone(dateTime.isUtc),
                weekStart);

            if (!sameWeek) {
              return "来週$dddd";
            }

            return dddd;
          },
        ),
      );
}
