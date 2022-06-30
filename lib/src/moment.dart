export 'package:moment_dart/src/extension.dart';

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/formatters/format_match.dart';

/// Moment is subclass of DateTime
class Moment extends DateTime {
  bool _enableDebugPrint = false;

  late MomentLocalization _localization;

  MomentLocalization get localization => _localization;

  /// Falls back to English (United States) if [newLocalization] is null
  set localization(MomentLocalization? newLocalization) {
    _localization = newLocalization ?? MomentLocalizations.enUS();
  }

  /// Moment created using given `dateTime`;
  Moment(DateTime dateTime, {MomentLocalization? localization})
      : super.fromMicrosecondsSinceEpoch(dateTime.microsecondsSinceEpoch,
            isUtc: dateTime.isUtc) {
    this.localization = localization;
  }

  /// Moment created using DateTime.now();
  Moment.now({MomentLocalization? localization}) : super.now() {
    this.localization = localization;
  }

  Moment.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch,
      {bool isUtc = false, MomentLocalization? localization})
      : super.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: isUtc) {
    this.localization = localization;
  }

  Moment.fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch,
      {bool isUtc = false, MomentLocalization? localization})
      : super.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch, isUtc: isUtc) {
    this.localization = localization;
  }

  @Deprecated(
    'Use localization setter '
    'or create new instance instead. '
    'Starting from 7.0, Moment extends DateTime. Therefore, only changeable field is _localization',
  )
  Moment copyWith({DateTime? dateTime, MomentLocalization? localization}) {
    final Moment value = Moment(
      dateTime ?? this,
      localization: localization ?? _localization,
    );

    if (_enableDebugPrint) {
      value.enableDebugPrint();
    }

    return value;
  }

  /// Adds the `duration` using `DateTime.add(duration)`
  @override
  Moment add(Duration duration) =>
      Moment(super.add(duration), localization: localization);

  /// Subtracts the `duration` using `DateTime.subtract(duration)`
  @override
  Moment subtract(Duration duration) =>
      Moment(super.subtract(duration), localization: localization);

  /// Calls `add(duration)`
  Moment operator +(Duration duration) => add(duration);

  /// Calls `subtract(duration)`
  Moment operator -(Duration duration) => subtract(duration);

  enableDebugPrint() {
    _enableDebugPrint = true;
  }

  List<FormatterToken> get _fts => localization.tokens;

  String format([String payload = "l"]) {
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
        value += localization.formats()[token.token]!(this);
      } else {
        value += token as String;
      }
    }

    return value;
  }

  /// Uses [DateTime.parse]
  ///
  /// To be updated.
  static Moment parse(String input, {MomentLocalization? localization}) =>
      Moment(DateTime.parse(input), localization: localization);

  /// Example when using [LocalizationEnUs]:
  ///
  /// If [this] is yesterday, will result `"a day ago"`
  ///
  /// If [this] is tomorrow, will result `"in a day"`
  ///
  /// moment.js's `toNow()` function has been omitted, since this function prefixes/suffixes appropriately.
  String fromNow([bool dropSuffixOrPrefix = false]) {
    final Duration delta = difference(DateTime.now());

    return localization.relative(delta, dropSuffixOrPrefix);
  }

  /// It can't be static functions since it uses the [MomentLocalization]
  String from(Moment anchor, [bool dropSuffixOrPrefix = false]) {
    final Duration delta = difference(anchor);

    return localization.relative(delta, dropSuffixOrPrefix);
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
      localization.calendar(this,
          reference: reference,
          weekStartOnSunday: weekStartOnSunday,
          omitHours: omitHours,
          customFormat: customFormat);

  /// Returns new [Moment] instance of nearest `n`th weekday in the future
  ///
  /// If `n`th day is today, will return `7 days in the future`.
  Moment nextWeekday(int weekday) =>
      Moment(_forcedDateTimeType.nextWeekday(weekday),
          localization: localization);

  /// Return new [Moment] instance of nearest Monday in the Future
  ///
  /// If [this] is Monday, will return `7 days in the future`
  Moment nextMonday() => nextWeekday(DateTime.monday);

  /// Return new [Moment] instance of nearest Tuesday in the Future
  ///
  /// If [this] is Tuesday, will return `7 days in the future`
  Moment nextTuesday() => nextWeekday(DateTime.tuesday);

  /// Return new [Moment] instance of nearest Wednesday in the Future
  ///
  /// If [this] is Wednesday, will return `7 days in the future`
  Moment nextWednesday() => nextWeekday(DateTime.wednesday);

  /// Return new [Moment] instance of nearest Thursday in the Future
  ///
  /// If [this] is Thursday, will return `7 days in the future`
  Moment nextThursday() => nextWeekday(DateTime.thursday);

  /// Return new [Moment] instance of nearest Friday in the Future
  ///
  /// If [this] is Friday, will return `7 days in the future`
  Moment nextFriday() => nextWeekday(DateTime.friday);

  /// Return new [Moment] instance of nearest Saturday in the Future
  ///
  /// If [this] is Saturday, will return `7 days in the future`
  Moment nextSaturday() => nextWeekday(DateTime.saturday);

  /// Return new [Moment] instance of nearest Sunday in the Future
  ///
  /// If [this] is Sunday, will return `7 days in the future`
  Moment nextSunday() => nextWeekday(DateTime.sunday);

  /// Returns new [Moment] instance of last `n`th weekday
  ///
  /// If today is the `n`th day, will return `7 days in the past`
  Moment lastWeekday(int weekday) =>
      Moment(_forcedDateTimeType.lastWeekday(weekday),
          localization: localization);

  /// Return new [Moment] instance of nearest Monday in the past
  ///
  /// If [this] is Monday, will return `7 days in the past`
  Moment lastMonday() => lastWeekday(DateTime.monday);

  /// Return new [Moment] instance of nearest Tuesday in the past
  ///
  /// If [this] is Tuesday, will return `7 days in the past`
  Moment lastTuesday() => lastWeekday(DateTime.tuesday);

  /// Return new [Moment] instance of nearest Wednesday in the past
  ///
  /// If [this] is Wednesday, will return `7 days in the past`
  Moment lastWednesday() => lastWeekday(DateTime.wednesday);

  /// Return new [Moment] instance of nearest Thursday in the past
  ///
  /// If [this] is Thursday, will return `7 days in the past`
  Moment lastThursday() => lastWeekday(DateTime.thursday);

  /// Return new [Moment] instance of nearest Friday in the past
  ///
  /// If [this] is Friday, will return `7 days in the past`
  Moment lastFriday() => lastWeekday(DateTime.friday);

  /// Return new [Moment] instance of nearest Saturday in the past
  ///
  /// If [this] is Saturday, will return `7 days in the past`
  Moment lastSaturday() => lastWeekday(DateTime.saturday);

  /// Return new [Moment] instance of nearest Sunday in the past
  ///
  /// If [this] is Sunday, will return `7 days in the past`
  Moment lastSunday() => lastWeekday(DateTime.sunday);

  /// ⚠️ Only works on DateTime of local time zone
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  ///
  /// Will throw if [unit] is [DurationUnit.microsecond]
  Moment startOf(DurationUnit unit) =>
      Moment(_forcedDateTimeType.startOf(unit), localization: localization);

  /// Returns start of the millisecond
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment startOfMillisecond() =>
      Moment(_forcedDateTimeType.startOf(DurationUnit.millisecond),
          localization: localization);

  /// Returns start of the second
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment startOfSecond() =>
      Moment(_forcedDateTimeType.startOf(DurationUnit.second),
          localization: localization);

  /// Returns start of the minute
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment startOfMinute() =>
      Moment(_forcedDateTimeType.startOf(DurationUnit.minute),
          localization: localization);

  /// Returns start of the hour
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment startOfHour() => Moment(_forcedDateTimeType.startOf(DurationUnit.hour),
      localization: localization);

  /// Returns start of the day
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment startOfDay() => Moment(_forcedDateTimeType.startOf(DurationUnit.day),
      localization: localization);

  /// Returns start of the month
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment startOfMonth() =>
      Moment(_forcedDateTimeType.startOf(DurationUnit.month),
          localization: localization);

  /// Returns start of the year
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment startOfYear() => Moment(_forcedDateTimeType.startOf(DurationUnit.year),
      localization: localization);

  @override
  Moment toUtc() => Moment(super.toUtc(), localization: localization);
  @override
  Moment toLocal() => Moment(super.toLocal(), localization: localization);

  /// Returns "LLL" formatted string
  @override
  String toString() => format("LLL");

  String timeZoneFormatted([bool seperateWithColon = true]) {
    final int hours = timeZoneOffset.inMinutes ~/ 60;
    final int minutes = timeZoneOffset.inMinutes - (hours * 60);

    return (timeZoneOffset.isNegative ? "-" : "+") +
        hours.toString() +
        (seperateWithColon ? ":" : "") +
        minutes.toString();
  }

  @Deprecated(
    'Use lastMonday() instead. '
    'This feature was deprecated after 0.6.2',
  )

  /// Please use lastMonday()
  DateTime lastMondayAsDateTime() => lastMonday();
  @Deprecated(
    'Use lastSunday() instead. '
    'This feature was deprecated after 0.6.2',
  )
  DateTime lastSundayAsDateTime() => lastSunday();

  DateTime get _forcedDateTimeType => this;
}
