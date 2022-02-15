import 'package:moment_dart/src/formatters/token.dart';
import 'package:moment_dart/src/localizations.dart';
import 'package:moment_dart/src/localizations/en_US.dart';

typedef SingleFormatFn = String Function(String, Localization);

extension MomentBenefits on DateTime {
  bool get isLeapYear {
    if ((year & 3) == 0) return false;

    return year % 100 != 0 || year % 400 == 0;
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
    return ((month - 1) / 3).floor() + 1;
  }

  /// Returns [ISO week](https://en.wikipedia.org/wiki/ISO_week_date) number of the year
  ///
  /// [1, 2, 3, ..., 52, 53]
  int get week {
    final DateTime date = DateTime(year, month, day).add(Duration(days: day - (day + 3 - (weekday + 6) % 7)));
    final DateTime firstWeek = DateTime(year, 1, 4);

    final int delta = date.millisecondsSinceEpoch - firstWeek.millisecondsSinceEpoch;

    return ((delta / Duration(days: 1).inMilliseconds - 3 + (firstWeek.weekday + 6) % 7) / 7).round();
  }

  /// Returns year according to [ISO week](https://en.wikipedia.org/wiki/ISO_week_date) number of the year
  int get weekYear => DateTime(year, month, day).add(Duration(days: day - (day + 3 - (weekday + 6) % 7))).year;

  int get dayOfYear {
    const List<int> dayCount = [0, 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];

    int _dayOfYear = dayCount[month] + day;

    if (isLeapYear && month > 2) {
      _dayOfYear++;
    }

    return _dayOfYear;
  }

  String timeZoneFormatted([bool seperateWithColon = true]) {
    final int hours = timeZoneOffset.inMinutes ~/ 60;
    final int minutes = timeZoneOffset.inMinutes - (hours * 60);

    return (timeZoneOffset.isNegative ? "-" : "+") + hours.toString() + (seperateWithColon ? ":" : "") + minutes.toString();
  }
}

/// Moment is extension to the [DateTime] class

class Moment {
  late DateTime dateTime;
  late Localization _localization;

  /// Moment created using given `dateTime`;
  Moment(DateTime _dateTime, {Localization? localization}) {
    dateTime = _dateTime;

    _localization = localization ?? LocalizationEnUs();
  }

  /// Moment created using DateTime.now();
  Moment.now({Localization? localization}) {
    dateTime = DateTime.now();

    _localization = localization ?? LocalizationEnUs();
  }

  /// Adds the `duration` using `DateTime.add(duration)`
  Moment add(Duration duration) => Moment(dateTime.add(duration), localization: _localization);

  /// Subtracts the `duration` using `DateTime.subtract(duration)`
  Moment subtract(Duration duration) => Moment(dateTime.subtract(duration), localization: _localization);

  /// Calls `add(duration)`
  Moment operator +(Duration duration) => add(duration);

  /// Calls `subtract(duration)`
  Moment operator -(Duration duration) => subtract(duration);

  static const List<SingleFormatFn> formatters = [];

  String format(String payload) {
    String value = payload;

    for (FormatterToken token in _localization.tokens) {
      if (_localization.formats()[token] == null) {
        print("This token is not supported in the localization: '${token.name}'");
        continue;
      }
      value = value.replaceFirst(token.name, _localization.formats()[token]!(dateTime));
    }

    return value;
  }

  Moment parse({required String input, required String format}) {
    throw UnimplementedError();
  }

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

  /// It can't be static functions since it uses the [Localization]
  String from(Moment anchor, [bool dropSuffixOrPrefix = false]) {
    final Duration delta = dateTime.difference(anchor.dateTime);

    return _localization.relative(delta, dropSuffixOrPrefix);
  }

  /// Returns relative string, such as `Yesterday`, `Last Sunday`, or default date format concatenated with default hour format.
  ///
  /// You can omit the hours using [omitHours] argument.
  ///
  /// [reference] is `Moment.now()` by default.
  String calender({Moment? reference, bool weekStartOnSunday = false, bool omitHours = false}) => _localization.calendar(this, reference: reference, weekStartOnSunday: weekStartOnSunday, omitHours: omitHours);

  bool isBefore(Moment other) => dateTime.isBefore(other.dateTime);
  bool isAfter(Moment other) => dateTime.isAfter(other.dateTime);
  bool isAtSameMomentAs(Moment other) => dateTime.isAtSameMomentAs(other.dateTime);
  Duration difference(Moment other) => dateTime.difference(other.dateTime);

  DateTime lastMonday() => DateTime(dateTime.year, dateTime.month, dateTime.day - (dateTime.weekday - 1));
  DateTime lastSunday() => DateTime(dateTime.year, dateTime.month, dateTime.day - (dateTime.weekday % 7));

  Moment lastMondayMoment() => Moment(lastMonday(), localization: _localization);
  Moment lastSundayMoment() => Moment(lastSunday(), localization: _localization);

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
