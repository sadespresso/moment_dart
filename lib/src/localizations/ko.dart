// ignore_for_file: file_names

import 'package:moment_dart/src/calendar.dart';
import 'package:moment_dart/src/formatters/token.dart';

import '../localizations.dart';
import 'package:moment_dart/src/moment.dart';

/// Language: Korean
/// Country: South Korea
class LocalizationKorean extends MomentLocalization {
  LocalizationKorean() : super();

  @override
  String get endonym => "한국어";

  @override
  String get languageCodeISO => "ko";

  @override
  String get locale => "ko";

  @override
  String get languageNameInEnglish => "Korean";

  /// Used as placeholder in replacable texts. E.g. `relativePast`
  static const String alpha = "%";

  static const String relativePast = "$alpha 전";
  static const String relativeFuture = "$alpha 후";

  /// Please note that Mongolian language string is not in it's base form. A suffix has been added to work with `relativePast`, `relativeFuture`.
  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) {
    final bool past = duration.isNegative;

    duration = duration.abs();

    late final String value;

    RelativeInterval interval = MomentLocalization.relativeThreshold(duration);

    switch (interval) {
      case RelativeInterval.fewSeconds:
        value = "몇 초";
        break;
      case RelativeInterval.aMinute:
        value = "1분";
        break;
      case RelativeInterval.minutes:
        value = "${(duration.inSeconds / 60).round()}분";
        break;
      case RelativeInterval.anHour:
        value = "1시간";
        break;
      case RelativeInterval.hours:
        value = "${(duration.inMinutes / 60).round()}시간";
        break;
      case RelativeInterval.aDay:
        value = "1일";
        break;
      case RelativeInterval.days:
        value = "${(duration.inHours / 24).round()}일";
        break;
      case RelativeInterval.aMonth:
        value = "1개월";
        break;
      case RelativeInterval.months:
        value = "${(duration.inDays / 30).round()}개월";
        break;
      case RelativeInterval.aYear:
        value = "1년";
        break;
      case RelativeInterval.years:
        value = "${(duration.inDays / 365).round()}년";
        break;
    }

    if (dropPrefixOrSuffix) return value;

    return (past ? relativePast : relativeFuture).replaceAll(alpha, value);
  }

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
}
