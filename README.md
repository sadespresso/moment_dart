[![pub package](https://img.shields.io/pub/v/moment_dart.svg)](https://pub.dartlang.org/packages/moment_dart)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![All Contributors](https://img.shields.io/github/all-contributors/sadespresso/moment_dart?color=ee8449&style=flat-square)](#contributors)

> Inspired by moment.js

## Features

Convert `DateTime` to human-readable text ✅
  - [Relative duration](#relative-durations)
  - [Precise duration](#precise-durations)
  - [Calendar text](#calendar-dates)
  - [Formatted dates](#formatting)
  - [Multiple localizations](#changing-localization-)

Play with DateTime objects 😎
  - [Start of year/month/.../millis](#start-of-yearmonthmoment)
  - [Find last or next weekday](#find-lastnext-weekday)
  - [Is same year/month/.../moment as](#is-same-unit-as)

Handful of other useful extension/functions

## Demo 👁️

### [🔗 A Flutter web demo](https://theironbatka.github.io/moment_dart_demo/#/)

## Getting started ✨

Import the package
```dart
import 'package:moment_dart/moment_dart.dart';
```

Setting global localization
```dart
Moment.setGlobalLocalization(MomentLocalizations.fr()); 

// Any new instances created after setting global localization will have that localization

Moment.now().LL; // 15 janvier 2023
```

Create Moment instance

```dart
// >>> In this example, local timezone is UTC+8 <<<

final now = Moment.now();

final epoch = Moment.fromMillisecondsSinceEpoch(0, isUtc: true);

/// Using extension (DateTime.toMoment())
final bday = DateTime(2003, 6, 1, 5, 1).toMoment();
/// or from [DateTime]
final bday2 = Moment(DateTime(2003, 6, 1, 5, 1));
```

Please note that `Moment` is subclass of `DateTime`. (It is **immutable**, like its superclass)
```dart
final now = Moment.now();

assert(now is DateTime); // true
assert(now is Moment); // true
```

## Usage 🌿

### Relative durations

```dart
// >>> In this example, local timezone is UTC+8 <<<

Moment yesterday = Moment.now() - Duration(days: 1, hours: 2); // -26 hours
Moment in2h47m =
    Moment.now() + Duration(hours: 2, minutes: 47, seconds: 15);
Moment fourWeeksAgo = Moment.now() - Duration(days: 28);

// You can omit prefix/suffix, or change forms
yesterday.fromNow(
  dropPrefixOrSuffix: true,
  form: UnitStringForm.full,
); // a day
in2h47m.fromNow(form: UnitStringForm.mid); // in 3 hr
fourWeeksAgo.fromNow(form: UnitStringForm.short); // 1mo ago
```

### Precise durations

Exact same example as above, but precise duration strings

```dart
// >>> In this example, local timezone is UTC+8 <<<

Moment yesterday = Moment.now() - Duration(days: 1, hours: 2);
Moment in2h47m =
    Moment.now() + Duration(hours: 2, minutes: 47, seconds: 15);
Moment fourWeeksAgo = Moment.now() - Duration(days: 28);

// You can omit prefix/suffix, or change forms
String s1 = yesterday.fromNowPrecise(
  dropPrefixOrSuffix: true,
  form: UnitStringForm.full,
); // a day
String s2 = in2h47m.fromNowPrecise(form: UnitStringForm.mid); // in 2 hr 47 min
String s3 = fourWeeksAgo.fromNowPrecise(
  form: UnitStringForm.short,
  includeWeeks: true,
); // 4w ago
```

OR you can use it on `Duration` objects

```dart
Duration(days: 67, hours: 3, minutes: 2).toDurationString(
  MomentLocalizations.de(),
  form: UnitStringForm.mid,
); // in 2 Mo. 7 Tg.

// EPOCH
Duration(microseconds: DateTime.now().microsecondsSinceEpoch).toDurationString(
  MomentLocalizations.es(),
  format: DurationFormat.all,
  round: false,
  omitZeros: false,
); // en 52 años 11 meses 9 días 10 horas 53 minutos 53 segundos
```

### Calendar dates
```dart
// >>> In this example, local timezone is UTC+8 <<<
final now = Moment.now(); // Today at 10:02AM

now.subtract(const Duration(days: 1)).calendar(); // Yesterday at 10:02AM
now.calendar();                                   // Today at 10:02AM
now.subtract(const Duration(days: 1)).calendar(); // Tomorrow at 10:02AM

// [reference] - defaults to Moment.now(), acts as an anchor.
// [omitHours] - omits the hour part. Hour part is formatted by "LT" token.
now.calendar(
  reference: (now - const Duration(days: 1)),
  omitHours: true,
); // Tomorrow
```

### Start of year/month/.../moment
```dart
// >>> In this example, local timezone is UTC+8 <<<
final Moment tada =
      DateTime(2022, 6, 19, 21, 9, 33).toMoment(); // June 19 2022 09:09 PM

tada.startOf(DurationUnit.day); // June 19 2022 12:00 AM
// OR
tada.startOfDay(); // June 19 2022 12:00 AM
```

### Find last/next weekday

**Works on `DateTime` and `Moment`**

⚠️ Do check whether your `DateTime` is in local timezone

```dart
// >>> In this example, local timezone is UTC+8 <<<

final Moment tada =
      DateTime(2022, 6, 19, 21, 9, 33).toMoment(); // June 19 2022 09:09 PM

tada.nextMonday(); // June 20 2022 09:09 PM

tada.lastMonday(); // June 13 2022 09:09 PM
```

⚠️ Note that ***this Sunday*** is neither last or next Sunday

```dart
tada.lastSunday(); // June 12 2022 09:09 PM
```

### Is same **unit** as

**Works on `DateTime` and `Moment`**


```dart
// >>> In this example, local timezone is UTC+8 <<<

final DateTime otherBday = DateTime(2003,6,19);
final Moment spiritRoverOnMars = DateTime(2003,6,10).toMoment();

otherBday.isAtSameMonthAs(spiritRoverOnMars); // true
otherBday.isAtSameYearAs(spiritRoverOnMars); // true
```

⚠️ It assumes that both `DateTime` is in same timezone

```dart
// >>> In this example, local timezone is UTC+8 <<<

final DateTime bday = DateTime(2003,6,1,5,33); // 2003-05-31 21:33:00.000Z (Local time zone was GMT+08:00)
final Moment spiritRoverOnMars = DateTime(2003,6,10).toMoment(); // 2003-06-09 16:00:00.000Z

bday.isAtSameMonthAs(spiritRoverOnMars); // false; didn't happen in same month. In UTC+8 timezone, bday was in May, Spirit Rover landed in June.
bday.isAtSameYearAs(spiritRoverOnMars); // true
```

## Formatting
[See list of format tokens](#format-tokens-)

```dart
now.format("YYYY MMMM Do - hh:mm:ssa");   //2003 June 1st - 05:01:00am
now.format("LTS", true);                  //5:01:00 AM (Converted to Local first)
now.format("dddd");                       //Sunday
DateTime.now().format("MMM Do YY", true); //Jun 1st 03 (Converted to Local first)
```

Escape strings by **encasulating them in square brackets ([])**.

```dart
epoch.format("YYYY [YYYY] MMMM [MMMM] Do [Do] LT [A]"); // 1970 YYYY January MMMM 1st Do 12:00 AM A
```

Alternatively, unmatched tokens will be left as is

```dart
epoch.format("YYYY년 MMM D일 ddd A h:mm"); // 1970년 1월 1일 목 오전 8:00 (Localization: KO)
```

There are functions for few commonly used formatters
```dart
// Shorthands

moment.formatDate(); // LL
moment.formatDateShort(); // ll
moment.formatDateTime(); // LLL
moment.formatDateTimeShort(); // lll
moment.formatDateTimeWithWeekday(); // LLLL
moment.formatDateTimeWithWeekdayShort(); // llll
moment.formatTime(); // LT
moment.formatTimeWithSeconds(); //LTS 

// OR formatter token as getter

moment.LL;
moment.ll;
moment.LLL;
moment.lll;
moment.LLLL;
moment.llll;
moment.LT;
moment.LTS;
```

### Parsing
Currently uses `DateTime.parse()`

> ***COMING SOON 💫***

## Changing localization 🌐
Localization defaults to `MomentLocalizations.enUS()`

```dart
final Moment hangulday2022 = Moment(DateTime(2022,10,9), localization: MomentLocalizations.ko());

hangulday2022.format("ll"); // 2022년 10월 9일
hangulday2022.LL; // 2022년 10월 9일 (same as Moment.format("LL"))
hangulday2022.formatTime(); // 오전 12:00 (same as Moment.format("LT"))
```

## Available Localization classes:

Localizations are classes that extend `MomentLocalization`

[See how you can create your own localization](#creating-your-own-localization-)

| Class                | LCID       | Language                                       | Country       |
| -------------------- | ---------- | ---------------------------------------------- | ------------- |
| LocalizationEnUs     | en_US      | English                                        | United States |
| LocalizationKoKr     | ko_KR      | Korean                                         | South Korea   |
| LocalizationFrFr     | fr_FR      | French                                         | France        |
| LocalizationEsEs     | es_ES      | Spanish                                        | Spain         |
| LocalizationItIt     | it_IT      | Italian                                        | Italy         |
| LocalizationDeDe     | de_DE      | German                                         | Germany       |
| LocalizationMnMn     | mn_MN      | Mongolian                                      | Mongolia      |
| LocalizationMnMongMn | mn_Mong_MN | Traditional Mongolian                          | Mongolia      |
| LocalizationMnQaaqMn | mn_Qaaq_MN | Traditional Mongolian with Traditional Numbers | Mongolia      |

## Batteries included 🔋

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
// >>> In this example, local timezone is UTC+8 <<<

final DateTime local = DateTime(1972, 1, 1, 7); // Jan 1, 1972 at 7AM @GMT+8
final DateTime utc = local.toUtc();             // Dec 31, 1971 at 11PM @UTC

local.isAtSameYearAs(utc); // false; ⚠️ This will be different depending on the local timezone offset

```

Read more about [ISO week on Wikipedia](https://en.wikipedia.org/wiki/ISO_week_date)

## Creating your own Localization ➕

Extend `MomentLocalization` class to get started.

Almost everything is declared as function, so you can freely achieve the unique features of your language.

**I highly recommend copying one of the existing implementations then work on top of it!**

```dart
import 'package:moment_dart/src/formatters/token.dart';
import 'package:moment_dart/src/calendar.dart';
import 'package:moment_dart/src/localizations.dart';

class LocalizationEnMeowKC extends MomentLocalization {
  @override
  CalenderLocalizationData get calendarData => CalenderLocalizationData(
        keywords: CalenderLocalizationKeywords(
          at: (date, time) => "meow $time",
          lastWeekday: (weekday) => "Last meow $weekday",
          nextWeekday: (weekday) => weekday,
        ),
        relativeDayNames: {
          -1: "Yestermeow",
          0: "Meowday",
          1: "Tomeowow",
        },
      );

  @override
  String? get countryCode => "KC"; // Kingdom of Cats

  @override
  String get endonym => "Meow!";

  @override
  String get languageCode => "en";

  @override
  String get languageNameInEnglish => "Meowlish!";

  @override
  String get locale => "en_Meow_KC"; // You may want to override this one

  @override
  Map<FormatterToken, FormatterTokenFn?> overrideFormatters() => {
        // Localization aware formats - Highly recommend implementing these :)
        FormatterToken.L: (dateTime) => reformat(dateTime, "YYYY/MM/DD"),
        FormatterToken.l: (dateTime) => reformat(dateTime, "YYYY/M/D"),
        FormatterToken.LL: (dateTime) =>
            reformat(dateTime, "MMMM D, [meow] YYYY"),
        FormatterToken.ll: (dateTime) =>
            reformat(dateTime, "MMM D, [meow] YYYY"),
        FormatterToken.LLL: (dateTime) =>
            reformat(dateTime, "MMMM D, [meow] YYYY, HH:mm [meow!]"),
        FormatterToken.lll: (dateTime) =>
            reformat(dateTime, "MMM D, [meow] YYYY, HH:mm [meow!]"),
        FormatterToken.LLLL: (dateTime) =>
            reformat(dateTime, "dddd, MMMM D, [meow] YYYY, HH:mm [meow!]"),
        FormatterToken.llll: (dateTime) =>
            reformat(dateTime, "ddd, MMM D, [meow] YYYY, HH:mm [meow!]"),
        FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
        FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
      };

  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) =>
      "(in) Meow $duration (ago)";

  @override
  Map<int, String> get weekdayName => {
        DateTime.monday: "Meowday #1",
        ...,
        DateTime.sunday: "Meowday #7",
      };
}
```


You may want to use mixins to make your experience easier. Take a look at other localization implementations, but I'll provide an example anyways:

```dart
class MewLocale extends MomentLocalization with Ordinal, MonthNames {
  /* ... folded code ... */

  @override
  Map<int, String> get monthNames => {
    DateTime.january: "Janmeow",
    ...,
    DateTime.december: "Decemeow",
  };

  @override
  Map<int, String> get monthNamesShort => monthNames.map((key, value) => MapEntry(key, value.substring(0,3)));

  @override
  String ordinalNumber(int n) => "meow $nº";

  @override
  Map<FormatterToken, FormatterTokenFn?> overrideFormatters() => {
        // From [EnglishLikeOrdinal] mixin
        ...formattersWithOrdinal, // Provided by mixin `Ordinal`
        // From [MonthNames] mixin
        ...formattersForMonthNames, // Provided by mixin MonthNames
        
        /* Other formatters */
      };
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

## Contributing

Contributions of any kind are welcome! Please refer to [CONTRIBUTE.md](CONTRIBUTE.md)

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

## TODO ✔️

- [ ] Add more localizations
- [ ] Implement parsing
- [ ] Have documentation and cut this README.md file some slack