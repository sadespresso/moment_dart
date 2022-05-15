import 'package:moment_dart/src/formatters/format_match.dart';
import 'package:moment_dart/src/formatters/token.dart';
import 'package:moment_dart/src/localizations.dart';
import 'package:moment_dart/src/localizations/all.dart';

extension MomentBenefits on DateTime {
  bool get isLeapYear {
    if (year & 3 == 0) {
      if (year % 400 == 0) {
        return true;
      } else if (year % 100 == 0) {
        return false;
      }

      return true;
    }

    return false;
  }

  /// Returns quarter of the year.
  ///
  /// Jan,Feb,Mar is Q1
  ///
  /// Apr,May,Jun is Q2
  ///
  /// Jul,Aug,Sep is Q3
  ///
  /// Oct,Nov,Dec is Q4
  int get quarter {
    return (month - 1) ~/ 3 + 1;
  }

  int get _isoWeekRaw => (10 + dayOfYear - weekday) ~/ 7;

  bool get _isoWeekInNextYear => DateTime(year, 1, 1).weekday != DateTime.thursday && DateTime(year, 12, 31).weekday != DateTime.thursday;

  /// Returns [ISO week](https://en.wikipedia.org/wiki/ISO_week_date) number of the year
  ///
  /// [1, 2, 3, ..., 52, 53]
  int get week {
    final int w = _isoWeekRaw;

    // Last year may have 52 or 53 weeks, we shall check
    //
    // Dec 28 is always in the last week
    if (w == 0) {
      return DateTime(year - 1, 12, 28).week;
    }

    // It might actually be [Week 1] in the next year
    if (w == 53 && _isoWeekInNextYear) {
      return 1;
    }

    return w;
  }

  /// Returns year according to [ISO week](https://en.wikipedia.org/wiki/ISO_week_date) number of the year
  int get weekYear {
    final int w = _isoWeekRaw;

    if (w == 0) return year - 1;

    if (w == 53 && _isoWeekInNextYear) {
      return year + 1;
    }

    return year;
  }

  /// Returns ordinal day of the year
  ///
  /// [1,2,3,...,365,366]
  int get dayOfYear {
    const List<int> dayCount = [0, 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];

    int _dayOfYear = dayCount[month] + day;

    if (isLeapYear && month > 2) {
      return _dayOfYear + 1;
    }

    return _dayOfYear;
  }

  String timeZoneFormatted([bool seperateWithColon = true]) {
    final int hours = timeZoneOffset.inMinutes ~/ 60;
    final int minutes = timeZoneOffset.inMinutes - (hours * 60);

    return (timeZoneOffset.isNegative ? "-" : "+") + hours.toString() + (seperateWithColon ? ":" : "") + minutes.toString();
  }

  Moment toMoment({MomentLocalization? localization}) => Moment(this, localization: localization);
}

/// Moment is a wrapper for [DateTime] class

class Moment {
  bool _enableDebugPrint = false;

  late DateTime dateTime;
  late MomentLocalization _localization;

  MomentLocalization get localization => _localization;

  /// Moment created using given `dateTime`;
  Moment(DateTime _dateTime, {MomentLocalization? localization}) {
    dateTime = _dateTime;

    _localization = localization ?? MomentLocalizations.enUS();
  }

  /// Moment created using DateTime.now();
  Moment.now({MomentLocalization? localization}) {
    dateTime = DateTime.now();

    _localization = localization ?? MomentLocalizations.enUS();
  }

  /// Adds the `duration` using `DateTime.add(duration)`
  Moment add(Duration duration) => Moment(dateTime.add(duration), localization: _localization);

  /// Subtracts the `duration` using `DateTime.subtract(duration)`
  Moment subtract(Duration duration) => Moment(dateTime.subtract(duration), localization: _localization);

  /// Calls `add(duration)`
  Moment operator +(Duration duration) => add(duration);

  /// Calls `subtract(duration)`
  Moment operator -(Duration duration) => subtract(duration);

  enableDebugPrint() {
    _enableDebugPrint = true;
  }

  List<FormatterToken> get _fts => _localization.tokens;

  String format(String payload) {
    final List<dynamic> tokens = [];

    bool halt = false;

    while (!halt) {
      FormatMatch? closestToZero;

      for (FormatterToken token in _fts) {
        final int _matchIndex = payload.indexOf(token.name);

        if (_matchIndex == -1) continue;

        if (closestToZero != null) {
          if (_matchIndex > closestToZero.startIndex) {
            continue;
          } else if (_matchIndex == closestToZero.startIndex && token.name.length < closestToZero.token.name.length) {
            continue;
          }
        }

        closestToZero = FormatMatch(startIndex: _matchIndex, token: token);
      }

      if (closestToZero == null) break;

      if (closestToZero.startIndex != 0) {
        tokens.add(payload.substring(0, closestToZero.startIndex));
      }

      tokens.add(closestToZero);

      if (_enableDebugPrint) {
        print("[Moment Dart] We found a match:\n$payload at index ${closestToZero.startIndex}\n${payload.substring(closestToZero.endIndex)} is new payload\n token: ${closestToZero.token}");
      }

      payload = payload.substring(closestToZero.endIndex);

      if (payload.isEmpty) {
        halt = true;
      }
    }

    String value = "";

    for (var token in tokens) {
      if (token is FormatMatch) {
        value += _localization.formats()[token.token]!(dateTime);
      } else {
        value += token as String;
      }
    }

    return value;
  }

  /// Uses [DateTime.parse]
  ///
  /// To be updated.
  Moment parse(String input) => Moment(DateTime.parse(input), localization: _localization);

  /// Example when using [LocalizationEnUs]:
  ///
  /// If [this] is yesterday, will result `"a day ago"`
  ///
  /// If [this] is tomorrow, will result `"in a day"`
  ///
  /// moment.js's `toNow()` function has been omitted, since this function prefixes/suffixes appropriately.
  String fromNow([bool dropSuffixOrPrefix = false]) {
    final Duration delta = dateTime.difference(DateTime.now());

    return _localization.relative(delta, dropSuffixOrPrefix);
  }

  /// It can't be static functions since it uses the [MomentLocalization]
  String from(Moment anchor, [bool dropSuffixOrPrefix = false]) {
    final Duration delta = dateTime.difference(anchor.dateTime);

    return _localization.relative(delta, dropSuffixOrPrefix);
  }

  /// Returns calendar string in accordance with the [reference], such as `Yesterday`, `Last Sunday`, or default date format concatenated with default hour format.
  /// Default formats are derived from the current localization.
  ///
  /// [reference] is `Moment.now()` by default.
  ///
  /// You can omit the hours using [omitHours] argument.
  ///
  /// You can provide [customFormat]. Which will be used when the date is too far. e.g. when the moment is month away from referene, it'll use the [customFormat]
  ///
  /// Using [customFormat] will make [omitHours] ineffective.
  String calendar({Moment? reference, bool weekStartOnSunday = false, bool omitHours = false, String? customFormat}) => _localization.calendar(this, reference: reference, weekStartOnSunday: weekStartOnSunday, omitHours: omitHours, customFormat: customFormat);

  bool isBefore(Moment other) => dateTime.isBefore(other.dateTime);
  bool isAfter(Moment other) => dateTime.isAfter(other.dateTime);
  bool isAtSameMomentAs(Moment other) => dateTime.isAtSameMomentAs(other.dateTime);
  Duration difference(Moment other) => dateTime.difference(other.dateTime);

  DateTime lastMondayAsDateTime() => DateTime(dateTime.year, dateTime.month, dateTime.day - (dateTime.weekday - 1));
  DateTime lastSundayAsDateTime() => DateTime(dateTime.year, dateTime.month, dateTime.day - (dateTime.weekday % 7));

  Moment lastMonday() => Moment(lastMondayAsDateTime(), localization: _localization);
  Moment lastSunday() => Moment(lastSundayAsDateTime(), localization: _localization);

  int get year => dateTime.year;
  int get month => dateTime.month;
  int get day => dateTime.day;
  int get hour => dateTime.hour;
  int get minute => dateTime.minute;
  int get second => dateTime.second;
  int get millisecond => dateTime.millisecond;
  int get microsecond => dateTime.microsecond;
  int get weekday => dateTime.weekday;

  bool get isUtc => dateTime.isUtc;
}
