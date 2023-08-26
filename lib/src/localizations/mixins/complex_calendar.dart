import 'package:moment_dart/src/localization.dart';
import 'package:moment_dart/src/moment.dart';

/// This mixin provides:
///
/// * [complexCalendarData] - getter for custom data
///
/// And **overrides** [MomentLocalization.calendar]
mixin ComplexCalendar on MomentLocalization {
  @override
  CalenderLocalizationData? get calendarData => null;
  ComplexCalenderLocalizationData get complexCalendarData;

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

    late final String dateString;

    final int deltaDays = moment.differenceInDays(reference);
    final String? deltaDaysName =
        complexCalendarData.relativeDayNames[deltaDays];

    if (deltaDaysName != null) {
      dateString = deltaDaysName;
    } else {
      /// If it occured before [reference]
      if (moment < reference) {
        final DateTime weekBefore = reference.subtract(const Duration(days: 7));

        if (moment.isBefore(weekBefore)) {
          if (omitHoursIfDistant) {
            omitHours = true;
          }

          dateString = moment.format(
            customFormat ?? MomentLocalization.localizationDefaultDateFormat,
          );
        } else {
          dateString = complexCalendarData.keywords.lastWeekday(
            moment,
            reference: reference,
          );
        }
      }

      /// If it occured after [reference]
      else {
        final DateTime weekAfter = reference.add(const Duration(days: 7));

        /// If it's this or next week (relative to the reference)
        if (moment.isBefore(weekAfter)) {
          dateString = complexCalendarData.keywords.nextWeekday(
            moment,
            reference: reference,
          );
        } else {
          if (omitHoursIfDistant) {
            omitHours = true;
          }

          dateString = moment.format(
            customFormat ?? MomentLocalization.localizationDefaultDateFormat,
          );
        }
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

class ComplexCalenderLocalizationData {
  /// Relative days on calendar.
  ///
  /// For example, -1 is Yestderday, 0 is Today, 1 is Tomorrow
  ///
  /// Some language have words for
  /// day before yesterday (-2)
  /// or day after tomorrow (2)
  final Map<int, String> relativeDayNames;

  /// Time keywords. If value is absent or null for [CalendarKeyword], Moment will assume the language doesn't require the keyword.
  final ComplexCalenderLocalizationKeywords keywords;

  const ComplexCalenderLocalizationData({
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

class ComplexCalenderLocalizationKeywords {
  final CalendarKeywordLastWeekdayString lastWeekday;

  final CalendarKeywordNextWeekdayString nextWeekday;

  /// Defaults to
  ///
  /// ```dart
  /// "$dateString $timeString"
  /// ```
  final CalendarKeywordDateAtTimeString at;

  const ComplexCalenderLocalizationKeywords({
    required this.lastWeekday,
    required this.nextWeekday,
    this.at = ComplexCalenderLocalizationKeywords._defaultAt,
  });

  static String _defaultAt(dateTime, dateString, timeString, {reference}) =>
      "$dateString $timeString";
}
