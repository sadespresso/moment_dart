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
