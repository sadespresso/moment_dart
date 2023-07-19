extension DateTimeConstructors on DateTime {
  static DateTime withTimezone(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
    bool isUtc = false,
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
}
