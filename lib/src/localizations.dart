import 'package:moment_dart/src/exception.dart';
import 'package:moment_dart/src/formatters/token.dart';
import 'package:moment_dart/src/moment.dart';

import 'calendar.dart';

extension _StringUtils on num {
  String padZero([int width = 2]) {
    return toString().padLeft(width, '0');
  }
}

enum RelativeInterval {
  //"(in) a few seconds (ago)"
  fewSeconds(0, unit: DurationUnit.second, singular: false),
  //"(in) a second (ago)"
  aSecond(1, unit: DurationUnit.second, singular: true),
  //"(in) X seconds (ago)"
  seconds(2, unit: DurationUnit.second, singular: false),
  //"(in) a minute (ago)"
  aMinute(3, unit: DurationUnit.minute, singular: true),
  //"(in) X minutes (ago)"
  minutes(4, unit: DurationUnit.minute, singular: false),
  //"(in) an hour (ago)"
  anHour(5, unit: DurationUnit.hour, singular: true),
  //"(in) X hours (ago)"
  hours(6, unit: DurationUnit.hour, singular: false),
  //"(in) a day (ago)"
  aDay(7, unit: DurationUnit.day, singular: true),
  //"(in) X days (ago)"
  days(8, unit: DurationUnit.day, singular: false),
  //"(in) a month (ago)"
  aMonth(9, unit: DurationUnit.month, singular: true),
  //"(in) X months (ago)"
  months(10, unit: DurationUnit.month, singular: false),
  //"(in) a year (ago)"
  aYear(11, unit: DurationUnit.year, singular: true),
  //"(in) X years (ago)"
  years(12, unit: DurationUnit.year, singular: false);

  final int value;
  final DurationUnit unit;
  final bool singular;

  const RelativeInterval(
    this.value, {
    required this.unit,
    this.singular = false,
  });
}

/// Extend this class to create new localization
abstract class MomentLocalization {
  MomentLocalization();

  static const int maxInt =
      (double.infinity is int) ? double.infinity as int : ~minInt;
  static const int minInt =
      (double.infinity is int) ? -double.infinity as int : (-1 << 63);

  /// Defined intervals' upper-limit has been stored as <String,Duration?> map. Null [Duration] value indicates last possible case.
  ///
  /// Used this table as guide:
  /// [https://momentjs.com/docs/#/displaying/fromnow/]
  static const Map<RelativeInterval, Duration?> _relativeThresholds = {
    RelativeInterval.fewSeconds: Duration(seconds: 45),
    RelativeInterval.aMinute: Duration(seconds: 90),
    RelativeInterval.minutes: Duration(minutes: 45),
    RelativeInterval.anHour: Duration(minutes: 90),
    RelativeInterval.hours: Duration(hours: 22),
    RelativeInterval.aDay: Duration(hours: 36),
    RelativeInterval.days: Duration(days: 26),
    RelativeInterval.aMonth: Duration(days: 45),
    RelativeInterval.months: Duration(days: 320),
    RelativeInterval.aYear: Duration(days: 548),
    RelativeInterval.years: null,
  };

  /// Uses [MomentLocalization._relativeThresholds] map. Refer to this table for details:
  /// [https://momentjs.com/docs/#/displaying/fromnow/]
  static RelativeInterval relativeThreshold(Duration duration) {
    final Duration absoluteDuration = duration.abs();

    for (RelativeInterval key in _relativeThresholds.keys) {
      final Duration? maxDuration = _relativeThresholds[key];

      if (maxDuration == null) return key;

      if (absoluteDuration < maxDuration) {
        return key;
      }
    }

    throw Exception("Something went wrong");
  }

  /// Toggle `dropPrefixOrSuffix` to get spanned duration without any prefix or suffix.
  ///
  /// **This will not return precise duration**, for precise durations, see [duration]
  ///
  /// Note: When creating your own localization, please take a look at [MomentLocalization.relativeThreshold] function and [MomentLocalization._relativeThresholds] before implementing. Those will make your life slightly easier
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]);

  /// This will return precise durations
  ///
  // String duration(Duration duration);

  /// Some language require article before the hours. e.g., la 1:20, las 13:20 (Spanish)
  String calendarTime(Moment moment) =>
      moment.format(localizationDefaultHourFormat);

  /// Calendar string
  String calendar(
      Moment moment,
      {Moment? reference,
      @Deprecated("This argument is deprecated. Currently unused.")
          bool weekStartOnSunday = false,
      int startOfWeek = DateTime.monday,
      bool omitHours = false,
      String? customFormat}) {
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

  final Map<FormatterToken, FormatterTokenFn?> defaultFormatters = {
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
    FormatterToken.YY:
        // TODO: this should be updated before 2031 hits
        (dateTime) {
      if (dateTime.year < 1970 || dateTime.year > 2030) {
        throw Exception("YY formatter only work in range [1970; 2030]");
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
      if (dateTime.year < 1970 || dateTime.year > 2030) {
        throw Exception("YY formatter only work in range [1970; 2030]");
      }
      return dateTime.weekYear.toString().substring(2);
    },
    FormatterToken.gggg: (dateTime) => dateTime.weekYear.toString(),
    FormatterToken.H: (dateTime) =>
        dateTime.hour == 0 ? "00" : dateTime.hour.toString(),
    FormatterToken.HH: (dateTime) => dateTime.hour.padZero(),
    FormatterToken.h: (dateTime) =>
        dateTime.hour == 0 ? "12" : "${dateTime.hour % 12}",
    FormatterToken.hh: (dateTime) =>
        dateTime.hour == 0 ? "12" : (dateTime.hour % 12).padZero(),
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
    FormatterToken.A: (dateTime) => dateTime.hour < 12 ? "AM" : "PM",
    FormatterToken.a: (dateTime) => dateTime.hour < 12 ? "am" : "pm",
  };

  Map<FormatterToken, FormatterTokenFn> get nonFinalFormatters => {
        FormatterToken.dd: (dateTime) =>
            weekdayName[dateTime.weekday]!.substring(0, 2),
        FormatterToken.ddd: (dateTime) =>
            weekdayName[dateTime.weekday]!.substring(0, 3),
        FormatterToken.dddd: (dateTime) => weekdayName[dateTime.weekday]!,
      };

  Map<FormatterToken, FormatterTokenFn?> overrideFormatters();
  Map<FormatterToken, FormatterTokenFn?> get formatters => {
        ...defaultFormatters,
        ...nonFinalFormatters,
        ...overrideFormatters(),
      };

  @Deprecated(
    'Use startOfWeek() instead. '
    'This feature was deprecated after 0.6.2',
  )
  static Moment weekFirstDay(Moment reference,
      [bool weekStartOnSunday = false]) {
    return weekStartOnSunday ? reference.lastSunday() : reference.lastMonday();
  }

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
  /// e.g.,
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

  /// Start of week. e.g., Monday for most countries, Sunday for weird ones
  int get weekStart => DateTime.monday;
}
