// ignore_for_file: file_names

import 'package:moment_dart/src/formatters/token.dart';

import '../localizations.dart';
import 'package:moment_dart/src/moment.dart';

/// Language: Korean
/// Country: South Korea
class LocalizationKorean extends MomentLocalization {
  LocalizationKorean() : super();

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

  // Tibet weekday names are here, because it is majorly used in Mongolia
  static const Map<int, String> weekdayNames = {
    1: "월",
    2: "화",
    3: "수",
    4: "목",
    5: "금",
    6: "토",
    7: "일",
  };

  static const String weekdaySuffix = "요일";

  @override
  String weekdayName(int i) => weekdayNames[i]!; //평일 이름

  @override
  String calendar(
    Moment moment, {
    Moment? reference,
    bool weekStartOnSunday = false,
    bool omitHours = false,
    String? customFormat,
  }) {
    reference ??= Moment.now();

    late final String day;

    final int _deltaDays = deltaDays(reference, moment);

    final bool isToday = _deltaDays == 0;

    if (isToday) {
      day = "오늘";
    }

    /// Before the `reference`
    else if (moment.isBefore(reference)) {
      final bool isYesterday = _deltaDays == -1;
      final bool isDayBeforeYesterday = _deltaDays == -2;

      if (isYesterday) {
        day = "어제";
      } else if (isDayBeforeYesterday) {
        day = "그저께";
      } else {
        final Moment weekBefore = reference.subtract(const Duration(days: 7));

        if (moment.isBefore(weekBefore)) {
          day = moment.format(customFormat ?? localizationDefaultDateFormat);
        } else {
          day = "지난 ${weekdayName(moment.weekday)}$weekdaySuffix";
        }
      }
    } else {
      final bool isTomorrow = _deltaDays == 1;
      final bool isDayAfterTomorrow = _deltaDays == 2;

      if (isTomorrow) {
        day = "내일";
      } else if (isDayAfterTomorrow) {
        day = "모레";
      } else {
        final Moment weekAfter = reference.add(const Duration(days: 7));

        /// If it's this or next week (relative to the reference)
        if (moment.isBefore(weekAfter)) {
          day = weekdayName(moment.weekday) + weekdaySuffix;
        } else {
          day = moment.format(customFormat ?? localizationDefaultDateFormat);
        }
      }
    }

    if (customFormat != null) {
      return day;
    }

    if (omitHours) {
      return day;
    }

    return "$day ${moment.format(localizationDefaultHourFormat)}";
  }

  String monthName(int i) => "$i월";

  @override
  Map<FormatterToken, FormatterTokenFn?> formats() => {
        FormatterToken.M: (DateTime dateTime) => dateTime.month.toString(),
        FormatterToken.Mo: (DateTime dateTime) => "${dateTime.month}월",
        FormatterToken.MM: (DateTime dateTime) =>
            dateTime.month.toString().padLeft(2, '0'),
        FormatterToken.MMM: (DateTime dateTime) => monthName(dateTime.month),
        FormatterToken.MMMM: (DateTime dateTime) => monthName(dateTime.month),
        FormatterToken.Q: (DateTime dateTime) => dateTime.quarter.toString(),
        FormatterToken.Qo: (DateTime dateTime) => "${dateTime.quarter}분기",
        FormatterToken.D: (DateTime dateTime) => dateTime.day.toString(),
        FormatterToken.Do: (DateTime dateTime) => "${dateTime.day}일",
        FormatterToken.DD: (DateTime dateTime) =>
            dateTime.day.toString().padLeft(2, '0'),
        FormatterToken.DDD: (DateTime dateTime) =>
            dateTime.dayOfYear.toString(),
        FormatterToken.DDDo: (DateTime dateTime) => "${dateTime.dayOfYear}일",
        FormatterToken.DDDD: (DateTime dateTime) =>
            dateTime.dayOfYear.toString().padLeft(3, '0'),
        FormatterToken.d: (DateTime dateTime) => dateTime.weekday.toString(),
        FormatterToken.d_o: (DateTime dateTime) => "${dateTime.weekday}일",
        FormatterToken.dd: (DateTime dateTime) => weekdayName(dateTime.weekday),
        // Controversial :))
        FormatterToken.ddd: (DateTime dateTime) =>
            weekdayName(dateTime.weekday),
        FormatterToken.dddd: (DateTime dateTime) =>
            weekdayName(dateTime.weekday) + weekdaySuffix,
        FormatterToken.e: (DateTime dateTime) => dateTime.weekday.toString(),
        FormatterToken.w: (DateTime dateTime) => dateTime.week.toString(),
        FormatterToken.wo: (DateTime dateTime) => "${dateTime.week}주째",
        FormatterToken.ww: (DateTime dateTime) =>
            dateTime.week.toString().padLeft(2, '0'),
        FormatterToken.YY:
            //TODO: Improve the code before 22nd century
            (DateTime dateTime) {
          if (dateTime.year < 1970 || dateTime.year > 2030) {
            throw Exception("YY formatter only work in range [1970; 2030]");
          }
          return dateTime.year.toString().substring(2);
        },
        FormatterToken.YYYY: (DateTime dateTime) => dateTime.year.toString(),
        FormatterToken.y: null,
        FormatterToken.NN: null,
        FormatterToken.NNNN: null,
        FormatterToken.NNNNN: null,
        FormatterToken.gg: (DateTime dateTime) {
          if (dateTime.year < 1970 || dateTime.year > 2030) {
            throw Exception("YY formatter only work in range [1970; 2030]");
          }
          return dateTime.weekYear.toString().substring(2);
        },
        FormatterToken.gggg: (DateTime dateTime) =>
            dateTime.weekYear.toString(),
        FormatterToken.A: (DateTime dateTime) =>
            dateTime.hour < 12 ? "오전" : "오후",
        FormatterToken.a: (DateTime dateTime) =>
            dateTime.hour < 12 ? "오전" : "오후",
        FormatterToken.H: (DateTime dateTime) =>
            dateTime.hour == 0 ? "00" : dateTime.hour.toString(),
        FormatterToken.HH: (DateTime dateTime) =>
            dateTime.hour.toString().padLeft(2, "0"),
        FormatterToken.h: (DateTime dateTime) =>
            dateTime.hour == 0 ? "12" : "${dateTime.hour % 12}",
        FormatterToken.hh: (DateTime dateTime) => dateTime.hour == 0
            ? "12"
            : (dateTime.hour % 12).toString().padLeft(2, "0"),
        FormatterToken.k: (DateTime dateTime) =>
            dateTime.hour == 0 ? "24" : dateTime.hour.toString(),
        FormatterToken.kk: (DateTime dateTime) => dateTime.hour == 0
            ? "24"
            : dateTime.hour.toString().padLeft(2, "0"),
        FormatterToken.m: (DateTime dateTime) => dateTime.minute.toString(),
        FormatterToken.mm: (DateTime dateTime) =>
            dateTime.minute.toString().padLeft(2, "0"),
        FormatterToken.s: (DateTime dateTime) => dateTime.second.toString(),
        FormatterToken.ss: (DateTime dateTime) =>
            dateTime.second.toString().padLeft(2, "0"),
        FormatterToken.S: (DateTime dateTime) =>
            (dateTime.millisecond / 100).round().toString().padLeft(2, "0"),
        FormatterToken.SS: (DateTime dateTime) =>
            (dateTime.millisecond / 10).round().toString().padLeft(2, "0"),
        FormatterToken.SSS: (DateTime dateTime) =>
            dateTime.millisecond.toString().padLeft(3, "0"),
        FormatterToken.SSSS: (DateTime dateTime) =>
            (dateTime.microsecond / 100).round().toString().padLeft(3, "0"),
        FormatterToken.SSSSS: (DateTime dateTime) =>
            (dateTime.microsecond / 10).round().toString().padLeft(3, "0"),
        FormatterToken.SSSSSS: (DateTime dateTime) =>
            dateTime.microsecond.toString().padLeft(3, "0"),
        FormatterToken.Z: (DateTime dateTime) => dateTime.timeZoneFormatted(),
        FormatterToken.ZZ: (DateTime dateTime) =>
            dateTime.timeZoneFormatted(false),
        FormatterToken.ZZZ: (DateTime dateTime) => dateTime.timeZoneName,
        FormatterToken.X: (DateTime dateTime) =>
            dateTime.microsecondsSinceEpoch.toString(),
        FormatterToken.x: (DateTime dateTime) =>
            dateTime.millisecondsSinceEpoch.toString(),
        // Localization aware formats
        FormatterToken.L: (DateTime dateTime) =>
            reformat(dateTime, "YYYY.MM.DD."),
        FormatterToken.l: (DateTime dateTime) =>
            reformat(dateTime, "YYYY.M.D."),
        FormatterToken.LL: (DateTime dateTime) =>
            reformat(dateTime, "YYYY년 MMMM D일"),
        FormatterToken.ll: (DateTime dateTime) =>
            reformat(dateTime, "YYYY년 MMM D일"),
        FormatterToken.LLL: (DateTime dateTime) =>
            reformat(dateTime, "YYYY년 MMMM D일 A hh:mm"),
        FormatterToken.lll: (DateTime dateTime) =>
            reformat(dateTime, "YYYY년 MMM D일 A h:mm"),
        FormatterToken.LLLL: (DateTime dateTime) =>
            reformat(dateTime, "YYYY년 MMMM D일 dddd A hh:mm"),
        FormatterToken.llll: (DateTime dateTime) =>
            reformat(dateTime, "YYYY년 MMM D일 ddd A h:mm"),
        FormatterToken.LT: (DateTime dateTime) => reformat(dateTime, "A h:mm"),
        FormatterToken.LTS: (DateTime dateTime) =>
            reformat(dateTime, "A h:mm:ss"),
      };

  @override
  String endonym() => "한국어";

  @override
  String languageCodeISO() => "ko";

  @override
  String locale() => "ko";

  @override
  String languageNameInEnglish() => "Korean";
}