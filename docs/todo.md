# To-do

Open items from the 2026-11-20 maintenance pass (6.0.0). None of these are started.

## API

- Inconsistencies left for a later major: `Moment.startOfThisHour()` and the
  other static helpers return `DateTime`, not `Moment`; `includeWeeks`
  defaults to `false` in `duration()` but `true` in `fromPrecise`; `format`
  takes positional arguments on `Moment` but named ones on `DateTime`;
  `copyWith(localization: null)` can't clear the localization; the
  `setLocalization` getter reads like a setter.

## Wording and grammar

- `SimpleDuration` never reads `delimeterConnector`, so no localization gets
  an "and" before the last unit (es_ES sets "y").
- `mn_Mong_MN` narrowest day abbreviation "3ᠥ" copies Cyrillic ө; the word
  ᠡᠳᠦᠷ starts with ᠡ. Owner unsure (rarely used).
- `ar_PS` future prefix: CLDR uses "خلال", moment.js "بعد". Kept "خلال".
- `ru_RU`: for a weekday earlier in the current week moment says
  "В понедельник", not "В прошлый понедельник"; `lastWeekday` only gets the
  weekday name, so it needs `ComplexCalendar`.
- Base `range()` still ignores `useRelative` for open-ended ranges.

## Bugs found while writing the 6.0 docs (2026-11-21)

- `rangeToMax()` on a UTC date fails the `CustomTimeRange` same-timezone
  assert in debug builds: it pairs the date with the local
  `Moment.maxValue`. `DateTime.utc(2024).rangeToMax()` reproduces it.
- `TimeRange.tryParse` calls `print` when a short-form string fails to parse.
- `encodeShort()` of a local range stores an instant, so it decodes to a
  different day or year in another timezone; `encode()` keeps wall-clock time.
- Week ranges subclass `CustomTimeRange`: `toCustom()` returns the week
  unchanged and a `CustomTimeRange()` switch case catches weeks.
- `calendar(customFormat:)` never shows the time, even for Today/Yesterday.
- Weekday finders' assert accepts 0..7 (0 acts as Sunday); release builds
  don't check at all.
- `byLocale("zh_TW")` / `"zh-Hant-TW"` falls back to `zh_CN` (Simplified).
- `complex_calendar.dart` redeclares `CalendarKeyword*String` typedefs with
  different signatures than the exported ones in `calendar.dart`.
- Only `FormatSet`/`FormatSetOptional` are exported; the mixins, `UnitString`
  and `SimpleRangeData` still need `src/` imports, so the CHANGELOG line
  "custom localizations don't need to import `src/`" overstates it.
- `Moment` has `LL`, `ll`, ... getters but no `L` getter.

## Stale doc comments

- `isSameLocalWeekAs` says `weekStart` defaults to Monday; it uses the global
  localization's week start.
- `endOf` mentions `startOf(DurationUnit.week)`; `endOfIsoWeek` and
  `DateTime.endOfLocalWeek` say "Returns start of".
- `rangeToMax` repeats the swap note from `rangeTo`.
- `timeZoneFormatted` claims "GMT-6"; it returns `-06:00`.
- Relative finders say "Assumes [this] is in local timezone"; they keep
  whichever timezone they're given.
- `FormatterToken.y` says "Unimplemented by default"; it's implemented.
- `DurationFormat.hm` is described as "minute(s) second(s)".
- The `Moment` class example output "Thursday, January 1 1970 00:00 AM" is
  out of date.
- CHANGELOG 6.0.0 doesn't mention that "a year" now starts at 315 days
  (was 320), and "built-in localizations use `durationUnits`" is true for 7.

## Edge cases

- Australia/Lord_Howe (30-minute DST shift): one wall-clock hour lasts 90
  minutes, so hour finders can't keep both "starts at :00" and "≤ 1h apart".
- `mn_Qaaq_MN` overrides `formatters` and rebuilds its map per lookup, so it
  gains less from the formatter cache.
