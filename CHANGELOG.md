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
