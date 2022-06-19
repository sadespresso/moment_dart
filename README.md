[![pub package](https://img.shields.io/pub/v/moment_dart.svg)](https://pub.dartlang.org/packages/moment_dart)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

> Inspired by moment.js

## Features

Convert `DateTime` to human-readable text.
  - [Relative duration](#relative-durations)
  - [Calendar text](#calendar-dates)
  - [Formatted dates](#formatting)
  - [Multiple localizations](#changing-localization)

Helper classes
  - [Start of year/month/.../millis](#start-of-yearmonthmoment)
  - [Find last or next weekday](#find-lastnext-weekday)
  - [Is same year/month/.../moment as](#is-same-unit-as)

## Getting started ✨

Import the package
```dart
import 'package:moment_dart/moment_dart.dart';
```

Create Moment instance

```dart

final Moment now = Moment.now();

final Moment epoch = Moment.fromMillisecondsSinceEpoch(0, isUtc: true);

/// Using extension
final Moment bday = DateTime(2003, 6, 1, 5, 1).toMoment();
/// or from [DateTime]
final Moment bday = Moment(DateTime(2003, 6, 1, 5, 1));
```

As of version 0.7.0, DateTime is now superclass of Moment

```dart
class Moment extends DateTime { ... }
```

## Usage 🌿

### Relative durations

```dart
final Moment yesterday = Moment.now() - Duration(days: 1);

yesterday.fromNow(); // a day ago

// You can omit prefix/suffix
yesterday.fromNow(true); // a day

yesterday.from(yesterday - Duration(days: 365)); // a year ago
```

### Calendar dates
```dart

now.subtract(const Duration(days: 1)).calendar();  // Yesterday at 10:02AM
now.calendar();                              // Today at 10:02AM
now.subtract(const Duration(days: 1)).calendar();  // Tomorrow at 10:02AM

// [reference] - defaults to Moment.now(), acts as an anchor.
// [omitHours] - omits the hour part. Hour part is formatted by "LT" token.
now.calendar(
  reference: (now - const Duration(days: 1)),
  omitHours: true,
); // Tomorrow
```

### Start of year/month/.../moment
```dart
final Moment tada =
      DateTime(2022, 6, 19, 21, 9, 33).toMoment(); // June 19 2022 09:09 PM

tada.startOf(DurationUnit.day); // June 19 2022 12:00 AM
// OR
tada.startOfDay(); // June 19 2022 12:00 AM
```

### Find last/next weekday

**Works on `DateTime` and `Moment`**

We're always dealing with ***local*** date times here. If the date is UTC, it's converted to local beforehand.

```dart
final Moment tada =
      DateTime(2022, 6, 19, 21, 9, 33).toMoment(); // June 19 2022 09:09 PM

tada.nextMonday(); // June 20 2022 09:09 PM

tada.lastMonday(); // June 13 2022 09:09 PM

// Note that "today" is neither last/next Sunday
tada.lastSunday(); // June 12 2022 09:09 PM
```

### Is same **unit** as

**Works on `DateTime` and `Moment`**


```dart
final DateTime otherBday = DateTime(2003,6,19);
final Moment spiritRoverOnMars = DateTime(2003,6,10).toMoment();

otherBday.isAtSameMonthAs(spiritRoverOnMars); // true
otherBday.isAtSameYearAs(spiritRoverOnMars); // true
```

⚠️ It takes timezones into account

```dart
final DateTime bday = DateTime(2003,6,1,5,33); // 2003-05-31 21:33:00.000Z (Local time zone was GMT+08:00)
final Moment spiritRoverOnMars = DateTime(2003,6,10).toMoment(); // 2003-06-09 16:00:00.000Z

bday.isAtSameMonthAs(spiritRoverOnMars); // false; didn't happen in same month. Bday was in May, Spirit Rover landed in June.
bday.isAtSameYearAs(spiritRoverOnMars); // true
```

## Formatting
[See list of format tokens](#format-tokens)

```dart
now.format("YYYY MMMM Do - hh:mm:ssa"); //2003 June 1st - 05:01:00am
now.format("LTS");                      //5:01:00 AM
now.format("dddd");                     //Sunday
now.format("MMM Do YY");                //Jun 1st 03
```

Escape strings by **encasulating them in square brackets ([])**.

```dart
epoch.format("YYYY [YYYY] MMMM [MMMM] Do [Do] LT [A]"); // 1970 YYYY January MMMM 1st Do 12:00 AM A
```

Alternatively, unmatched tokens will be left as is

```dart
epoch.format("YYYY년 MMM D일 ddd A h:mm"); // 1970년 1월 1일 목 오전 8:00 (Localization: KO)
```

### Parsing
Currently uses `DateTime.parse()`

> ***COMING SOON 💫***

## Changing localization 🌐
Localization defaults to `MomentLocalizations.enUS()`

```dart
final Moment hangulday2022 = Moment(DateTime(2022,10,9), localization: MomentLocalizations.ko());

hangulday2022.format("ll"); // 2022년 10월 9일
hangulday2022.format("LL"); // 2022년 10월 9일
```

## Available Localization classes:

Localizations are classes that extend `MomentLocalization`

[See how you can create your own localization](#Creating-your-own-localzation)

- LocalizationEnUs (English - United States) [en_US]
- LocalizationKorean (Korean) [ko]
- LocalizationGermanStandard (German) [de_DE]
- LocalizationMongolianCyrillic (Mongolian) [mn]
  - LocalizationMongolianTraditional (Mongolian) [mn]
  - LocalizationMongolianTraditionalNumbers (Uses traditional Mongolian numbers)

## Salt 🧂 and pepper

Moment provides an extension with set of useful functions. **Can be called on either `Moment` or `DateTime` instance**

```dart
final Moment date = DateTime(2022,03,29).toMoment();
// It can also work on [DateTime] too!
final DateTime date = DateTime(2022,03,29);

//Returns the ISO Week number of the year
//
// [1,2,3,...,52,53]
date.week == 13; // true

// Returns the year according to ISO Week
date.weekYear == 2022; // true

// Returns the quarter of the year. [][Jan,Feb,Mar][Apr,May,Jun][Jul,Aug,Sep][Oct,Nov,Dec]
//
// [1,2,3,4]
date.quarter == 1; // true

// Returns if the [year] is leap year
date.isLeapYear == false; // true

/// Returns ordinal day of the year
/// 
/// [1,2,3,...,365,366]
date.dayOfYear == 88; // true
```

Comparison can be called on either `Moment` or `DateTime`. Accounts UTC/Local timezone.

Available for all units: year, month, day, hour, minute, second, millisecond, microsecond

```dart
final DateTime local = DateTime(1972, 1, 1, 7); // Jan 1, 1972 at 7AM @GMT+8
final DateTime utc = local.toUtc();             // Dec 31, 1971 at 11PM @UTC

local.isAtSameYearAs(utc); // true

```

Read more about [ISO week on Wikipedia](https://en.wikipedia.org/wiki/ISO_week_date)

## Creating your own Localization ➕

Extend `MomentLocalization` class to get started.

Almost everything is declared as function, so you can freely achieve the unique features of your language.

**I highly recommend copying one of the existing implementations then work on top of it!**

```dart
CatLanguage extends MomentLocalization {
  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) => "a two meow ago";

  @override
  String weekdayName(int i) => "Meowday #$i";

  @override
  String calendar(Moment moment, {Moment? reference, bool weekStartOnSunday = false, bool omitHours = false}) => "Last Meowday";

  /// Please refer to the [FormatterToken] enum for details.
  /// 
  /// It contains almost all of the tokens mentioned in https://momentjs.com/docs/#/parsing/string-format/
  Map<FormatterToken, FormatterTokenFn?> formats() => {};

  @override
  String languageCodeISO() => "meow";

  @override
  String endonym() => "Meow-meow meow";

  @override
  String locale() => "meow";

  @override
  String languageNameInEnglish() => "Cat tongue";
}
```

## Format Tokens 🔑

Encapsulate string in square brackets ([]) to escape.

| Type                      | Token  | Examples                               | Description                                                                                   |
| ------------------------- | ------ | -------------------------------------- | --------------------------------------------------------------------------------------------- |
| Month                     | M      | 1 2 ... 11 12                          |                                                                                               |
|                           | Mo     | 1st 2nd ... 11th 12th                  |                                                                                               |
|                           | MM     | 01 02 ... 11 12                        |                                                                                               |
|                           | MMM    | Jan Feb ... Nov Dec                    |                                                                                               |
|                           | MMMM   | January February ... November December |                                                                                               |
| Quarter of year           | Q      | 1 2 3 4                                |                                                                                               |
|                           | Qo     | 1st 2nd 3rd 4th                        |                                                                                               |
| Day of month              | D      | 1 2 ... 30 31                          |                                                                                               |
|                           | Do     | 1st 2nd ... 30th 31st                  |                                                                                               |
|                           | DD     | 01 02 ... 30 31                        |                                                                                               |
| Day of year               | DDD    | 1 2 ... 364 365                        |                                                                                               |
|                           | DDDo   | 1st 2nd ... 364th 365th                |                                                                                               |
|                           | DDDD   | 001 002 ... 364 365                    |                                                                                               |
| Day of week               | d      | 1 2 ...6 7                             | Moment.js uses \`0-6\`. However, we'll be using \`1-7\` to be in accordance with \[DateTime\] |
|                           | d\_o   | 1st 2nd ... 6th 7th                    | "do" is Dart language keyword                                                                 |
|                           | dd     | Mo Tu ... Sa Su                        |                                                                                               |
|                           | ddd    | Mon Tue ... Sat Sun                    |                                                                                               |
|                           | dddd   | Monday ... Saturday Sunday             |                                                                                               |
| Day of week (ISO)         | e      | 1 2 ... 6 7                            |                                                                                               |
| Week of year (ISO)        | w      | 1 2 ... 52 53                          |                                                                                               |
|                           | wo     | 1st 2nd ... 52nd 53rd                  |                                                                                               |
|                           | ww     | 01 02 ... 52 53                        |                                                                                               |
| Year                      | YY     | 70 71 ... 29 30                        |                                                                                               |
|                           | YYYY   | 1970 1971 ... 2029 2030                |                                                                                               |
| Era Year                  | y      | 1 2 ... 2020 ...                       |                                                                                               |
| Era                       | NN     | BC AD                                  | Abbr era name                                                                                 |
|                           | NNNN   | Before Christ, Anno Domini             | Full era name                                                                                 |
|                           | NNNNN  | BC AD                                  | Narrow era name                                                                               |
| Week year                 | gg     | 70 71 ... 29 30                        |                                                                                               |
|                           | gggg   | 1970 1971 ... 2029 2030                |                                                                                               |
| AM/PM                     | A      | AM PM                                  | UPPERCASE                                                                                     |
|                           | a      | am pm                                  | lowercase                                                                                     |
| Hour                      | H      | 0 1 ... 22 23                          |                                                                                               |
|                           | HH     | 00 01 ... 22 23                        |                                                                                               |
|                           | h      | 1 2 ... 11 12                          |                                                                                               |
|                           | hh     | 01 02 ... 11 12                        |                                                                                               |
|                           | k      | 1 2 ... 23 24                          |                                                                                               |
|                           | kk     | 01 02 ... 23 24                        |                                                                                               |
| Minute                    | m      | 0 1 ... 58 59                          |                                                                                               |
|                           | mm     | 00 01 ... 58 59                        |                                                                                               |
| Second                    | s      | 0 1 ... 58 59                          |                                                                                               |
|                           | ss     | 00 01 ... 58 59                        |                                                                                               |
| Fractional second         | S      | 0 1 ... 8 9                            |                                                                                               |
|                           | SS     | 00 01 ... 98 99                        |                                                                                               |
|                           | SSS    | 000 001 ... 998 999                    |                                                                                               |
|                           | SSSS   | 0000 0001 ... 9998,9999                |                                                                                               |
|                           | SSSSS  | 00000 00001 ... 99998,99999            |                                                                                               |
|                           | SSSSSS | 000000 000001 ... 999998,999999        |                                                                                               |
| Timezone                  | Z      | \-07:00 -06:00 ... +06:00 +07:00       |                                                                                               |
|                           | ZZ     | \-0700 -0600 ... +0600 +0700           |                                                                                               |
| Timezone name             | ZZZ    |                                        | Returns \[DateTime.timeZoneName\], result may not be consistent across platforms              |
| Unix timestamp in seconds | X      | 1654063960                             |                                                                                               |
| Unix timestamp            | x      | 1654063974620                          |                                                                                               |
| Localization Defaults     | l      | 9/4/1986                               | Date (in local format, shorter)                                                               |
|                           | L      | 09/04/1986                             | Date (in local format)                                                                        |
|                           | ll     | Sep 4 1986                             | Month name, day of month, year (shorter)                                                      |
|                           | LL     | September 04 1986                      | Month name, day of month, year                                                                |
|                           | lll    | Sep 4 1986 8:30 PM                     | Month name, day of month, year, time                                                          |
|                           | LLL    | September 04 1986 8:30 PM              | Month name, day of month, year, time                                                          |
|                           | llll   | Thu, Sep 4 1986 8:30 PM                | Day of week, month name, day of month, year, time (shorter)                                   |
|                           | LLLL   | Thursday, September 04 1986 8:30 PM    | Day of week, month name, day of month, year, time                                             |
|                           | LT     | 8:30 PM                                | Time (without seconds)                                                                        |
|                           | LTS    | 8:30:00 PM                             | Time (with seconds)                                                                           |


## TODO ✔️

- Add more localizations
- Implement parsing