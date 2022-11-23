class TestLocalDateTime extends DateTime {
  TestLocalDateTime.fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch)
      : super.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);

// Using Asia/Ulaanbaatar as default timezone offset as most tests are written for this timezone
  static Duration ulaanbaatarMongolia = Duration(hours: 8);

  factory TestLocalDateTime(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) {
    // Test machine's local timezone offset
    final Duration timezoneOffset = DateTime.now().timeZoneOffset;

    return TestLocalDateTime.fromMicrosecondsSinceEpoch(
      DateTime(
        year,
        month,
        day,
        hour,
        minute,
        second,
        millisecond,
        microsecond,
      ).subtract(ulaanbaatarMongolia - timezoneOffset).microsecondsSinceEpoch,
    );
  }
}
