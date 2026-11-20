/// Calendar days from [reference]'s date to [dateTime]'s date, using each
/// one's own fields, so DST transitions in between don't shift the result.
///
/// Both should be in the same timezone.
int calendarDayDelta(DateTime dateTime, DateTime reference) => DateTime.utc(
        dateTime.year, dateTime.month, dateTime.day)
    .difference(DateTime.utc(reference.year, reference.month, reference.day))
    .inDays;

enum CalendarWeekdayWindow { last, next, distant }

/// Like moment.js: 1 to 6 days back is "last `weekday`", 1 to 6 days ahead is
/// "`weekday`", anything further is a plain date.
CalendarWeekdayWindow calendarWeekdayWindow(int deltaDays, bool isBefore) {
  if (deltaDays == 0) {
    return isBefore ? CalendarWeekdayWindow.last : CalendarWeekdayWindow.next;
  }
  if (deltaDays < 0 && deltaDays >= -6) return CalendarWeekdayWindow.last;
  if (deltaDays > 0 && deltaDays <= 6) return CalendarWeekdayWindow.next;

  return CalendarWeekdayWindow.distant;
}
