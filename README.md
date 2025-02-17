# moment_dart

[![pub package](https://img.shields.io/pub/v/moment_dart.svg)](https://pub.dartlang.org/packages/moment_dart)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![All Contributors](https://img.shields.io/github/all-contributors/sadespresso/moment_dart?color=ae00ff)](#contributors)

> Inspired by moment.js

## References

### [📖 Read documentation](https://dev.gege.mn/moment_dart_docs)

### [🆕 Migrate to 4.0.0](https://dev.gege.mn/moment_dart_docs/upgrading/)

## Usage

### Creating instance

There are multiple ways to create an instance.

```dart
// From DateTime
final a = DateTime.now().toMoment();

final b = Moment(DateTime(...));

// This instance won't be affected by global localization!
final c = Moment(b, localization: MomentLocalizations.koKr());
```

### Setting global localization

By default, the global localization is `en_US`.

```dart
Moment.setGlobalLocalization(MomentLocalizations.fr());
```

### Relative Duration

Relative durations are rather inprecise. See [precise duration](#precise-duration)
for accuracy and flexibility.

Read about thresholds, and more on [docs](https://dev.gege.mn/moment_dart_docs/duration)

```dart
final yesterday = Moment.now() - const Duration(days: 1);
yesterday.fromNow(); // a day ago

final add5sec = Moment.now().add(const Duration(seconds: 5));
add5sec.fromNow(dropPrefixOrSuffix: true); // a few seconds
```

### Precise duration

You can create localized human-readable duration text with
abbreviation, highly-customizable units.

See more on [docs](https://dev.gege.mn/moment_dart_docs/duration/precise).
(delimiter, custom units, abbreviation...)

On `Duration` objects:

```dart
Duration(days: 67, hours: 3, minutes: 2).toDurationString(
  localization: MomentLocalizations.de(),
  form: Abbreviation.semi,
); // in 2 Mo. 7 Tg.
```

For `Moment`:

```dart
final epoch = Moment.fromMillisecondsSinceEpoch(0);
final now = DateTime(2023, DateTime.july, 14).toMoment();

print(epoch.fromPrecise(now)); // 53 years 7 months ago
```

### Calendar

```dart
final Moment now = Moment.now();

print(now.calendar()); // Today at 03:00 PM
```

### Other helpful methods

`moment_dart` provides numerous convenience methods. Works on both `Moment` and `DateTime`.

See all available options in the [docs](https://dev.gege.mn/moment_dart_docs/extension/)

```dart
final now = DateTime.now(); // July 19 2023 03:12 PM (UTC+8)

// ISO week, ISO week year
now.week; // 48
now.weekYear; // 2023

now.isLeapYear; // false

// Date creates new `DateTime` with hours, minutes, etc.. omitted
now.date; // July 19 2023 00:00 AM

now.clone(); // July 19 2023 03:12 PM

now.nextTuesday(); // July 25 2023 03:12 PM

// and many more!
```

## Contributing

Contributions of any kind are welcome! Please refer to [CONTRIBUTE.md](CONTRIBUTE.md)

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/sadespresso"><img src="https://avatars.githubusercontent.com/u/51638223?v=4?s=80" width="80px;" alt="Батмэнд Ганбаатар"/><br /><sub><b>Батмэнд Ганбаатар</b></sub></a><br /><a href="https://github.com/sadespresso/moment_dart/commits?author=sadespresso" title="Code">💻</a> <a href="#maintenance-sadespresso" title="Maintenance">🚧</a> <a href="#translation-sadespresso" title="Translation">🌍</a> <a href="https://github.com/sadespresso/moment_dart/commits?author=sadespresso" title="Documentation">📖</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
