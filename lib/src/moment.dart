export 'package:moment_dart/src/extension.dart';

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/formatters/format_match.dart';

/// Moment is subclass of DateTime
class Moment extends DateTime {
  static MomentLocalization defaultLocalization = MomentLocalizations.enUS();

  late final MomentLocalization localization;

  /// A [Moment] created using given `dateTime`;
  Moment(DateTime dateTime, {MomentLocalization? localization})
      : super.fromMicrosecondsSinceEpoch(dateTime.microsecondsSinceEpoch,
            isUtc: dateTime.isUtc) {
    this.localization = localization ?? defaultLocalization;
  }

  /// A [Moment] created using DateTime.now(), in Local timezone
  Moment.now({MomentLocalization? localization}) : super.now() {
    this.localization = localization ?? defaultLocalization;
  }

  Moment.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch,
      {bool isUtc = false, MomentLocalization? localization})
      : super.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: isUtc) {
    this.localization = localization ?? defaultLocalization;
  }

  Moment.fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch,
      {bool isUtc = false, MomentLocalization? localization})
      : super.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch, isUtc: isUtc) {
    this.localization = localization ?? defaultLocalization;
  }

  /// Returns new [Moment] with new values
  Moment copyWith({DateTime? dateTime, MomentLocalization? localization}) {
    final Moment value = Moment(
      dateTime ?? this,
      localization: localization ?? this.localization,
    );

    return value;
  }

  /// Returns new [Moment] with added duration
  ///
  /// Adds the `duration` using `DateTime.add(duration)`
  @override
  Moment add(Duration duration) =>
      Moment(super.add(duration), localization: localization);

  /// Returns new [Moment] with subtracted duration
  ///
  /// Subtracts the `duration` using `DateTime.subtract(duration)`
  @override
  Moment subtract(Duration duration) =>
      Moment(super.subtract(duration), localization: localization);

  /// Returns new [Moment] with added duration
  ///
  /// Calls `add(duration)`
  Moment operator +(Duration duration) => add(duration);

  /// Returns new [Moment] with subtracted duration
  ///
  /// Calls `subtract(duration)`
  Moment operator -(Duration duration) => subtract(duration);

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
    UnitStringForm form = UnitStringForm.full,
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
    UnitStringForm form = UnitStringForm.full,
  }) =>
      from(
        DateTime.now(),
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
    UnitStringForm form = UnitStringForm.full,
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
    UnitStringForm form = UnitStringForm.full,
    String? delimiter,
    DurationFormat format = DurationFormat.auto,
    bool dropPrefixOrSuffix = false,
  }) =>
      fromPrecise(
        DateTime.now(),
        round: round,
        omitZeros: omitZeros,
        includeWeeks: includeWeeks,
        form: form,
        delimiter: delimiter,
        format: format,
        dropPrefixOrSuffix: dropPrefixOrSuffix,
      );

  /// This will return **precise** durations. For imprecise durations, use [from()]
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
  /// * [round] - rounds the smallest unit if true, or truncates. Defaults to true.
  /// * [omitZeros] - unit will be omitted if equal to zero. For example, `DurationFormat.md` may return "3 months", but not "3 months 0 days"
  /// * [includeWeeks] - Whether `week` should be treated as duration unit. Only applicable when using [DurationFormat.auto]
  /// * [dropPrefixOrSuffix] - Whether to drop suffix/prefix. For example, "3h 2m ago" => "3h 2m", "in 7 days" => "7 days"
  String elapsed(
    DateTime since, {
    bool round = true,
    bool omitZeros = true,
    bool includeWeeks = true,
    UnitStringForm form = UnitStringForm.full,
    String? delimiter,
    DurationFormat format = DurationFormat.auto,
  }) =>
      fromPrecise(
        DateTime.now(),
        round: round,
        omitZeros: omitZeros,
        includeWeeks: includeWeeks,
        form: form,
        delimiter: delimiter,
        format: format,
        dropPrefixOrSuffix: true,
      );

  /// Returns precise duration for [duration] in [localization]
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
  /// * [round] - rounds the smallest unit if true, or truncates. Defaults to true.
  /// * [omitZeros] - unit will be omitted if equal to zero. For example, `DurationFormat.md` may return "3 months", but not "3 months 0 days"
  /// * [includeWeeks] - Whether `week` should be treated as duration unit. Only applicable when using [DurationFormat.auto]
  /// * [dropPrefixOrSuffix] - Whether to drop suffix/prefix. For example, "3h 2m ago" => "3h 2m", "in 7 days" => "7 days"
  static String duration(
    Duration duration, {
    required MomentLocalization localization,
    bool round = true,
    bool omitZeros = true,
    bool includeWeeks = false,
    UnitStringForm form = UnitStringForm.full,
    String? delimiter,
    DurationFormat format = DurationFormat.auto,
    bool dropPrefixOrSuffix = false,
  }) =>
      localization.duration(
        duration,
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
    Moment? reference,
    bool omitHours = false,
    String? customFormat,
  }) =>
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
}
