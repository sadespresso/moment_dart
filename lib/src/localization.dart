import 'package:moment_dart/src/exception.dart';
export 'package:moment_dart/src/exception.dart';

import 'package:moment_dart/src/formatters/token.dart';
export 'package:moment_dart/src/formatters/token.dart';

import 'package:moment_dart/src/localizations/utils/duration_format.dart';
export 'package:moment_dart/src/localizations/utils/duration_format.dart';

import 'package:moment_dart/src/localizations/utils/relative_interval.dart';
export 'package:moment_dart/src/localizations/utils/relative_interval.dart';

import 'package:moment_dart/src/localizations/utils/unit_form.dart';
export 'package:moment_dart/src/localizations/utils/unit_form.dart';

import 'package:moment_dart/src/calendar.dart';
export 'package:moment_dart/src/calendar.dart';

import 'package:moment_dart/src/moment.dart';
import 'package:moment_dart/src/types.dart';

/// Extend this class to create new localization
abstract class MomentLocalization {
  static const int maxInt =
      (double.infinity is int) ? double.infinity as int : ~minInt;
  static const int minInt =
      (double.infinity is int) ? -double.infinity as int : (-1 << 63);

  /// Defined intervals' upper-limit has been stored as <String,Duration?> map. Null [Duration] value indicates last possible case.
  ///
  /// Used this table as guide:
  /// [https://momentjs.com/docs/#/displaying/fromnow/]
  static const Map<DurationInterval, Duration?> _relativeThresholds = {
    DurationInterval.lessThanASecond: Duration(seconds: 45),
    DurationInterval.aMinute: Duration(seconds: 90),
    DurationInterval.minutes: Duration(minutes: 45),
    DurationInterval.anHour: Duration(minutes: 90),
    DurationInterval.hours: Duration(hours: 22),
    DurationInterval.aDay: Duration(hours: 36),
    DurationInterval.days: Duration(days: 26),
    DurationInterval.aMonth: Duration(days: 45),
    DurationInterval.months: Duration(days: 320),
    DurationInterval.aYear: Duration(days: 548),
    DurationInterval.years: null,
  };

  /// Uses [MomentLocalization._relativeThresholds] map. Refer to this table for details:
  /// [https://momentjs.com/docs/#/displaying/fromnow/]
  static DurationInterval relativeThreshold(Duration duration) {
    final Duration absoluteDuration = duration.abs();

    for (DurationInterval key in _relativeThresholds.keys) {
      final Duration? maxDuration = _relativeThresholds[key];

      if (maxDuration == null) return key;

      if (absoluteDuration < maxDuration) {
        return key;
      }
    }

    throw MomentException("Something went wrong");
  }

  /// Toggle `dropPrefixOrSuffix` to get spanned duration without any prefix or suffix.
  ///
  /// **This will not return precise duration**, for precise durations, use [duration()]
  ///
  /// Note: When creating your own localization, please take a look at [MomentLocalization.relativeThreshold] function and [MomentLocalization._relativeThresholds] before implementing. Those will make your life slightly easier
  ///
  /// [form] - Unit string form. For example, minute would look like "18 minutes ago", "18 min ago", "18m ago" in full, mid, short forms, respectively.
  String relative(
    Duration duration, {
    bool dropPrefixOrSuffix = false,
    UnitStringForm form = UnitStringForm.full,
  });

  /// This will return **precise** durations. For imprecise durations, use [relative()]
  ///
  /// e.g.:
  /// * 2 minutes 39 seconds
  /// * 2m39s
  ///
  /// Params:
  ///
  /// * [format] - format to display the duration. For example, when set to `DurationFormat.md`, will result to "3 months 2 days"
  /// * [delimiter] - string to join duration when there are more than one. Defaults to **space**. For example,
  /// * [form] - Unit string form. For example, minute would look like "18 minutes", "18 min", "18m" in full, mid, short forms, respectively.
  /// * [round] - rounds the smallest unit if set true. If false, truncates. Defaults to true.
  /// * [omitZeros] - unit will be omitted if equal to zero. For example, `DurationFormat.md` may return "3 months", but not "3 months 0 days"
  /// * [includeWeeks] - Whether `week` should be treated as duration unit. Only applicable when using [DurationFormat.auto]
  /// * [dropPrefixOrSuffix] - Whether to drop suffix/prefix. For example, "3h 2m ago" => "3h 2m", "in 7 days" => "7 days"
  String duration(
    Duration duration, {
    bool round = true,
    bool omitZeros = true,
    bool includeWeeks = false,
    UnitStringForm form = UnitStringForm.full,
    String? delimiter,
    DurationFormat format = DurationFormat.auto,
    bool dropPrefixOrSuffix = false,
  });

  /// Some language require article before the hours. For example, la 1:20, las 13:20 (Spanish)
  String calendarTime(Moment moment) =>
      moment.format(localizationDefaultHourFormat);

  /// Calendar string
  String calendar(
    Moment moment, {
    Moment? reference,
    int startOfWeek = DateTime.monday,
    String? customFormat,
    bool omitHours = false,
    bool omitHoursIfDistant = true,
  }) {
    // After this check, we can use `_calendarData` for non-null data
    if (calendarData == null) {
      throw MomentException(
          "Moment.calendar() for this localization $locale ($endonym) must be overriden since [calendarData] is null");
    }

    reference ??= Moment.now();

    late final String dateString;

    final int deltaDays = moment.differenceInDays(reference);
    final String? deltaDaysName = _calendarData.relativeDayNames[deltaDays];

    if (deltaDaysName != null) {
      dateString = deltaDaysName;
    } else {
      /// If it occured before [reference]
      if (moment < reference) {
        final Moment weekBefore = reference.subtract(const Duration(days: 7));

        if (moment.isBefore(weekBefore)) {
          if (omitHoursIfDistant) {
            omitHours = true;
          }
          dateString =
              moment.format(customFormat ?? localizationDefaultDateFormat);
        } else {
          dateString =
              _calendarData.keywords.lastWeekday(weekdayName[moment.weekday]!);
        }
      }

      /// If it occured after [reference]
      else {
        final Moment weekAfter = reference.add(const Duration(days: 7));

        /// If it's this or next week (relative to the reference)
        if (moment.isBefore(weekAfter)) {
          dateString = weekdayName[moment.weekday]!;
        } else {
          if (omitHoursIfDistant) {
            omitHours = true;
          }
          dateString =
              moment.format(customFormat ?? localizationDefaultDateFormat);
        }
      }
    }

    if (customFormat != null) return dateString;

    if (omitHours) {
      return dateString;
    }

    return _calendarData.keywords.at(
      dateString,
      calendarTime(moment),
    );
  }

  final FormatSetOptional defaultFormatters = {
    FormatterToken.M: (dateTime) => dateTime.month.toString(),
    FormatterToken.MM: (dateTime) => dateTime.month.toString().padLeft(2, '0'),
    FormatterToken.Q: (dateTime) => dateTime.quarter.toString(),
    FormatterToken.D: (dateTime) => dateTime.day.toString(),
    FormatterToken.DD: (dateTime) => dateTime.day.padZero(),
    FormatterToken.DDD: (dateTime) => dateTime.dayOfYear.toString(),
    FormatterToken.DDDD: (dateTime) => dateTime.dayOfYear.padZero(3),
    FormatterToken.d: (dateTime) => dateTime.weekday.toString(),
    FormatterToken.e: (dateTime) => dateTime.weekday.toString(),
    FormatterToken.w: (dateTime) => dateTime.week.toString(),
    FormatterToken.ww: (dateTime) => dateTime.week.padZero(),
    FormatterToken.YY: (dateTime) {
      if (dateTime.year < 1970 || dateTime.year > 2030) {
        return dateTime.year.toString();
      }
      return dateTime.year.toString().substring(2);
    },
    FormatterToken.YYYY: (dateTime) => dateTime.year.toString(),

    FormatterToken.y: (dateTime) => dateTime.year.abs().toString(),
    FormatterToken.NN: (dateTime) => dateTime.year < 1 ? "B.C." : "A.D.",
    FormatterToken.NNNN: (dateTime) =>
        dateTime.year < 1 ? "Before Christ" : "Anno Domini",
    FormatterToken.NNNNN: (dateTime) => dateTime.year < 1 ? "BC" : "AD",

    FormatterToken.gg: (dateTime) {
      if (dateTime.weekYear < 1970 || dateTime.weekYear > 2030) {
        return dateTime.weekYear.toString();
      }
      return dateTime.weekYear.toString().substring(2);
    },
    FormatterToken.gggg: (dateTime) => dateTime.weekYear.toString(),
    FormatterToken.H: (dateTime) => dateTime.hour.toString(),
    FormatterToken.HH: (dateTime) => dateTime.hour.padZero(),
    FormatterToken.h: (dateTime) => dateTime.hour12.toString(),
    FormatterToken.hh: (dateTime) => dateTime.hour12.padZero(),
    FormatterToken.k: (dateTime) =>
        dateTime.hour == 0 ? "24" : dateTime.hour.toString(),
    FormatterToken.kk: (dateTime) =>
        dateTime.hour == 0 ? "24" : dateTime.hour.padZero(),
    FormatterToken.m: (dateTime) => dateTime.minute.toString(),
    FormatterToken.mm: (dateTime) => dateTime.minute.padZero(),
    FormatterToken.s: (dateTime) => dateTime.second.toString(),
    FormatterToken.ss: (dateTime) => dateTime.second.padZero(),
    FormatterToken.S: (dateTime) => (dateTime.millisecond ~/ 100).toString(),
    FormatterToken.SS: (dateTime) => (dateTime.millisecond ~/ 10).padZero(),
    FormatterToken.SSS: (dateTime) => dateTime.millisecond.padZero(3),
    FormatterToken.SSSS: (dateTime) =>
        dateTime.millisecond.padZero(3) +
        (dateTime.microsecond ~/ 100).toString(),
    FormatterToken.SSSSS: (dateTime) =>
        dateTime.millisecond.padZero(3) +
        (dateTime.microsecond ~/ 10).padZero(),
    FormatterToken.SSSSSS: (dateTime) =>
        dateTime.millisecond.padZero(3) + (dateTime.microsecond).padZero(3),
    FormatterToken.Z: (dateTime) => dateTime.timeZoneFormatted(),
    FormatterToken.ZZ: (dateTime) => dateTime.timeZoneFormatted(false),
    FormatterToken.ZZZ: (dateTime) => dateTime.timeZoneName,
    FormatterToken.X: (dateTime) =>
        (dateTime.millisecondsSinceEpoch ~/ 1000).toString(),
    FormatterToken.x: (dateTime) => dateTime.millisecondsSinceEpoch.toString(),
    FormatterToken.xx: (dateTime) => dateTime.microsecondsSinceEpoch.toString(),

    // Fallbacks when unimplemented

    FormatterToken.Mo: (dateTime) => "Month #${dateTime.month} (ordered)",
    FormatterToken.MMM: (dateTime) => "Month #${dateTime.month}",
    FormatterToken.MMMM: (dateTime) => "Month #${dateTime.month}",
    FormatterToken.Qo: (dateTime) => "Q${dateTime.quarter} (ordered)",
    FormatterToken.Do: (dateTime) => "Day ${dateTime.day} of the month",
    FormatterToken.DDDo: (dateTime) =>
        "Day ${dateTime.day} of the year (ordered)",
    FormatterToken.d_o: (dateTime) =>
        "Day #${dateTime.weekday} of the week (ordered)",
    FormatterToken.dd: (dateTime) => "Day #${dateTime.weekday} of the week",
    FormatterToken.ddd: (dateTime) => "Day #${dateTime.weekday} of the week",
    FormatterToken.dddd: (dateTime) => "Day #${dateTime.weekday} of the week",
    FormatterToken.wo: (dateTime) => "Week #${dateTime.week} of the year (ISO)",
    FormatterToken.A: (dateTime) => dateTime.isAm ? "AM" : "PM",
    FormatterToken.a: (dateTime) => dateTime.isAm ? "am" : "pm",
  };

  Map<FormatterToken, FormatterTokenFn> get nonFinalFormatters => {
        FormatterToken.dd: (dateTime) =>
            weekdayName[dateTime.weekday]!.substring(0, 2),
        FormatterToken.ddd: (dateTime) =>
            weekdayName[dateTime.weekday]!.substring(0, 3),
        FormatterToken.dddd: (dateTime) => weekdayName[dateTime.weekday]!,
      };

  FormatSetOptional overrideFormatters();
  FormatSetOptional get formatters => {
        ...defaultFormatters,
        ...nonFinalFormatters,
        ...overrideFormatters(),
      };

  static Moment startOfWeek(Moment refernce,
          [int startingWeekday = DateTime.monday]) =>
      refernce.lastWeekday(startingWeekday);

  final List<FormatterToken> tokens = [...FormatterToken.values]
    ..sort((a, b) => b.toString().length.compareTo(a.toString().length));

  static const String localizationDefaultDateFormat = "l";
  static const String localizationDefaultHourFormat = "LT";

  String reformat(DateTime dateTime, String payload) =>
      Moment(dateTime, localization: this).format(payload);

  CalenderLocalizationData? get calendarData;
  // Forced non-null type
  CalenderLocalizationData get _calendarData => calendarData!;

  /// Weekdays range from 1-7
  Map<int, String> get weekdayName;

  /// Language code defined in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1)
  String get languageCode;

  /// Language name in the language itself
  ///
  /// For example,
  /// * Français (in English - French)
  /// * Italiano (in English - Italian)
  /// * ᠮᠣᠩᠭᠤᠯ ᠬᠯᠡ (in English - Mongolian)
  String get endonym;

  /// Country code as defined in [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)
  String? get countryCode;

  /// Locale ID
  ///
  /// See [Unicode Language Identifier](https://www.unicode.org/reports/tr35/#Unicode_language_identifier) for more info
  String get locale {
    if (countryCode == null) {
      return languageCode;
    }

    return "${languageCode}_$countryCode";
  }

  /// Language name in English
  String get languageNameInEnglish;

  /// Start of week. For example, Monday for most countries, Sunday for weird ones
  int get weekStart => DateTime.monday;
}

extension _StringUtils on num {
  String padZero([int width = 2]) {
    return toString().padLeft(width, '0');
  }
}
