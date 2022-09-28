## 0.10.2

- Fixed endOfMonth() having extra days

## 0.10.1

- Fixed duration suffix in `mn_MN`, `mn_Mong_MN`, `mn_Qaaq_MN`

## 0.10.0

- Introduced concept of `UnitString`, a wrapper class for unit translations. For example, UnitString for minute may look like "19 minutes", "19 min", "19m" depending on the `UnitStringForm` (full, mid, short respectively)
  - `Moment.from(...)` and `Moment.fromNow(...)` now takes `form` argument, which can alter the output. Defaults to `UnitStringForm.full`
- Introduced `Moment.fromPrecise(...)`, `Moment.fromNowPrecise(...)`, `Moment.duration(...)` for more precise durations
- German (de_DE) relative duration now shows correct forms when prefixes/suffixes are omitted
- Removed deprecated functions

## 0.9.0+1

- Added en_US in MomentLocalizations.locales

## 0.9.0

- Added demo. [Check it out](https://theironbatka.github.io/moment_dart_demo/#/)
- Localization
  - Renamed all localization files to their corresponding localization ID
  - Renamed all localization classes to their corresponding localization ID
  - Added static method `MomentLocalizations.byLanguage()` and `MomentLocalizations.byLocale()`
- Fixed Italian localization data

## 0.8.2+1

- Updated README.md

## 0.8.2

- Added static method `Moment.tryParse()`

## 0.8.1

- Added `.differenceInDays(other)` function
- *`DurationExtra`* extension on `Duration`
- Added new locale: Italian (it) (Italy)
- Refactored relative times in Indo-European languages, and bunch of other stuff

## 0.8.0

- `MomentLocalization` has gotten major updates, making it easier to implmement new localizations:
  - No longer requires to override `.calendar(...)`
  - Requires to override these new functions/getters: `calendarData`, `weekdayName`, `overrideFormatters`
  - Restructured formatters. No need to override formatter for every `FormatterToken`
- Removed following deprecated methods: `Moment.lastMondayAsDateTime()`, `Moment.lastSundayAsDateTime()`
- Implemented `.endOf(DurationUnit unit)`, and it's children `.endOf~~~()`. Works on both `Moment` and `DateTime`
- Added new locales: 
  - Spanish (es) (Spain)
  - French (fr) (France)
- Minor changes:
  - No longer produces debug stdouts, deprecating `enableDebugPrint()`

## 0.7.3

- Added shorthand function for commonly used tokens. For example, moment.LT, moment.LTS, moment.L, etc.

## 0.7.2

- Updated `README.md`

## 0.7.1

- `Moment.format()` no longer has required positional argument. Optional positional argument defaults to `l`;

## 0.7.0

- ***IMPORTANT CHANGE***: Now `Moment` extends `DateTime` class
- ***IMPORTANT CHANGE***: Now targets Dart version 2.17.0 and above
- Implemented 6 operators (+, -, <, <=, >=, >) for `DateTime` and `Moment`. Part of MomentBenefits extension
- Implemented `.lastWeekday(int weekday)`, and it's children `.lastMonday()`, `.lastTuesday()`, ..., `.lastSunday()`. You can also do same thing to find future weekdays. For example, `.nextMonday()`. Works on both `Moment` and `DateTime`
- Implemented `.startOf(DurationUnit unit)`, and it's children `.startOf~~~()`. Works on both `Moment` and `DateTime`

## 0.6.2

- Now Mongolian singular units include number `1` as nature of the language is not similar to English. For example, `минутын өмнө` => `1 минутын өмнө`
- Mongolian script with Mongolian numbers (`mn_TM_tn`)'s `.relative(-)` now uses Mongolian numbers

## 0.6.1

- Fixed Mongolian `mn_MN` and Mongolian Script `mn_TM` suffixes

## 0.6.0+2

- Updated README.md

## 0.6.0+1

- Updated README.md

## 0.6.0

- Added comparison functions (`isAtSame_As(other)`)
- Removed unwanted console logs
- Updated README.md

## 0.5.0

- Now it's possible to escape strings in `Moment.format()`. Encapsulate the text in square brackets ([]) to do so.
- Fixed calendar relative week miscalculations
- Changed localization default date format from `L` to `l` (shortened version)

## 0.4.2

- Fixed number word gender-dependent suffix in Mongolian languages. (`mn_MN`, `mn_MN` traditional mongolian)

## 0.4.1

- Made major fixes in `de_DE` localization
- Implemented all `DateTime` functions in `Moment` class
- Implemented `MomentBenefits` extension functions in `Moment` class

## 0.4.0

- Exposed localizations' classes
- Fixed Yesterday/Tomorrow calculation. It was horrible :(((
- Other major fixes in localizations

## 0.3.0

- Now localizations are listed as static functions in `MomentLocalizations` class. Providing easier access
- Made fixes in `ko_KO`, `de_DE` localizations
- Includes endonym, language code, locale, English name in localization classes

## 0.2.0+2

- No longer prints the matched tokens

## 0.2.0

- Removed debug prints when using `.format(String payload)`. You can re-enable it by calling `.enableDebugPrint()` on the Moment instance
- Exposed experimental **Korean** (ko_KO), **German** (de_DE) localizations
- Added **localization aware formatters**: L, LL, LLL, LLLL, LT, LTS
- Removed `localizationDefaultDateFormat()`, `localizationDefaultHourFormat()` from `MomentLocalization` in favor of **localization aware formatter**
- Revised some localizations

## 0.1.5

- Added MomentBenefits extenstion usage on README
- Testing on MomentBenefits extension
- Bugfixes
  
## 0.1.4+1

- Exposed the `MomentLocalization`

## 0.1.4

- Exposed the localization in `Moment` class
- Added `DateTime.toMoment({MomentLocalization: localization})` function as extension on `DateTime`

## 0.1.3+1

- Exported localizations to `localizations/all.dart`, and exposed it in the main file

## 0.1.3

- Started work of Korean (ko_KO) and German (de_DE) localizations
- Renamed `Localization` to `MomentLocalization` for the sake of universe

## 0.1.2

- Improved `Moment.format` tokenization
- `Moment.calender` now allows `customFormat`, which can be used instead of the localization's default format.
- Fixes

## 0.1.1

- Fixed `Moment.format` function
- Fixed negative sign appearing in relative date texts

## 0.1.0

- Initial beta release.
