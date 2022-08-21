class CalenderLocalizationData {
  /// Relative days on calendar.
  ///
  /// For example, -1 is Yestderday, 0 is Today, 1 is Tomorrow
  ///
  /// Some language have words for
  /// day before yesterday (-2: ereyesterday)
  /// or day after tomorrow (2: overmorrow)
  final Map<int, String> relativeDayNames;

  /// Time keywords. If value is absent or null for [CalendarKeyword], Moment will assume the language doesn't require the keyword.
  final CalenderLocalizationKeywords keywords;

  const CalenderLocalizationData({
    required this.relativeDayNames,
    required this.keywords,
  });
}

typedef CalendarKeywordLastWeekdayString = String Function(String weekday);
String defaultCalendarKeywordLastString(String weekday) => weekday;

typedef CalendarKeywordNextWeekdayString = String Function(String weekday);
String defaultCalendarKeywordNextString(String weekday) => weekday;

typedef CalendarKeywordDateAtTimeString = String Function(
    String date, String time);
String defaultCalendarKeywordDateAtTimeString(String date, String time) =>
    "$date $time";

class CalenderLocalizationKeywords {
  final CalendarKeywordLastWeekdayString lastWeekday;

  final CalendarKeywordNextWeekdayString nextWeekday;

  final CalendarKeywordDateAtTimeString at;

  const CalenderLocalizationKeywords({
    this.lastWeekday = defaultCalendarKeywordLastString,
    this.nextWeekday = defaultCalendarKeywordNextString,
    this.at = defaultCalendarKeywordDateAtTimeString,
  });
}
