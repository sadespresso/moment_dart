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
-----

### Use it!
```dart
final Moment moment = Moment.now() - Duration(days: 1); // May 14, 2022

moment.calendar(); // Yesterday

moment.fromNow(); // a day ago

// You can omit the prefix/suffix
moment.from(moment - Duration(days: 365), true); // a year

/// Unmatched strings will be left as is.
moment.format("YYYY년 MMMM Do dddd hh:mma"); // 2022년 May 14 Saturday 08:09pm
```

### Change localization
When localization is omitted, it defaults to English (United States)
```dart
final Moment hangulday = Moment(DateTime(2022,10,9), localization: MomentLocalizations.ko());

hangulday.format("ll"); // 2022년 10월 9
```

You can also take advantage of localization, as it's kinda the main character
```dart
final MomentLocalization localization = MomentLocalizations.enUS();

localization.relative(const Duration(seconds: 2)); //in a few seconds
localization.weekdayName(yesterday.weekday); // "Monday"
```

### Even if you don't use moment, you can use MomentBenefits extension by importing the package :)

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

First, extend the Localization abstract class.

Almost everything is declared as function, so you can freely achieve the unique features of your language.

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
- Implement parsing string produced from `Moment.format($)`