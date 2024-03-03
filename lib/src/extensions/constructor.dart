extension DateTimeConstructors on DateTime {
  static DateTime nowWithTimezone(bool isUtc) {
    if (isUtc) {
      return DateTime.now().toUtc();
    }

    return DateTime.now();
  }

  static DateTime withTimezone(
    bool isUtc,
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) {
    if (isUtc) {
      return DateTime.utc(
        year,
        month,
        day,
        hour,
        minute,
        second,
        millisecond,
        microsecond,
      );
    }
    return DateTime(
      year,
      month,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  static DateTime dateWithTimezone(
    int year, [
    int month = 1,
    int day = 1,
    bool isUtc = false,
  ]) {
    if (isUtc) {
      return DateTime.utc(
        year,
        month,
        day,
        0,
        0,
        0,
        0,
        0,
      );
    }
    return DateTime(
      year,
      month,
      day,
      0,
      0,
      0,
      0,
      0,
    );
  }

  /// Anything after [year] defaults to **December 31, 23:59:59.999.999**
  ///
  /// If you've set the [month], don't forget to set the [day] as well. Not all
  /// days have 31 days like December
  static DateTime endOfYearWithTimezone(
    bool isUtc,
    int year, [
    int month = 12,
    int day = 31,
    int hour = 23,
    int minute = 59,
    int second = 59,
    int millisecond = 999,
    int microsecond = 999,
  ]) =>
      DateTimeConstructors.withTimezone(
        isUtc,
        year,
        month,
        day,
        hour,
        minute,
        second,
        millisecond,
        microsecond,
      );
}
