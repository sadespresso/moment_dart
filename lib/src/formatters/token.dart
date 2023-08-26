// ignore_for_file: constant_identifier_names

import 'package:moment_dart/src/localization.dart';

typedef FormatterFn = String Function(
    DateTime, FormatterToken, MomentLocalization);
typedef FormatterTokenFn = String Function(DateTime);

enum FormatterToken {
  /// [Month]
  ///
  /// 1 2 ... 11 12
  M,

  /// [Month]
  ///
  /// 1st 2nd ... 11th 12th
  ///
  /// **Not part of default formatters**. Therefore, must be implemented in the localization
  Mo,

  /// [Month]
  ///
  /// 01 02 ... 11 12
  MM,

  /// [Month]
  ///
  /// Jan Feb ... Nov Dec
  ///
  /// **Not part of default formatters**. Therefore, must be implemented in the localization
  MMM,

  /// [Month]
  ///
  /// January February ... November December
  ///
  /// **Not part of default formatters**. Therefore, must be implemented in the localization
  MMMM,

  /// [Quarter]
  ///
  /// 1 2 3 4
  Q,

  /// [Quarter]
  ///
  /// 1st 2nd 3rd 4th
  ///
  /// **Not part of default formatters**. Therefore, must be implemented in the localization
  Qo,

  /// [Day of Month]
  ///
  /// 1 2 ... 30 31
  D,

  /// [Day of Month]
  ///
  /// 1st 2nd ... 30th 31st
  ///
  /// **Not part of default formatters**. Therefore, must be implemented in the localization
  Do,

  /// [Day of Month]
  ///
  /// 01 02 ... 30 31
  DD,

  /// [Day of Year]
  ///
  /// 1 2 ... 364 365
  DDD,

  /// [Day of Year]
  ///
  /// 1st 2nd ... 364th 365th
  ///
  /// **Not part of default formatters**. Therefore, must be implemented in the localization
  DDDo,

  /// [Day of Year]
  ///
  /// 001 002 ... 364 365
  DDDD,

  /// [Day of Week]
  ///
  /// 1 2 ...6 7
  ///
  /// Moment.js uses `0-6`. However, we'll be using `1-7` to be in accordance with [DateTime]
  d,

  /// [Day of Week]
  ///
  /// 1st 2nd ... 6th 7th
  ///
  /// Moment.js uses `0-6`. However, we'll be using `1-7` to be in accordance with [DateTime]
  ///
  /// Please note that `do` is dart language keyword
  ///
  /// **Not part of default formatters**. Therefore, must be implemented in the localization
  d_o,

  /// [Day of Week]
  ///
  /// Mo Tu ... Sa Su
  ///
  /// **Not part of default formatters**. Therefore, must be implemented in the localization
  dd,

  /// [Day of Week]
  ///
  /// Mon Tue ... Sat Sun
  ///
  /// **Not part of default formatters**. Therefore, must be implemented in the localization
  ddd,

  /// [Day of Week]
  ///
  /// Monday ... Saturday Sunday
  ///
  /// **Not part of default formatters**. Therefore, must be implemented in the localization
  dddd,

  /// [Day of Week (ISO)]
  ///
  /// 1 2 ... 6 7
  ///
  /// Please note that [DateTime] uses 1-7 as weekday (in accordance with ISO), therefore, we'll be following the path.
  e,

  /// [Week of Year (ISO)]
  ///
  /// 1 2 ... 52 53
  w,

  /// [Week of Year (ISO)]
  ///
  /// 1st 2nd ... 52nd 53rd
  ///
  /// **Not part of default formatters**. Therefore, must be implemented in the localization
  wo,

  /// [Week of Year (ISO)]
  ///
  /// 01 02 ... 52 53
  ww,

  /// [Year]
  ///
  /// 1968 1969 70 71 ... 29 30 2031 2032
  ///
  /// If [year] doesn't belong in range (1970, 2030), displays full YYYY
  YY,

  /// [Year]
  ///
  /// 1970 1971 ... 2029 2030
  ///
  /// [DateTime] complies ISO 8601 standard, therefore Moment.js's YYYYYY, Y are redundant
  YYYY,

  /// [Year]
  ///
  /// -001970 -001971 ... +001907 +001971
  ///
  /// Note: Expanded Years (Covering the full time value range of approximately 273,790 years forward or backward from 01 January, 1970)
  @Deprecated("[DateTime] complies ISO 8601 standard, so, please use YYYY")
  YYYYYY,

  /// [Year]
  ///
  /// 1970 1971 ... 9999 +10000 +10001
  ///
  /// Note: This complies with the ISO 8601 standard for dates past the year 9999
  @Deprecated("[DateTime] complies ISO 8601 standard, so, please use YYYY")
  Y,

  /// [Era Year]
  ///
  /// 1 2 ... 2020 ...
  ///
  /// **Unimplemented by default**
  y,

  /// [Era]
  ///
  /// BC AD
  ///
  /// Note: Abbr era name
  NN,

  /// [Era]
  ///
  /// Before Christ, Anno Domini
  ///
  /// Note: Full era name
  NNNN,

  /// [Era]
  ///
  /// BC AD
  ///
  /// Note: Narrow era name
  NNNNN,

  /// [Week Year]
  ///
  /// 70 71 ... 29 30
  gg,

  /// [Week Year]
  ///
  /// 1970 1971 ... 2029 2030
  gggg,

  /// [AM/PM]
  ///
  /// AM PM (uppercase)
  ///
  /// **Not part of default formatters**. Therefore, must be implemented in the localization
  A,

  /// [AM/PM]
  ///
  /// am pm (lowercase)
  ///
  /// **Not part of default formatters**. Therefore, must be implemented in the localization
  a,

  /// [Hour]
  ///
  /// 0 1 ... 22 23
  H,

  /// [Hour]
  ///
  /// 00 01 ... 22 23
  HH,

  /// [Hour]
  ///
  /// 1 2 ... 11 12
  h,

  /// [Hour]
  ///
  /// 01 02 ... 11 12
  hh,

  /// [Hour]
  ///
  /// 1 2 ... 23 24
  k,

  /// [Hour]
  ///
  /// 01 02 ... 23 24
  kk,

  /// [Minute]
  ///
  /// 0 1 ... 58 59
  m,

  /// [Minute]
  ///
  /// 00 01 ... 58 59
  mm,

  /// [Second]
  ///
  /// 0 1 ... 58 59
  s,

  /// [Second]
  ///
  /// 00 01 ... 58 59
  ss,

  /// [Fractional Second]
  ///
  /// 0 1 ... 8 9
  S,

  /// [Fractional Second]
  ///
  /// 00 01 ... 98 99
  SS,

  /// [Fractional Second (Millisecond)]
  ///
  /// 000 001 ... 998 999
  SSS,

  /// [Fractional Second]
  ///
  /// 0000 0001 ... 9998,9999
  SSSS,

  /// [Fractional Second]
  ///
  /// 00000 00001 ... 99998,99999
  SSSSS,

  /// [Fractional Second (Microsecond)]
  ///
  /// 000000 000001 ... 999998,999999
  SSSSSS,

  /// [Timezone]
  ///
  /// -07:00 -06:00 ... +06:00 +07:00
  Z,

  /// [Timezone]
  ///
  /// -0700 -0600 ... +0600 +0700
  ZZ,

  /// [Timezone Name]
  ///
  /// Returns [DateTime.timeZoneName], result may not be consistent across platforms
  ZZZ,

  /// [Unix timestamp (seconds)]
  X,

  /// [Unix millisecond timestamp]
  x,

  /// [Unix microsecond timestamp]
  xx,

  /// Date (in local format, shorter)
  ///
  /// 9/4/1986
  l,

  /// Date (in local format)
  ///
  /// 09/04/1986
  L,

  /// Month name, day of month, year (shorter)
  ///
  /// Sep 4 1986
  ll,

  /// Month name, day of month, year
  ///
  /// September 04 1986
  LL,

  /// Month name, day of month, year, time
  ///
  /// Sep 4 1986 8:30 PM
  lll,

  /// Month name, day of month, year, time
  ///
  /// September 04 1986 08:30 PM
  LLL,

  /// Day of week, month name, day of month, year, time (shorter)
  ///
  /// Thu, Sep 4 1986 8:30 PM
  llll,

  /// Day of week, month name, day of month, year, time
  ///
  /// Thursday, September 04 1986 08:30 PM
  LLLL,

  /// Time (without seconds)
  ///
  /// 8:30 PM
  LT,

  /// Time (with seconds)
  ///
  /// 8:30:00 PM
  LTS,
}
