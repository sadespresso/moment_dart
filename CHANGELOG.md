## 1.0.0

> Features **breaking changes**
- Now requires Dart v2.19.4
- Added {reference} argument to `ComplexCalendar` methods
  - This fixes incorrect results of localizations that use `ComplexCalender` (i.e., zh_CN, it_IT)
- Renamed `LocalizationKo` to `LocalizationKoKr` for consistency
- Removed deprecated methods
- Removed `weekStart` from `Moment().calendar()` as it's not used. I don't know why I put it there, I don't drink alcohol, maybe I was just tired I guess
- Added `DateTimeConstructors.nowWithTimezone` constructor
  - `Moment().fromNow()` and `Moment.fromNowPrecise()` now matches timezone with `this`. Meaning, anchor will be set to UTC timezone if `this` is in UTC timezone
  - `Moment().calendar()` now matches timezone with `this`. Meaning, anchor will be set to UTC timezone if `this` is in UTC timezone
- `DateTimeConstructors.withTimezone` now requires `isUtc` as a positional argument
- Added getter `Moment().hasExplicitLocalization` to check if that instance have any explicit localization
- Added Japanese localization
- Bugfixes
  - `.startOf*` now returns correct timezone **DateTime**
  - [zh-CN] fixed **this week** was wrongly displayed as **last week** in `Moment().calendar()`

## 1.0.0-rc.1

> Features **breaking changes**
- Added {reference} argument to `ComplexCalendar` methods
  - This fixes incorrect results of localizations that use `ComplexCalender` (i.e., zh_CN, it_IT)
- Renamed `LocalizationKo` to `LocalizationKoKr` for consistency
- Removed deprecated methods
- Removed `weekStart` from `Moment().calendar()` as it's not used. I don't know why I put it there, I don't drink alcohol, maybe I was just tired I guess
- Added `DateTimeConstructors.nowWithTimezone` constructor
  - `Moment().fromNow()` and `Moment.fromNowPrecise()` now matches timezone with `this`. Meaning, anchor will be set to UTC timezone if `this` is in UTC timezone
  - `Moment().calendar()` now matches timezone with `this`. Meaning, anchor will be set to UTC timezone if `this` is in UTC timezone
- `DateTimeConstructors.withTimezone` now requires `isUtc` as a positional argument
- Added getter `Moment().hasExplicitLocalization` to check if that instance have any explicit localization
- Added Japanese localization
- Bugfixes
  - `.startOf*` now returns correct timezone **DateTime**
  - [zh-CN] fixed **this week** was wrongly displayed as **last week** in `Moment().calendar()`

## 0.18.1

- `DateTime.isSameLocalWeekAs()` now uses default localization's week start if `weekStart` is omitted. Closes #11

## 0.18.0

- `differenceInDays` no longer forces local timezone
- Added `date` getter, returns Date with hours, minutes, etc set to 0.
- Added new constructor: `DateTimeConstructors.dateWithTimezone`

## 0.17.5

- Calendar now accepts `DateTime` as reference
- Documentation work has begun.
  - See [docs](https://dev.gege.mn/moment_dart_docs)
  - See [repo on GitHub](https://github.com/sadespresso/moment_dart_docs)

## 0.17.4

- Fixed extensions, and operations copying default localization when the instance had no explicit localization

## 0.17.3

- `Moment.endOfLocalWeek()` and `Moment.startOfLocalWeek()` now accepts `weekStart` override, like `DateTime.~` counterparts

## 0.17.2

- Fixed [#10](https://github.com/sadespresso/moment_dart/issues/10)

## 0.17.1

- Fixed [#9](https://github.com/sadespresso/moment_dart/issues/9)
- **mn_MN**, **mn_Mong_MN**, **mn_Qaaq_MN** locales now use `HH` instead of `H` in `LT`, `LTS` formatters
- Added 3 extension getter for `Moment` and `DateTime` objects.
  - `.hour12`
  - `.isAm`
  - `.isPm`

## 0.17.0

- Fixed `Moment.format()`
- Corrected Chinese language code (zn -> zh)

## 0.16.0

> This release has breaking changes!
- `Duration().toDurationString()` first argument is now **named**, and ***optional***. When null, uses global localization set using `Moment.setGlobalLocalization(MomentLocalization)`
- Now `weekStart` of `DateTime().startOfLocalWeek([int weekStart])` is nullable, and defaults to `Moment.defaultLocalization.weekStart`
- Now `weekStart` of `DateTime().endOfLocalWeek([int weekStart])` is nullable, and defaults to `Moment.defaultLocalization.weekStart`

## 0.15.0

- Now it's possible to set global localization with `Moment.setGlobalLocalization(MomentLocalization)`
- Renamed `Moment.localization` to `Moment._localization`, making it private, and nullable. However, this shouldn't be breaking change as `Moment.localization` getter is introduced. Getter returns instances' localization, or global localization in case the instance doesn't have set localization

## 0.14.0

> This release has breaking changes!
- [BREAKING] moment.format("YY") now **no longer throws exception** when year doesn't fall in range (1970, 2030). Instead, it returns full year. e.g., `DateTime(1969).format("YY"); // 1969`
- [BREAKING] moment.format("gg") now **no longer throws exception** when ISO week year doesn't fall in range (1970, 2030). Instead, it returns full year. e.g., `DateTime(1969).format("gg"); // 1969`
- [BREAKING] `DateTime.format(...)` now expect named arguments instead of optional positional arguments

## 0.13.0

> This release has breaking changes!
- [BREAKING] `endOf_()` and `startOf_()` now _preserves_ the timezone instead of always returning local `DateTime` object
- `endOf(DurationUnit.microsecond)` and `startOf(DurationUnit.microsecond)` now returns `this.clone()` instead of throwing error

## 0.12.0

> This release has breaking changes!
- [BREAKING] `isAtSameUnit___As(other)` now doesn't take timezones into account. If you want the old behaviour, use `isAtSameUnit___As(other, enforceUTC: true)`
- [BREAKING] Renamed `MomentLocalizations.deDE()` to `.de()`
- [BREAKING] Removed `Moment().elapsed()` for sake of `Moment().fromPrecise()`
- [BREAKING] Now `startOf_()` and `endOf_()` no longer converts to local timezone. It just "assumes" it is in local timezone.
- All localizations are now lazy-loaded Singletons

## 0.11.0

- Calendar no longer includes time when the date is too distant (distant that it's formatted with 'l' token)
- Added localization `zn_CN`
- Added `DateTime.startOfLocalWeek(int weekStart)`, `Moment.startOfLocalWeek()`, endOf counterparts

## 0.10.5

- Fixed am/pm suffixes for `mn_Mong_MN` and `mn_Qaaq_MN`

## 0.10.4

- isSameAs_() functions timezone now depend on `other` argument. If `other` is UTC, `this` will be converted to UTC, else `this` will be adjusted with `other.timeZoneOffset`

## 0.10.3

- Added `.format()` and other functions as extension on `DateTime` objects
- `.format()` now takes another optional argument `forceLocal`, to convert the DateTime before formatting.

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
