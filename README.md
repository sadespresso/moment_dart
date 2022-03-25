A Moment.js inspired package.

## Usage

```dart

import "package:moment_dart/moment_dart.dart";

/// If localization is omitted, it defaults to LocalizationEnUs
///
/// Localization argument takes [T extends MomentLocalization]. MomentLocalization is custom abstract class.  
final Moment moment = Moment.now() - Duration(days: 1);
final Moment epoch = Moment(DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true));
final Moment epochPlusFiveDays = epoch + Duration(days: 5);
final Moment epochPlusAYear = epoch + Duration(days: 365);


localization.relative(const Duration(seconds: 2); //in a few seconds
localization.weekdayName(epoch.weekday); // "Thursday"
epochPlusFiveDays.from(epoch, true), "5 days"
epochPlusFiveDays.from(epoch), "in 5 days"
epoch.calendar(reference: epochPlusFiveDays, omitHours: true), "Last Thursday"
epochPlusFiveDays.calendar(reference: epoch, omitHours: true), "Tuesday"
epochPlusAYear.from(epoch), "in a year"
epochPlusAYear.calendar(reference: epoch), "01/01/1971 at 12:00AM"


/// Returns relative string, such as `Yesterday`, `Last Sunday`, or default date format concatenated with default hour format.
///
/// You can omit the hours using [omitHours] argument.
///
/// [reference] is `Moment.now()` by default.
moment.calendar();

/// Example when using [LocalizationEnUs]:
///
/// If [this] is yesterday, will result `"a day ago"`
///
/// If [this] is tomorrow, will result `"in a day"`
///
/// moment.js's `toNow()` function has been omitted, since this function prefixes/suffixes appropriately.
moment.fromNow();

/// Unimplemented
moment.format();
```

### Available Localization classes:

Localizations are classes that extend `MomentLocalization`

- LocalizationEnUs
- LocalizationMongolianCyrillic
- LocalizationMongolianTraditional
- LocalizationMongolianTraditionalNumbers

## Creating own Localzation

First, extend the Localization abstract class.

Almost everything is declared as function, so you can freely achieve the unique features of your language.

```dart
  CatLanguage extends MomentLocalization {
    @override
    String relative(Duration duration, [bool dropPrefixOrSuffix = false]) => "a two meow ago";

    @override
    String weekdayName(int i) => "Meowday";

    @override
    String calendar(Moment moment, {Moment? reference, bool weekStartOnSunday = false, bool omitHours = false}) => "Last Meowday";

    /// Please refer to the [FormatterToken] enum for details.
    /// 
    /// It contains almost all of the tokens mentioned in https://momentjs.com/docs/#/parsing/string-format/
    Map<FormatterToken, FormatterTokenFn?> formats() => {};

    @override
    String localizationDefaultDateFormat() => "MM/DD/yyyy meow!"; // "meow!" token doesn't exist, therefore the resulting string would be "06/01/2003 meow!".

    @override
    String localizationDefaultHourFormat() => "hh:mmA meow!";
  }
```