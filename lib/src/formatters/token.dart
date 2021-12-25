// ignore_for_file: constant_identifier_names

import 'package:moment_dart/src/localizations.dart';

typedef FormatterFn = String Function(DateTime, FormatterToken, Localization);
typedef FormatterTokenFn = String Function(DateTime, Localization);

enum FormatterToken {
  /// [Month]
  ///
  /// 1 2 ... 11 12
  M,

  /// [Month]
  ///
  /// 1st 2nd ... 11th 12th
  Mo,

  /// [Month]
  ///
  /// 01 02 ... 11 12
  MM,

  /// [Month]
  ///
  /// Jan Feb ... Nov Dec
  MMM,

  /// [Month]
  ///
  /// January February ... November December
  MMMM,

  /// [Quarter]
  ///
  /// 1 2 3 4
  Q,

  /// [Quarter]
  ///
  /// 1st 2nd 3rd 4th
  Qo,

  /// [Day of Month]
  ///
  /// 1 2 ... 30 31
  D,

  /// [Day of Month]
  ///
  /// 1st 2nd ... 30th 31st
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
  /// Please not that `do` is dart language keyword
  d_o,

  /// [Day of Week]
  ///
  /// Mo Tu ... Sa Su
  dd,

  /// [Day of Week]
  ///
  /// Mon Tue ... Sat Sun
  ddd,

  /// [Day of Week]
  ///
  /// Sunday Monday ... Friday Saturday
  dddd,

  /// [Day of Week (Locale)]
  ///
  /// 1 2 ... 6 7
  ///
  /// Please note that [DateTime] uses 1-7 as weekday (in accordance with ISO), therefore, we'll be following the path.
  e,

  /// [Day of Week (ISO)]
  ///
  /// 1 2 ... 6 7
  E,

  /// [Week of Year]
  ///
  /// 1 2 ... 52 53
  w,

  /// [Week of Year]
  ///
  /// 1st 2nd ... 52nd 53rd
  wo,

  /// [Week of Year]
  ///
  /// 01 02 ... 52 53
  ww,

  /// [Week of Year (ISO)]
  ///
  /// 1 2 ... 52 53
  W,

  /// [Week of Year (ISO)]
  ///
  /// 1st 2nd ... 52nd 53rd
  Wo,

  /// [Week of Year (ISO)]
  ///
  /// 01 02 ... 52 53
  WW,

  /// [Year]
  ///
  /// 70 71 ... 29 30
  YY,

  /// [Year]
  ///
  /// 1970 1971 ... 2029 2030
  YYYY,

  /// [Year]
  ///
  /// -001970 -001971 ... +001907 +001971 Note: Expanded Years (Covering the full time value range of approximately 273,790 years forward or backward from 01 January, 1970)
  YYYYYY,

  /// [Year]
  ///
  /// 1970 1971 ... 9999 +10000 +10001 Note: This complies with the ISO 8601 standard for dates past the year 9999
  Y,

  /// [Era Year]
  ///
  /// 1 2 ... 2020 ...
  y,

  /// [Era]
  ///
  /// BC AD Note: Abbr era name
  NN,

  /// [Era]
  ///
  /// Before Christ, Anno Domini Note: Full era name
  NNNN,

  /// [Era]
  ///
  /// BC AD Note: Narrow era name
  NNNNN,

  /// [Week Year]
  ///
  /// 70 71 ... 29 30
  gg,

  /// [Week Year]
  ///
  /// 1970 1971 ... 2029 2030
  gggg,

  /// [Week Year (ISO)]
  ///
  /// 70 71 ... 29 30
  GG,

  /// [Week Year (ISO)]
  ///
  /// 1970 1971 ... 2029 2030
  GGGG,

  /// [AM/PM]
  ///
  /// AM PM (uppercase)
  A,

  /// [AM/PM]
  ///
  /// am pm (lowercase)
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

  /// [Fractional Second]
  ///
  /// 000 001 ... 998 999
  SSS,

  /// [Fractional Second]
  ///
  /// 0000 0001 ... 9998,9999
  SSSS,

  /// [Timezone]
  ///
  /// -07:00 -06:00 ... +06:00 +07:00
  Z,

  /// [Timezone]
  ///
  /// -0700 -0600 ... +0600 +0700
  ZZ,

  /// [Unix timestamp]
  X,

  /// [Unix millisecond timestamp]
  x,
}
