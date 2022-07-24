export 'package:moment_dart/src/extension.dart';

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/formatters/format_match.dart';

/// Moment is subclass of DateTime
class Moment extends DateTime {
  late MomentLocalization _localization;

  MomentLocalization get localization => _localization;

  /// Falls back to English (United States) if [newLocalization] is null
  set localization(MomentLocalization? newLocalization) {
    _localization = newLocalization ?? MomentLocalizations.enUS();
  }

  void setLocalization(MomentLocalization? newLocalization) {
    _localization = newLocalization ?? MomentLocalizations.enUS();
  }

  /// Moment created using given `dateTime`;
  Moment(DateTime dateTime, {MomentLocalization? localization})
      : super.fromMicrosecondsSinceEpoch(dateTime.microsecondsSinceEpoch,
            isUtc: dateTime.isUtc) {
    this.localization = localization;
  }

  /// An instance created using DateTime.now(), in Local timezone
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
    'Starting from 7.0, Moment extends DateTime. Therefore, only mutable field is _localization',
  )
  Moment copyWith({DateTime? dateTime, MomentLocalization? localization}) {
    final Moment value = Moment(
      dateTime ?? this,
      localization: localization ?? _localization,
    );

    return value;
  }

  /// Returns new [Moment] instance with added duration
  ///
  /// Adds the `duration` using `DateTime.add(duration)`
  @override
  Moment add(Duration duration) =>
      Moment(super.add(duration), localization: localization);

  /// Returns new [Moment] instance with subtracted duration
  ///
  /// Subtracts the `duration` using `DateTime.subtract(duration)`
  @override
  Moment subtract(Duration duration) =>
      Moment(super.subtract(duration), localization: localization);

  /// Returns new [Moment] instance with added duration
  ///
  /// Calls `add(duration)`
  Moment operator +(Duration duration) => add(duration);

  /// Returns new [Moment] instance with subtracted duration
  ///
  /// Calls `subtract(duration)`
  Moment operator -(Duration duration) => subtract(duration);

  @Deprecated(
      "Moment no longer prints anything to stdout. This function does nothing as of version 0.8.0")
  enableDebugPrint() {}

  List<FormatterToken> get _fts => localization.tokens;

  String format(
      [String payload = MomentLocalization.localizationDefaultDateFormat]) {
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
        final int matchIndex = payload.indexOf(token.name);

        if (matchIndex == -1) continue;

        if (closestToZero != null) {
          if (matchIndex > closestToZero.startIndex) {
            continue;
          } else if (matchIndex == closestToZero.startIndex &&
              token.name.length < closestToZero.token.name.length) {
            continue;
          }
        }

        closestToZero = FormatMatch(startIndex: matchIndex, token: token);
      }

      if (closestToZero == null) break;

      if (closestToZero.startIndex != 0) {
        tokens.add(payload.substring(0, closestToZero.startIndex));
      }

      tokens.add(closestToZero);

      payload = payload.substring(closestToZero.endIndex);

      if (payload.isEmpty) {
        halt = true;
      }
    }

    String value = "";

    for (var token in tokens) {
      if (token is FormatMatch) {
        value += localization.formatters[token.token]!(this);
      } else {
        value += token as String;
      }
    }

    return value;
  }

  /// Localization Default formatters
  String formatDate() => format("LL");
  String formatDateShort() => format("ll");
  String formatDateTime() => format("LLL");
  String formatDateTimeShort() => format("lll");
  String formatDateTimeWithWeekday() => format("LLLL");
  String formatDateTimeWithWeekdayShort() => format("llll");
  String formatTime() => format("LT");
  String formatTimeWithSeconds() => format("LTS");

  /// Localization Default formatters
  // ignore: non_constant_identifier_names
  String get LL => format("LL");
  String get ll => format("ll");
  // ignore: non_constant_identifier_names
  String get LLL => format("LLL");
  String get lll => format("lll");
  // ignore: non_constant_identifier_names
  String get LLLL => format("LLLL");
  String get llll => format("llll");
  // ignore: non_constant_identifier_names
  String get LT => format("LT");
  // ignore: non_constant_identifier_names
  String get LTS => format("LTS");

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
  /// **This will not return precise duration. See [MomentLocalization.relativeThreshold]**
  String fromNow([bool dropSuffixOrPrefix = false]) {
    final Duration delta = difference(DateTime.now());

    return localization.relative(delta, dropSuffixOrPrefix);
  }

  /// **This will not return precise duration. See [MomentLocalization.relativeThreshold]**
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
          @Deprecated("This argument is deprecated. Currently unused.")
              bool weekStartOnSunday = false,
          bool omitHours = false,
          String? customFormat}) =>
      localization.calendar(this,
          reference: reference,
          omitHours: omitHours,
          customFormat: customFormat);

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
  DateTime lastMondayAsDateTime() => lastMonday();
  @Deprecated(
    'Use lastSunday() instead. '
    'This feature was deprecated after 0.6.2',
  )
  DateTime lastSundayAsDateTime() => lastSunday();
}
