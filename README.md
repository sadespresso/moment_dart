A Moment.js inspired package.

## Usage

```dart
import "package:moment_dart/moment_dart.dart";

/// If localization is omitted, it defaults to LocalizationEnUs
///
/// Localization argument takes [T extends Localization]. Localization is custom abstract class.  
final Moment moment = Moment(DateTime(2012, 12,21), LocalizationEnUs());
final Moment now = Moment.now();


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

- LocalizationEnUs
- LocalizationMongolianCyrillic
- LocalizationMongolianTraditional

## Creating own Localzation

First, extend the Localization abstract class.

Almost everything is declared as function, so you can freely achieve the unique features of your language.

```dart
  LocalizationMyCustomLanguage extends Localization {
    @override
    String relative(Duration duration, [bool dropPrefixOrSuffix = false]) => "a time to drink a soda ago";

    @override
    String weekdayName(int i) => "Happyday";

    @override
    String calendar(Moment moment, {Moment? reference, bool weekStartOnSunday = false, bool omitHours = false}) => "Last Sunday";

    /// Please refer to the [FormatterToken] enum for details.
    /// 
    /// It contains almost all of the tokens mentioned in https://momentjs.com/docs/#/parsing/string-format/
    Map<FormatterToken, FormatterTokenFn?> formats() => {};

    @override
    String localizationDefaultDateFormat() => "MM/DD/yyyy";

    @override
    String localizationDefaultHourFormat() => "hh:mmA";
  }
```