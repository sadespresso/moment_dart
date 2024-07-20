export 'package:moment_dart/src/extensions.dart';
export 'package:moment_dart/src/time_range.dart';

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/formatters/format_match.dart';

/// A subclass of DateTime. Therefore:
/// ```dart
/// Moment.now() is DateTime == true // always
/// ```
///
/// ### Set a global localization:
///
/// Global localizations will affect all moment instances, except those with explicitly set localizations.
///
/// ```dart
/// Moment.setGlobalLocalization(MomentLocalizations.fr());
/// ```
///
/// ### An instance with explicit localization:
/// ```dart
/// Moment.now(localization: MomentLocalizations.mn())
/// ```
///
/// ### Formatting
///
/// `Moment().format` will format [DateTime] based on the `payload`. For example:
/// ```dart
/// Moment.fromMillisecondsSinceEpoch(0, isUtc: true).LLLL; // Thursday, January 1 1970 00:00 AM
/// ```
///
/// See [FormatterToken]s
class Moment extends DateTime {
  /// Any instances without explicit localization set will use the global localization.
  ///
  /// To override global localization, create new Moment instance like so:
  /// ```dart
  ///   Moment frenchMoment = Moment.now(localization: MomentLocalizations.fr();
  ///   frenchMoment.LL; // 14 février 2023
  /// ```
  static MomentLocalization defaultLocalization = MomentLocalizations.enUS();

  /// Any instances without explicit localization set will use the global localization.
  ///
  /// To override global localization, create new Moment instance like so:
  /// ```dart
  ///   Moment frenchMoment = Moment.now(localization: MomentLocalizations.fr();
  ///   frenchMoment.LL; // 14 février 2023
  /// ```
  static setGlobalLocalization(MomentLocalization localization) {
    Moment.defaultLocalization = localization;
  }

  late final MomentLocalization? _localization;

  bool get hasExplicitLocalization => _localization != null;

  /// Original localization of this instance
  MomentLocalization? get setLocalization => _localization;

  /// Returns localization of this instance. If [this] doesn't have localization, returns the global localization.
  ///
  /// Use [Moment.setGlobalLocalization] to set the global localization
  MomentLocalization get localization => _localization ?? defaultLocalization;

  /// A [Moment] created using given `dateTime`;
  Moment(DateTime dateTime, {MomentLocalization? localization})
      : super.fromMicrosecondsSinceEpoch(
          dateTime.microsecondsSinceEpoch,
          isUtc: dateTime.isUtc,
        ) {
    _localization = localization;
  }

  /// A [Moment] created using DateTime.now(), in Local timezone
  Moment.now({MomentLocalization? localization}) : super.now() {
    _localization = localization;
  }

  factory Moment.nowWithTimezone(
    bool isUtc, {
    MomentLocalization? localization,
  }) =>
      Moment(DateTimeConstructors.nowWithTimezone(isUtc),
          localization: localization);

  Moment.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch,
      {bool isUtc = false, MomentLocalization? localization})
      : super.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: isUtc) {
    _localization = localization;
  }

  Moment.fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch,
      {bool isUtc = false, MomentLocalization? localization})
      : super.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch, isUtc: isUtc) {
    _localization = localization;
  }

  /// Returns new [Moment] with new values
  Moment copyWith({DateTime? dateTime, MomentLocalization? localization}) {
    final Moment value = Moment(
      dateTime ?? this,
      localization: localization ?? _localization,
    );

    return value;
  }

  /// Returns new [Moment] with added duration
  ///
  /// Adds the `duration` using `DateTime.add(duration)`
  @override
  Moment add(Duration duration) =>
      Moment(super.add(duration), localization: _localization);

  /// Returns new [Moment] with subtracted duration
  ///
  /// Subtracts the `duration` using `DateTime.subtract(duration)`
  @override
  Moment subtract(Duration duration) =>
      Moment(super.subtract(duration), localization: _localization);

  /// Returns new [Moment] with added duration
  ///
  /// Calls `add(duration)`
  Moment operator +(Duration duration) => add(duration);

  /// Returns new [Moment] with subtracted duration
  ///
  /// Calls `subtract(duration)`
  Moment operator -(Duration duration) => subtract(duration);

  List<FormatterToken> get _fts => localization.tokens;

  /// Formats date according to [payload]. See also: [FormatterToken]
  ///
  /// You may want to check if your [DateTime] object is local or not.
  ///
  /// Set [forceLocal] to true to enforce local timezone
  String format([
    String payload = MomentLocalization.localizationDefaultDateFormat,
    bool forceLocal = false,
  ]) {
    final RegExp escaper = RegExp(r"\[(([^\]]+))\]", multiLine: true);

    if (escaper.hasMatch(payload)) {
      return payload.splitMapJoin(
        escaper,
        onMatch: (p0) => p0.group(1)!,
        onNonMatch: (p0) => _format(p0, forceLocal: forceLocal),
      );
    }

    return _format(payload, forceLocal: forceLocal);
  }

  String _format(
    String payload, {
    bool forceLocal = false,
  }) {
    final List<dynamic> tokens = [];

    bool halt = false;

    while (!halt) {
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

      if (closestToZero == null) {
        if (payload.isNotEmpty) {
          tokens.add(payload);
        }
        break;
      }

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

    final DateTime data = forceLocal ? toLocal() : this;

    for (var token in tokens) {
      if (token is FormatMatch) {
        value += localization.formatters[token.token]!(data);
      } else {
        value += token as String;
      }
    }

    return value;
  }

  /// Localization Default formatters
  String formatDate([bool forceLocal = false]) => format("LL", forceLocal);
  String formatDateShort([bool forceLocal = false]) => format("ll", forceLocal);
  String formatDateTime([bool forceLocal = false]) => format("LLL", forceLocal);
  String formatDateTimeShort([bool forceLocal = false]) =>
      format("lll", forceLocal);
  String formatDateTimeWithWeekday([bool forceLocal = false]) =>
      format("LLLL", forceLocal);
  String formatDateTimeWithWeekdayShort([bool forceLocal = false]) =>
      format("llll", forceLocal);
  String formatTime([bool forceLocal = false]) => format("LT", forceLocal);
  String formatTimeWithSeconds([bool forceLocal = false]) =>
      format("LTS", forceLocal);

  // Localization Default formatters
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
  static Moment parse(String input, {MomentLocalization? localization}) =>
      DateTime.parse(input).toMoment(localization: localization);

  /// Uses [DateTime.tryParse]
  static Moment? tryParse(String input, {MomentLocalization? localization}) =>
      DateTime.tryParse(input)?.toMoment(localization: localization);

  /// **This will not return precise duration. See [MomentLocalization.relativeThreshold] for details**
  ///
  /// Use [fromPrecise] if you need precise output
  String from(
    DateTime anchor, {
    bool dropPrefixOrSuffix = false,
    Abbreviation form = Abbreviation.none,
  }) {
    final Duration delta = difference(anchor);

    return localization.relative(
      delta,
      dropPrefixOrSuffix: dropPrefixOrSuffix,
      form: form,
    );
  }

  /// Example when using [LocalizationEnUs]:
  ///
  /// If [this] is yesterday, will result `"a day ago"`
  ///
  /// If [this] is tomorrow, will result `"in a day"`
  ///
  /// **This will not return precise duration. See [MomentLocalization.relativeThreshold] for details**
  ///
  /// Use [fromNowPrecise]
  String fromNow({
    bool dropPrefixOrSuffix = false,
    Abbreviation form = Abbreviation.none,
  }) =>
      from(
        DateTimeConstructors.nowWithTimezone(isUtc),
        dropPrefixOrSuffix: dropPrefixOrSuffix,
        form: form,
      );

  /// This will return **precise** durations. For imprecise durations, use [from()]
  ///
  /// e.g.:
  /// * 2 minutes 39 seconds ago
  /// * in 2m 39s
  ///
  /// Params:
  ///
  /// * [format] - format to display the duration. For example, when set to `DurationFormat.md`, will result to "3 months 2 days"
  /// * [delimiter] - string to join duration when there are more than one. Defaults to **space**. For example,
  /// * [form] - Unit string form. For example, minute would look like "18 minutes", "18 min", "18m" in full, mid, short forms, respectively.
  /// * [round] - rounds the smallest unit if true, or truncates. Defaults to true.
  /// * [omitZeros] - unit will be omitted if equal to zero. For example, `DurationFormat.md` may return "3 months", but not "3 months 0 days"
  /// * [includeWeeks] - Whether `week` should be treated as duration unit. Only applicable when using [DurationFormat.auto]
  /// * [dropPrefixOrSuffix] - Whether to drop suffix/prefix. For example, "3h 2m ago" => "3h 2m", "in 7 days" => "7 days"
  String fromPrecise(
    DateTime anchor, {
    bool round = true,
    bool omitZeros = true,
    bool includeWeeks = true,
    Abbreviation form = Abbreviation.none,
    String? delimiter,
    DurationFormat format = DurationFormat.auto,
    bool dropPrefixOrSuffix = false,
  }) {
    final Duration delta = difference(anchor);

    return localization.duration(
      delta,
      round: round,
      omitZeros: omitZeros,
      includeWeeks: includeWeeks,
      form: form,
      delimiter: delimiter,
      format: format,
    );
  }

  /// Example when using [LocalizationEnUs]:
  ///
  /// If [this] is yesterday, will result `"1 day ago"`
  ///
  /// If [this] is tomorrow, will result `"in 1 day"`
  ///
  /// This will return **precise** durations. For imprecise durations, use [from()]
  ///
  /// e.g.:
  /// * 2 minutes 39 seconds ago
  /// * in 2m 39s
  ///
  /// Params:
  ///
  /// * [format] - format to display the duration. For example, when set to `DurationFormat.md`, will result to "3 months 2 days"
  /// * [delimiter] - string to join duration when there are more than one. Defaults to **space**. For example,
  /// * [form] - Unit string form. For example, minute would look like "18 minutes", "18 min", "18m" in full, mid, short forms, respectively.
  /// * [round] - rounds the smallest unit if true, or truncates. Defaults to true.
  /// * [omitZeros] - unit will be omitted if equal to zero. For example, `DurationFormat.md` may return "3 months", but not "3 months 0 days"
  /// * [includeWeeks] - Whether `week` should be treated as duration unit. Only applicable when using [DurationFormat.auto]
  /// * [dropPrefixOrSuffix] - Whether to drop suffix/prefix. For example, "3h 2m ago" => "3h 2m", "in 7 days" => "7 days"
  String fromNowPrecise({
    bool round = true,
    bool omitZeros = true,
    bool includeWeeks = true,
    Abbreviation form = Abbreviation.none,
    String? delimiter,
    DurationFormat format = DurationFormat.auto,
    bool dropPrefixOrSuffix = false,
  }) =>
      fromPrecise(
        DateTimeConstructors.nowWithTimezone(isUtc),
        round: round,
        omitZeros: omitZeros,
        includeWeeks: includeWeeks,
        form: form,
        delimiter: delimiter,
        format: format,
        dropPrefixOrSuffix: dropPrefixOrSuffix,
      );

  /// Returns precise duration for [duration] in [localization]
  ///
  /// e.g.:
  /// * 2 minutes 39 seconds
  /// * 2m39s
  ///
  /// Params:
  ///
  /// * [localization] - when null, defaults to `Moment.defaultLocalization` (see [setGlobalLocalization])
  /// * [format] - format to display the duration. For example, when set to `DurationFormat.md`, will result to "3 months 2 days"
  /// * [delimiter] - string to join duration when there are more than one. Defaults to **space**. For example,
  /// * [form] - Unit string form. For example, minute would look like "18 minutes", "18 min", "18m" in full, mid, short forms, respectively.
  /// * [round] - rounds the smallest unit if true, or truncates. Defaults to true.
  /// * [omitZeros] - unit will be omitted if equal to zero. For example, `DurationFormat.md` may return "3 months", but not "3 months 0 days"
  /// * [includeWeeks] - Whether `week` should be treated as duration unit. Only applicable when using [DurationFormat.auto]
  /// * [dropPrefixOrSuffix] - Whether to drop suffix/prefix. For example, "3h 2m ago" => "3h 2m", "in 7 days" => "7 days"
  static String duration(
    Duration duration, {
    MomentLocalization? localization,
    bool round = true,
    bool omitZeros = true,
    bool includeWeeks = false,
    Abbreviation form = Abbreviation.none,
    String? delimiter,
    DurationFormat format = DurationFormat.auto,
    bool dropPrefixOrSuffix = false,
  }) =>
      duration.toDurationString(
        localization: localization ?? Moment.defaultLocalization,
        round: round,
        omitZeros: omitZeros,
        includeWeeks: includeWeeks,
        form: form,
        format: format,
        delimiter: delimiter,
        dropPrefixOrSuffix: dropPrefixOrSuffix,
      );

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
  String calendar({
    DateTime? reference,
    bool omitHours = false,
    String? customFormat,
  }) =>
      localization.calendar(
        this,
        reference: reference,
        omitHours: omitHours,
        customFormat: customFormat,
      );

  @override
  Moment toUtc() => Moment(super.toUtc(), localization: _localization);

  @override
  Moment toLocal() => Moment(super.toLocal(), localization: _localization);

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

  /// Start of the current hour in the local timezone
  static DateTime startOfThisHour() => DateTime.now().startOfHour();

  /// Start of the next hour in the local timezone
  static DateTime startOfNextHour() => DateTime.now().startOfNextHour();

  /// Start of the last hour in the local timezone
  static DateTime startOfLastHour() => DateTime.now().startOfLastHour();

  /// Start of today in the local timezone
  static DateTime startOfToday() => DateTime.now().startOfDay();

  /// Start of tomorrow in the local timezone

  static DateTime startOfTomorrow() => DateTime.now().startOfNextDay();

  /// Start of yesterday in the local timezone
  static DateTime startOfYesterday() => DateTime.now().startOfLastDay();

  /// Start of the current local week in the local timezone
  static DateTime startOfThisLocalWeek([int? weekStart]) =>
      DateTime.now().startOfLocalWeek(weekStart);

  /// Start of the next local week in the local timezone
  static DateTime startOfNextLocalWeek([int? weekStart]) =>
      DateTime.now().startOfNextLocalWeek(weekStart);

  /// Start of the last local week in the local timezone
  static DateTime startOfLastLocalWeek([int? weekStart]) =>
      DateTime.now().startOfLastLocalWeek(weekStart);

  /// Start of the current ISO week in the local timezone
  static DateTime startOfThisIsoWeek() =>
      DateTime.now().startOfLocalWeek(DateTime.monday);

  /// Start of the next ISO week in the local timezone
  static DateTime startOfNextIsoWeek() =>
      DateTime.now().startOfNextLocalWeek(DateTime.monday);

  /// Start of the last ISO week in the local timezone
  static DateTime startOfLastIsoWeek() =>
      DateTime.now().startOfLastLocalWeek(DateTime.monday);

  /// Start of the current month in the local timezone
  static DateTime startOfThisMonth() => DateTime.now().startOfMonth();

  /// Start of the next month in the local timezone
  static DateTime startOfNextMonth() => DateTime.now().startOfNextMonth();

  /// Start of the last month in the local timezone
  static DateTime startOfLastMonth() => DateTime.now().startOfLastMonth();

  /// Start of the current year in the local timezone
  static DateTime startOfThisYear() => DateTime.now().startOfYear();

  /// Start of the next year in the local timezone
  static DateTime startOfNextYear() => DateTime.now().startOfNextYear();

  /// Start of the last year in the local timezone
  static DateTime startOfLastYear() => DateTime.now().startOfLastYear();

  /// End of the current hour in the local timezone
  static DateTime endOfThisHour() => DateTime.now().endOfHour();

  /// End of the next hour in the local timezone
  static DateTime endOfNextHour() => DateTime.now().endOfNextHour();

  /// End of the last hour in the local timezone
  static DateTime endOfLastHour() => DateTime.now().endOfLastHour();

  /// End of today in the local timezone
  static DateTime endOfToday() => DateTime.now().endOfDay();

  /// End of tomorrow in the local timezone
  static DateTime endOfTomorrow() => DateTime.now().endOfNextDay();

  /// End of yesterday in the local timezone
  static DateTime endOfYesterday() => DateTime.now().endOfLastDay();

  /// End of the current local week in the local timezone
  static DateTime endOfThisLocalWeek([int? weekStart]) =>
      DateTime.now().endOfLocalWeek(weekStart);

  /// End of the next local week in the local timezone
  static DateTime endOfNextLocalWeek([int? weekStart]) =>
      DateTime.now().endOfNextLocalWeek(weekStart);

  /// End of the last local week in the local timezone
  static DateTime endOfLastLocalWeek([int? weekStart]) =>
      DateTime.now().endOfLastLocalWeek(weekStart);

  /// End of the current ISO week in the local timezone
  static DateTime endOfThisIsoWeek() =>
      DateTime.now().endOfLocalWeek(DateTime.monday);

  /// End of the next ISO week in the local timezone
  static DateTime endOfNextIsoWeek() =>
      DateTime.now().endOfNextLocalWeek(DateTime.monday);

  /// End of the last ISO week in the local timezone
  static DateTime endOfLastIsoWeek() =>
      DateTime.now().endOfLastLocalWeek(DateTime.monday);

  /// End of the current month in the local timezone
  static DateTime endOfThisMonth() => DateTime.now().endOfMonth();

  /// End of the next month in the local timezone
  static DateTime endOfNextMonth() => DateTime.now().endOfNextMonth();

  /// End of the last month in the local timezone
  static DateTime endOfLastMonth() => DateTime.now().endOfLastMonth();

  /// End of the current year in the local timezone
  static DateTime endOfThisYear() => DateTime.now().endOfYear();

  /// End of the next year in the local timezone
  static DateTime endOfNextYear() => DateTime.now().endOfNextYear();

  /// End of the last year in the local timezone
  static DateTime endOfLastYear() => DateTime.now().endOfLastYear();

  /// epoch, but in the local timezone
  static DateTime epoch = DateTime.fromMicrosecondsSinceEpoch(0);

  /// epoch in UTC
  static DateTime epochUtc =
      DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true);

  static DateTime maxValue =
      DateTime.fromMicrosecondsSinceEpoch(8640000000000000000);
  static DateTime minValue =
      DateTime.fromMicrosecondsSinceEpoch(-8640000000000000000);
}
