// ignore_for_file: file_names

import 'package:moment_dart/src/formatters/token.dart';

import '../localizations.dart';
import 'package:moment_dart/src/moment.dart';

/// Language: German
/// Country: Germany
class LocalizationGermanStandard extends MomentLocalization {
  LocalizationGermanStandard() : super();

  /// Used as placeholder in replacable texts. E.g. `relativePast`
  static const String alpha = "%";

  static const String relativePast = "vor $alpha";
  static const String relativeFuture = "in $alpha";

  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) {
    final bool past = duration.isNegative;

    duration = duration.abs();

    late final String value;

    RelativeInterval interval = MomentLocalization.relativeThreshold(duration);

    switch (interval) {
      case RelativeInterval.fewSeconds:
        value = "wenigen Sekunden";
        break;
      case RelativeInterval.aMinute:
        value = "einer Minute";
        break;
      case RelativeInterval.minutes:
        value = "${(duration.inSeconds / 60).round()} Minuten";
        break;
      case RelativeInterval.anHour:
        value = "einer Stunde";
        break;
      case RelativeInterval.hours:
        value = "${(duration.inMinutes / 60).round()} Stunden";
        break;
      case RelativeInterval.aDay:
        value = "einem Tag";
        break;
      case RelativeInterval.days:
        value = "${(duration.inHours / 24).round()} Tagen";
        break;
      case RelativeInterval.aMonth:
        value = "einem Monat";
        break;
      case RelativeInterval.months:
        value = "${(duration.inDays / 30).round()} Monaten";
        break;
      case RelativeInterval.aYear:
        value = "einem Jahr";
        break;
      case RelativeInterval.years:
        value = "${(duration.inDays / 365).round()} Jahren";
        break;
    }

    if (dropPrefixOrSuffix) return value;

    return (past ? relativePast : relativeFuture).replaceAll(alpha, value);
  }

  static const Map<int, String> weekdayNames = {
    1: "Montag",
    2: "Dienstag",
    3: "Mittwoch",
    4: "Donnerstag",
    5: "Freitag",
    6: "Samstag",
    7: "Sonntag",
  };

  @override
  String weekdayName(int i) => weekdayNames[i]!;

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
      day = "heute";
    }

    /// Before the `reference`
    else if (moment.isBefore(reference)) {
      final bool isYesterday = _deltaDays == -1;

      if (isYesterday) {
        day = "gestern";
      } else {
        final Moment weekBefore = reference.subtract(const Duration(days: 7));

        if (moment.isBefore(weekBefore)) {
          day = moment.format(customFormat ?? localizationDefaultDateFormat);
        } else {
          day = "letzten ${weekdayName(moment.dateTime.weekday)}";
        }
      }
    } else {
      final bool isTomorrow = _deltaDays == 1;

      if (isTomorrow) {
        day = "morgen";
      } else {
        final Moment weekAfter = reference.add(const Duration(days: 7));

        /// If it's this or next week (relative to the reference)
        if (moment.isBefore(weekAfter)) {
          day = weekdayName(moment.dateTime.weekday);
        } else {
          day = moment.format(customFormat ?? localizationDefaultDateFormat);
        }
      }
    }

    if (customFormat != null) return day;

    if (omitHours) {
      return day;
    }

    return "$day um ${moment.format(localizationDefaultHourFormat)}";
  }

  String ordinalNumber(int n) => "$n.";

  static const Map<int, String> monthNames = {
    1: "Januar",
    2: "Februar",
    3: "März",
    4: "April",
    5: "Mai",
    6: "Juni",
    7: "Juli",
    8: "August",
    9: "September",
    10: "Oktober",
    11: "November",
    12: "Dezember",
  };

  @override
  Map<FormatterToken, String Function(DateTime)?> formats() => {
        FormatterToken.M: (DateTime dateTime) => dateTime.month.toString(),
        FormatterToken.Mo: (DateTime dateTime) => ordinalNumber(dateTime.month),
        FormatterToken.MM: (DateTime dateTime) =>
            dateTime.month.toString().padLeft(2, '0'),
        FormatterToken.MMM: (DateTime dateTime) =>
            monthNames[dateTime.month]!.substring(0, 3),
        FormatterToken.MMMM: (DateTime dateTime) => monthNames[dateTime.month]!,
        FormatterToken.Q: (DateTime dateTime) => dateTime.quarter.toString(),
        FormatterToken.Qo: (DateTime dateTime) =>
            ordinalNumber(dateTime.quarter),
        FormatterToken.D: (DateTime dateTime) => dateTime.day.toString(),
        FormatterToken.Do: (DateTime dateTime) => ordinalNumber(dateTime.day),
        FormatterToken.DD: (DateTime dateTime) =>
            dateTime.day.toString().padLeft(2, '0'),
        FormatterToken.DDD: (DateTime dateTime) =>
            dateTime.dayOfYear.toString(),
        FormatterToken.DDDo: (DateTime dateTime) =>
            ordinalNumber(dateTime.dayOfYear),
        FormatterToken.DDDD: (DateTime dateTime) =>
            dateTime.dayOfYear.toString().padLeft(3, '0'),
        FormatterToken.d: (DateTime dateTime) => dateTime.weekday.toString(),
        FormatterToken.d_o: (DateTime dateTime) =>
            ordinalNumber(dateTime.weekday),
        FormatterToken.dd: (DateTime dateTime) =>
            weekdayName(dateTime.weekday).substring(0, 2),
        FormatterToken.ddd: (DateTime dateTime) =>
            weekdayName(dateTime.weekday).substring(0, 3),
        FormatterToken.dddd: (DateTime dateTime) =>
            weekdayName(dateTime.weekday),
        FormatterToken.e: (DateTime dateTime) => dateTime.weekday.toString(),
        FormatterToken.w: (DateTime dateTime) => dateTime.week.toString(),
        FormatterToken.wo: (DateTime dateTime) => ordinalNumber(dateTime.week),
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
            dateTime.hour < 12 ? "AM" : "PM",
        FormatterToken.a: (DateTime dateTime) =>
            dateTime.hour < 12 ? "am" : "pm",
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
            reformat(dateTime, "DD.MM.YYYY"),
        FormatterToken.l: (DateTime dateTime) => reformat(dateTime, "D.M.YYYY"),
        FormatterToken.LL: (DateTime dateTime) =>
            reformat(dateTime, "DD. MMMM YYYY"),
        FormatterToken.ll: (DateTime dateTime) =>
            reformat(dateTime, "D. MMM YYYY"),
        FormatterToken.LLL: (DateTime dateTime) =>
            reformat(dateTime, "DD. MMMM YYYY HH:mm"),
        FormatterToken.lll: (DateTime dateTime) =>
            reformat(dateTime, "D. MMM YYYY H:mm"),
        FormatterToken.LLLL: (DateTime dateTime) =>
            reformat(dateTime, "dddd, DD. MMMM YYYY HH:mm"),
        FormatterToken.llll: (DateTime dateTime) =>
            reformat(dateTime, "ddd, D. MMM YYYY H:mm"),
        FormatterToken.LT: (DateTime dateTime) => reformat(dateTime, "H:mm"),
        FormatterToken.LTS: (DateTime dateTime) =>
            reformat(dateTime, "H:mm:ss"),
      };

  @override
  String endonym() => "Deutsch";

  @override
  String languageCodeISO() => "de";

  @override
  String locale() => "de_DE";

  @override
  String languageNameInEnglish() => "German (Standard)";
}
