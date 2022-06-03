A Moment.js inspired package.

## Usage

### Import the package

```dart
import "package:moment_dart/moment_dart.dart";
```

### Create Moment instance

```dart
final Moment now = Moment.now();

final Moment epoch = Moment(DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true));

final Moment derived = DateTime(2003,06,01).toMoment();
```

### Enjoy!

```dart
final Moment moment = Moment.now() - Duration(days: 1); // May 14, 2022

moment.calendar(); // Yesterday

moment.fromNow(); // a day ago

// You can omit the prefix/suffix by setting the optional argument to true.
moment.fromNow(true); // a day

moment.from(moment - Duration(days: 365)); // a year ago

/// Unmatched strings will be left as is.
moment.format("YYYY년 MMMM Do dddd hh:mma"); // 2022년 May 14 Saturday 08:09pm

/// Also, escape strings by encapsulating them in square brackets ([]). 
moment.format("YYYY [YYYY] MMMM [MMMM] Do [Do] LT A [A]"); // 2022 YYYY June MMMM 3 Do 6:36 PM A
```

### Change localization
When localization is omitted, it defaults to English (United States)
```dart
final Moment hangulday = Moment(DateTime(2022,10,9), localization: MomentLocalizations.ko());

hangulday.format("ll"); // 2022년 10월 9
hangulday.format("LL"); // 2022년 10월 9
```

You can also take advantage of localization, as it's kinda the main character
```dart
final MomentLocalization localization = MomentLocalizations.enUS();

localization.relative(const Duration(seconds: 2)); //in a few seconds
localization.weekdayName(yesterday.weekday); // "Monday"
```

### Formatting

```dart
  /// All non-token characters will be left as is
  moment.format("YYYY년 MMM Do ddd A hh:mm"); // 2022년 6월 1일 수요일 오후 02:44
```

**Tokens:**

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

### Moment introduces a extension with few helpful functions.

**Can be called on `Moment` or `DateTime` instance**

```dart
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

Read more about [ISO week on Wikipedia](https://en.wikipedia.org/wiki/ISO_week_date)

## Creating your own Localzation

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

## Available Localization classes:

Localizations are classes that extend `MomentLocalization`

- LocalizationEnUs (English - United States) [en_US]
- LocalizationKorean (Korean) [ko]
- LocalizationGermanStandard (German) [de_DE]
- LocalizationMongolianCyrillic (Mongolian) [mn]
  - LocalizationMongolianTraditional (Mongolian) [mn]
  - LocalizationMongolianTraditionalNumbers (Uses traditional Mongolian numbers)

## TODO

- Add more localizations
- String escaper in `Moment.format()`
- Implement parsing string produced from `Moment.format($)`