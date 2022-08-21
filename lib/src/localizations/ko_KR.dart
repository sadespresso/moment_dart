// ignore_for_file: file_names

import 'package:moment_dart/src/extensions.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';
import 'package:moment_dart/src/localization.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';

/// Language: Korean
/// Country: South Korea
class LocalizationKo extends MomentLocalization
    with SimpleUnits, SimpleRelative, SimpleDuration {
  LocalizationKo() : super();

  @override
  String get endonym => "한국어";

  @override
  String get languageCode => "ko";

  @override
  String get countryCode => "KR";

  @override
  String get languageNameInEnglish => "Korean";

  @override
  String relativePast(String unit) => "$unit 전";
  @override
  String relativeFuture(String unit) => "$unit 후";

  // 평일 이름
  @override
  Map<int, String> get weekdayName => {
        1: "월요일",
        2: "화요일",
        3: "수요일",
        4: "목요일",
        5: "금요일",
        6: "토요일",
        7: "일요일",
      };

  // 평일 이름
  Map<int, String> get weekdayNameShort => {
        1: "월",
        2: "화",
        3: "수",
        4: "목",
        5: "금",
        6: "토",
        7: "일",
      };

  String monthName(int i) => "$i월";

  @override
  Map<FormatterToken, FormatterTokenFn?> overrideFormatters() {
    return {
      // Localization aware formats
      FormatterToken.L: (dateTime) => reformat(dateTime, "YYYY.MM.DD."),
      FormatterToken.l: (dateTime) => reformat(dateTime, "YYYY.M.D."),
      FormatterToken.LL: (dateTime) => reformat(dateTime, "YYYY년 MMMM D일"),
      FormatterToken.ll: (dateTime) => reformat(dateTime, "YYYY년 MMM D일"),
      FormatterToken.LLL: (dateTime) =>
          reformat(dateTime, "YYYY년 MMMM D일 A hh:mm"),
      FormatterToken.lll: (dateTime) =>
          reformat(dateTime, "YYYY년 MMM D일 A h:mm"),
      FormatterToken.LLLL: (dateTime) =>
          reformat(dateTime, "YYYY년 MMMM D일 dddd A hh:mm"),
      FormatterToken.llll: (dateTime) =>
          reformat(dateTime, "YYYY년 MMM D일 ddd A h:mm"),
      FormatterToken.LT: (dateTime) => reformat(dateTime, "A h:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "A h:mm:ss"),
      // Missings
      FormatterToken.A: (dateTime) => dateTime.hour < 12 ? "오전" : "오후",
      FormatterToken.a: (dateTime) => dateTime.hour < 12 ? "오전" : "오후",
      // Custom Ordinals
      FormatterToken.Mo: (dateTime) => "${dateTime.month}월",
      FormatterToken.Qo: (dateTime) => "${dateTime.quarter}분기",
      FormatterToken.Do: (dateTime) => "${dateTime.day}일",
      FormatterToken.DDDo: (dateTime) => "${dateTime.dayOfYear}일",
      FormatterToken.d_o: (dateTime) => "${dateTime.weekday}일",
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
  CalenderLocalizationData get calendarData => calenderLocalizationDataKo;

  static String last(String weekday) => "지난 $weekday";

  static const CalenderLocalizationData calenderLocalizationDataKo =
      CalenderLocalizationData(
    relativeDayNames: {
      -2: "그저께",
      -1: "어제",
      0: "오늘",
      1: "내일",
      2: "모레",
    },
    keywords: CalenderLocalizationKeywords(
      lastWeekday: last,
    ),
  );

  @override
  int get weekStart => DateTime.sunday;

  // Korean hangul is compact enough
  @override
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.lessThanASecond: UnitString.single("몇 초"),
        DurationInterval.aSecond: UnitString.single("1초"),
        DurationInterval.seconds: UnitString.single("$srDelta초"),
        DurationInterval.aMinute: UnitString.single("1분"),
        DurationInterval.minutes: UnitString.single("$srDelta분"),
        DurationInterval.anHour: UnitString.single("1시간"),
        DurationInterval.hours: UnitString.single("$srDelta시간"),
        DurationInterval.aDay: UnitString.single("1일"),
        DurationInterval.days: UnitString.single("$srDelta일"),
        DurationInterval.aWeek: UnitString.single("1주"),
        DurationInterval.weeks: UnitString.single("$srDelta주"),
        DurationInterval.aMonth: UnitString.single("1개월"),
        DurationInterval.months: UnitString.single("$srDelta개월"),
        DurationInterval.aYear: UnitString.single("1년"),
        DurationInterval.years: UnitString.single("$srDelta년"),
      };
}
