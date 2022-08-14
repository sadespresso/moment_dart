import 'package:moment_dart/src/localizations.dart';
import 'package:moment_dart/src/moment.dart';

/// This mixin provides:
///
/// * [complexCalendarData] - custom data getter
///
/// And **overrides** [MomentLocalization.calendar]
mixin ComplexCalendar on MomentLocalization {
  @override
  CalenderLocalizationData? get calendarData => null;
  ComplexCalenderLocalizationData get complexCalendarData;

  @override

  /// Calendar string
  String calendar(
      Moment moment,
      {Moment? reference,
      @Deprecated("This argument is deprecated. Currently unused.")
          bool weekStartOnSunday = false,
      int startOfWeek = DateTime.monday,
      bool omitHours = false,
      String? customFormat}) {
    reference ??= Moment.now();

    late final String dateString;

    final int deltaDays = moment.differenceInDays(reference);
    final String? deltaDaysName =
        complexCalendarData.relativeDayNames[deltaDays];

    if (deltaDaysName != null) {
      dateString = deltaDaysName;
    } else {
      /// If it occured before [reference]
      if (moment < reference) {
        final Moment weekBefore = reference.subtract(const Duration(days: 7));

        if (moment.isBefore(weekBefore)) {
          dateString = moment.format(
              customFormat ?? MomentLocalization.localizationDefaultDateFormat);
        } else {
          dateString = complexCalendarData.keywords.lastWeekday(moment);
        }
      }

      /// If it occured after [reference]
      else {
        final Moment weekAfter = reference.add(const Duration(days: 7));

        /// If it's this or next week (relative to the reference)
        if (moment.isBefore(weekAfter)) {
          dateString = complexCalendarData.keywords.nextWeekday(moment);
        } else {
          dateString = moment.format(
              customFormat ?? MomentLocalization.localizationDefaultDateFormat);
        }
      }
    }

    if (customFormat != null) return dateString;

    if (omitHours) {
      return dateString;
    }

    return complexCalendarData.keywords
        .at(moment, dateString, calendarTime(moment));
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

typedef CalendarKeywordLastWeekdayString = String Function(DateTime dateTime);

typedef CalendarKeywordNextWeekdayString = String Function(DateTime dateTime);

typedef CalendarKeywordDateAtTimeString = String Function(
    DateTime dateTime, String dateString, String timeString);

class ComplexCalenderLocalizationKeywords {
  final CalendarKeywordLastWeekdayString lastWeekday;

  final CalendarKeywordNextWeekdayString nextWeekday;

  final CalendarKeywordDateAtTimeString at;

  const ComplexCalenderLocalizationKeywords({
    required this.lastWeekday,
    required this.nextWeekday,
    required this.at,
  });
}
