import 'package:moment_dart/src/localization.dart';
import 'package:moment_dart/src/localizations/utils/calendar_day_delta.dart';
import 'package:moment_dart/src/moment.dart';

/// This mixin provides:
///
/// * [complexCalendarData] - getter for custom data
///
/// And **overrides** [MomentLocalization.calendar]
mixin ComplexCalendar on MomentLocalization {
  @override
  CalendarLocalizationData? get calendarData => null;
  ComplexCalendarLocalizationData get complexCalendarData;

  /// Calendar string
  @override
  String calendar(
    Moment moment, {
    DateTime? reference,
    String? customFormat,
    bool omitHours = false,
    bool omitHoursIfDistant = true,
  }) {
    reference ??= Moment.nowWithTimezone(moment.isUtc);
    reference = moment.isUtc ? reference.toUtc() : reference.toLocal();

    late final String dateString;

    final int deltaDays = calendarDayDelta(moment, reference);
    final String? deltaDaysName =
        complexCalendarData.relativeDayNames[deltaDays];

    if (deltaDaysName != null) {
      dateString = deltaDaysName;
    } else {
      switch (calendarWeekdayWindow(deltaDays, moment < reference)) {
        case CalendarWeekdayWindow.last:
          dateString = complexCalendarData.keywords.lastWeekday(
            moment,
            reference: reference,
          );
          break;
        case CalendarWeekdayWindow.next:
          dateString = complexCalendarData.keywords.nextWeekday(
            moment,
            reference: reference,
          );
          break;
        case CalendarWeekdayWindow.distant:
          if (omitHoursIfDistant) {
            omitHours = true;
          }

          dateString = moment.format(
            customFormat ?? MomentLocalization.localizationDefaultDateFormat,
          );
          break;
      }
    }

    if (customFormat != null) return dateString;

    if (omitHours) {
      return dateString;
    }

    return complexCalendarData.keywords.at(
      moment,
      dateString,
      calendarTime(moment),
      reference: reference,
    );
  }
}

class ComplexCalendarLocalizationData {
  /// Relative days on calendar.
  ///
  /// For example, -1 is Yestderday, 0 is Today, 1 is Tomorrow
  ///
  /// Some language have words for
  /// day before yesterday (-2)
  /// or day after tomorrow (2)
  final Map<int, String> relativeDayNames;

  /// Time keywords. If value is absent or null for [CalendarKeyword], Moment will assume the language doesn't require the keyword.
  final ComplexCalendarLocalizationKeywords keywords;

  const ComplexCalendarLocalizationData({
    required this.relativeDayNames,
    required this.keywords,
  });
}

typedef CalendarKeywordLastWeekdayString = String Function(
  DateTime dateTime, {
  DateTime? reference,
});

typedef CalendarKeywordNextWeekdayString = String Function(
  DateTime dateTime, {
  DateTime? reference,
});

typedef CalendarKeywordDateAtTimeString = String Function(
  DateTime dateTime,
  String dateString,
  String timeString, {
  DateTime? reference,
});

class ComplexCalendarLocalizationKeywords {
  final CalendarKeywordLastWeekdayString lastWeekday;

  final CalendarKeywordNextWeekdayString nextWeekday;

  /// Defaults to
  ///
  /// ```dart
  /// "$dateString $timeString"
  /// ```
  final CalendarKeywordDateAtTimeString at;

  const ComplexCalendarLocalizationKeywords({
    required this.lastWeekday,
    required this.nextWeekday,
    this.at = ComplexCalendarLocalizationKeywords._defaultAt,
  });

  static String _defaultAt(
          DateTime dateTime, String dateString, String timeString,
          {DateTime? reference}) =>
      "$dateString $timeString";
}
