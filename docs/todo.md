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

## Docs

- moment_dart_docs (`docs/upgrading.md`) needs a 5.x → 6.0 page; the
  "Migrating from 5.x" section of CHANGELOG.md has the content.

## Edge cases

- Australia/Lord_Howe (30-minute DST shift): one wall-clock hour lasts 90
  minutes, so hour finders can't keep both "starts at :00" and "≤ 1h apart".
- `mn_Qaaq_MN` overrides `formatters` and rebuilds its map per lookup, so it
  gains less from the formatter cache.
