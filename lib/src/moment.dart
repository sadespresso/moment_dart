import 'package:moment_dart/src/formatters/token.dart';
import 'package:moment_dart/src/localizations.dart';
import 'package:moment_dart/src/localizations/en_US.dart';

typedef SingleFormatFn = String Function(String, Localization);

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
    final String value = payload;

    for (FormatterToken token in _localization.tokens) {
      value.replaceFirst(token.name, _localization.formats()[token]!(dateTime));
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
  /// moment.js's `toNow()` function has been omitted, since this function prefix/suffixes appropriately.
  String fromNow([bool dropSuffixOrPrefix = false]) {
    final Duration delta = dateTime.difference(DateTime.now());

    return _localization.relative(delta, dropSuffixOrPrefix);
  }

  String calender() => _localization.calendar(this);

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
}
