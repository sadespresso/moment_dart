import 'package:moment_dart/src/extension.dart';
export 'package:moment_dart/src/extension.dart';

import 'package:moment_dart/src/formatters/format_match.dart';
import 'package:moment_dart/src/formatters/token.dart';
import 'package:moment_dart/src/localizations.dart';
import 'package:moment_dart/src/localizations/all.dart';

/// Moment is a wrapper for [DateTime] class

class Moment implements Comparable<Moment> {
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

  factory Moment.fromMillisecondsSinceEpoch(
    int millisecondsSinceEpoch, {
    bool isUtc = false,
    MomentLocalization? localization,
  }) {
    return Moment(
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: isUtc),
      localization: localization,
    );
  }

  factory Moment.fromMicrosecondsSinceEpoch(
    int microsecondsSinceEpoch, {
    bool isUtc = false,
    MomentLocalization? localization,
  }) {
    return Moment(
      DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch, isUtc: isUtc),
      localization: localization,
    );
  }

  Moment copyWith({DateTime? dateTime, MomentLocalization? localization}) {
    final Moment value = Moment(
      dateTime ?? this.dateTime,
      localization: localization ?? _localization,
    );

    if (_enableDebugPrint) {
      value.enableDebugPrint();
    }

    return value;
  }

  Moment toLocal() => copyWith(dateTime: dateTime.toLocal());
  Moment toUtc() => copyWith(dateTime: dateTime.toUtc());

  Duration difference(Moment other) => dateTime.difference(other.dateTime);

  /// Adds the `duration` using `DateTime.add(duration)`
  Moment add(Duration duration) =>
      Moment(dateTime.add(duration), localization: _localization);

  /// Subtracts the `duration` using `DateTime.subtract(duration)`
  Moment subtract(Duration duration) =>
      Moment(dateTime.subtract(duration), localization: _localization);

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

    final RegExp escaper = RegExp(r"\[(([^\]]+))\]", multiLine: true);

    while (!halt) {
      if (payload.length > 1 && payload.trim()[0] == r"[") {
        final RegExpMatch? firstMatch = escaper.firstMatch(payload);

        if (firstMatch != null) {
          if (firstMatch.start != 0) {
            tokens.add(payload.substring(0, firstMatch.start));
          }
          tokens.add(firstMatch.group(1) ?? "");
          payload = payload.substring(firstMatch.end);
          continue;
        }
      }

      FormatMatch? closestToZero;

      for (FormatterToken token in _fts) {
        final int _matchIndex = payload.indexOf(token.name);

        if (_matchIndex == -1) continue;

        if (closestToZero != null) {
          if (_matchIndex > closestToZero.startIndex) {
            continue;
          } else if (_matchIndex == closestToZero.startIndex &&
              token.name.length < closestToZero.token.name.length) {
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
        print(
            "[Moment Dart] We found a match:\n$payload at index ${closestToZero.startIndex}\n${payload.substring(closestToZero.endIndex)} is new payload\n token: ${closestToZero.token}");
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
  Moment parse(String input) =>
      Moment(DateTime.parse(input), localization: _localization);

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
  String calendar(
          {Moment? reference,
          bool weekStartOnSunday = false,
          bool omitHours = false,
          String? customFormat}) =>
      _localization.calendar(this,
          reference: reference,
          weekStartOnSunday: weekStartOnSunday,
          omitHours: omitHours,
          customFormat: customFormat);

  bool isBefore(Moment other) => dateTime.isBefore(other.dateTime);
  bool isAfter(Moment other) => dateTime.isAfter(other.dateTime);
  bool isAtSameMomentAs(Moment other) =>
      dateTime.isAtSameMomentAs(other.dateTime);

  DateTime lastMondayAsDateTime() => DateTime(
      dateTime.year, dateTime.month, dateTime.day - (dateTime.weekday - 1));
  DateTime lastSundayAsDateTime() => DateTime(
      dateTime.year, dateTime.month, dateTime.day - (dateTime.weekday % 7));

  Moment lastMonday() =>
      Moment(lastMondayAsDateTime(), localization: _localization);
  Moment lastSunday() =>
      Moment(lastSundayAsDateTime(), localization: _localization);

  // DateTime getters
  bool get isUtc => dateTime.isUtc;
  int get year => dateTime.year;
  int get month => dateTime.month;
  int get day => dateTime.day;
  int get hour => dateTime.hour;
  int get minute => dateTime.minute;
  int get second => dateTime.second;
  int get millisecond => dateTime.millisecond;
  int get microsecond => dateTime.microsecond;
  int get weekday => dateTime.weekday;

  // Moment Benefits getters

  bool get isLeapYear => dateTime.isLeapYear;
  int get quarter => dateTime.quarter;
  int get week => dateTime.week;
  int get weekYear => dateTime.weekYear;
  int get dayOfYear => dateTime.dayOfYear;

  // Comparison functions

  /// Returns if two dates are in same year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameYearAs(Moment other) => dateTime.isAtSameYearAs(other.dateTime);

  /// Returns if two dates are in same month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameMonthAs(Moment other) =>
      dateTime.isAtSameMonthAs(other.dateTime);

  /// Returns if two dates are in same day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameDayAs(Moment other) => dateTime.isAtSameDayAs(other.dateTime);

  /// Returns if two dates are in same hour, day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameHourAs(Moment other) => dateTime.isAtSameHourAs(other.dateTime);

  /// Returns if two dates are in same minute, hour, day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameMinuteAs(Moment other) =>
      dateTime.isAtSameMinuteAs(other.dateTime);

  /// Returns if two dates are in same second, minute, hour, day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameSecondAs(Moment other) =>
      dateTime.isAtSameSecondAs(other.dateTime);

  /// Returns if two dates are in same millisecond, second, minute, hour, day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameMillisecondAs(Moment other) =>
      dateTime.isAtSameMillisecondAs(other.dateTime);

  /// Returns `this.isAtSameMomentAs(other)`
  bool isAtSameMicrosecondAs(Moment other) => isAtSameMomentAs(other);

  @override
  String toString() => format("LT");

  String toIso8601String() => dateTime.toIso8601String();

  @override
  int compareTo(Moment other) => dateTime.compareTo(other.dateTime);
}
