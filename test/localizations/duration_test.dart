// ignore_for_file: no_leading_underscores_for_local_identifiers, constant_identifier_names

import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  /// 1y 2mo
  const Duration _1y_2mo = Duration(days: 365 + 60); // y m
  /// 3y
  const Duration _3y = Duration(days: 365 * 3 + 0); // y
  /// 3mo 17d
  const Duration _3mo_17d = Duration(days: 30 * 3 + 17); // m d
  /// 4mo
  const Duration _4mo = Duration(days: 30 * 4 + 0); // mo
  /// 3w 2d
  const Duration _3w_2d_or_23d = Duration(days: 21 + 2); // w d
  /// 4w
  const Duration _4w_or_28d = Duration(days: 28 + 0); // w
  /// 6d 7h
  const Duration _6d_7h = Duration(days: 6, hours: 7); // d h
  /// 6d
  const Duration _6d = Duration(days: 6, hours: 0); // d
  /// 8h 8m
  const Duration _8h_8m = Duration(hours: 8, minutes: 8); // h m
  /// 8h
  const Duration _8h = Duration(hours: 8, minutes: 0); // h
  /// 48m 42s
  const Duration _48m_42s = Duration(minutes: 48, seconds: 42); // m s
  /// 35m
  const Duration _35m = Duration(minutes: 35, seconds: 0); // m
  /// 42s
  const Duration _42s = Duration(seconds: 42); // s
  /// 0s
  const Duration _zero = Duration(microseconds: 1); // s

  test("de_DE (with suffix/prefix) localization duration test", () {
    final MomentLocalization l10n = LocalizationDeDe();

    expect(
      l10n.duration(_1y_2mo, form: Abbreviation.none),
      "in einem Jahr 2 Monaten",
    );
    expect(
      l10n.duration(_1y_2mo, form: Abbreviation.semi),
      "in 1 Jr. 2 Mo.",
    );
    expect(
      l10n.duration(_1y_2mo, form: Abbreviation.full),
      "in 1 J. 2 Mo.",
    );

    expect(
      l10n.duration(_3y, form: Abbreviation.none),
      "in 3 Jahren",
    );
    expect(
      l10n.duration(_3y, form: Abbreviation.semi),
      "in 3 Jr.",
    );
    expect(
      l10n.duration(_3y, form: Abbreviation.full),
      "in 3 J.",
    );

    expect(
      l10n.duration(_3mo_17d, form: Abbreviation.none),
      "in 3 Monaten 17 Tagen",
    );
    expect(
      l10n.duration(_3mo_17d, form: Abbreviation.semi),
      "in 3 Mo. 17 Tg.",
    );
    expect(
      l10n.duration(_3mo_17d, form: Abbreviation.full),
      "in 3 Mo. 17 T.",
    );

    expect(
      l10n.duration(_4mo, form: Abbreviation.none),
      "in 4 Monaten",
    );
    expect(
      l10n.duration(_4mo, form: Abbreviation.semi),
      "in 4 Mo.",
    );
    expect(
      l10n.duration(_4mo, form: Abbreviation.full),
      "in 4 Mo.",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "in 3 Wochen 2 Tagen",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "in 3 Wochen 2 Tg.",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "in 3 W. 2 T.",
    );
    expect(
      l10n.duration(_3w_2d_or_23d, form: Abbreviation.none),
      "in 23 Tagen",
    );
    expect(
      l10n.duration(_3w_2d_or_23d, form: Abbreviation.semi),
      "in 23 Tg.",
    );
    expect(
      l10n.duration(_3w_2d_or_23d, form: Abbreviation.full),
      "in 23 T.",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "in 4 Wochen",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "in 4 Wochen",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "in 4 W.",
    );
    expect(
      l10n.duration(_4w_or_28d, form: Abbreviation.none),
      "in 28 Tagen",
    );
    expect(
      l10n.duration(_4w_or_28d, form: Abbreviation.semi),
      "in 28 Tg.",
    );
    expect(
      l10n.duration(_4w_or_28d, form: Abbreviation.full),
      "in 28 T.",
    );

    expect(
      l10n.duration(_6d_7h, form: Abbreviation.none),
      "in 6 Tagen 7 Stunden",
    );
    expect(
      l10n.duration(_6d_7h, form: Abbreviation.semi),
      "in 6 Tg. 7 Std.",
    );
    expect(
      l10n.duration(_6d_7h, form: Abbreviation.full),
      "in 6 T. 7 Std.",
    );

    expect(
      l10n.duration(_6d, form: Abbreviation.none),
      "in 6 Tagen",
    );
    expect(
      l10n.duration(_6d, form: Abbreviation.semi),
      "in 6 Tg.",
    );
    expect(
      l10n.duration(_6d, form: Abbreviation.full),
      "in 6 T.",
    );

    expect(
      l10n.duration(_8h_8m, form: Abbreviation.none),
      "in 8 Stunden 8 Minuten",
    );
    expect(
      l10n.duration(_8h_8m, form: Abbreviation.semi),
      "in 8 Std. 8 Min.",
    );
    expect(
      l10n.duration(_8h_8m, form: Abbreviation.full),
      "in 8 Std. 8 Min.",
    );

    expect(
      l10n.duration(_8h, form: Abbreviation.none),
      "in 8 Stunden",
    );
    expect(
      l10n.duration(_8h, form: Abbreviation.semi),
      "in 8 Std.",
    );
    expect(
      l10n.duration(_8h, form: Abbreviation.full),
      "in 8 Std.",
    );

    expect(
      l10n.duration(_48m_42s, form: Abbreviation.none),
      "in 48 Minuten 42 Sekunden",
    );
    expect(
      l10n.duration(_48m_42s, form: Abbreviation.semi),
      "in 48 Min. 42 Sek.",
    );
    expect(
      l10n.duration(_48m_42s, form: Abbreviation.full),
      "in 48 Min. 42 Sek.",
    );

    expect(
      l10n.duration(_35m, form: Abbreviation.none),
      "in 35 Minuten",
    );
    expect(
      l10n.duration(_35m, form: Abbreviation.semi),
      "in 35 Min.",
    );
    expect(
      l10n.duration(_35m, form: Abbreviation.full),
      "in 35 Min.",
    );

    expect(
      l10n.duration(_42s, form: Abbreviation.none),
      "in 42 Sekunden",
    );
    expect(
      l10n.duration(_42s, form: Abbreviation.semi),
      "in 42 Sek.",
    );
    expect(
      l10n.duration(_42s, form: Abbreviation.full),
      "in 42 Sek.",
    );

    expect(
      l10n.duration(_zero, form: Abbreviation.none),
      "in ein paar Sekunden",
    );
    expect(
      l10n.duration(_zero, form: Abbreviation.semi),
      "in ein paar Sek.",
    );
    expect(
      l10n.duration(_zero, form: Abbreviation.full),
      "in ein paar Sek.",
    );
  });

  test("de_DE (standalone) localization duration test", () {
    final MomentLocalization l10n = LocalizationDeDe();

    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "ein Jahr 2 Monate",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "1 Jr. 2 Mo.",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "1 J. 2 Mo.",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 Jahre",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 Jr.",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3 J.",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 Monate 17 Tage",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 Mo. 17 Tg.",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3 Mo. 17 T.",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "4 Monate",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "4 Mo.",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "4 Mo.",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "3 Wochen 2 Tage",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "3 Wochen 2 Tg.",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "3 W. 2 T.",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "23 Tage",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "23 Tg.",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "23 T.",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "4 W.",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "28 Tage",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "28 Tg.",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "28 T.",
    );

    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 Tage 7 Stunden",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 Tg. 7 Std.",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6 T. 7 Std.",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 Tage",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 Tg.",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6 T.",
    );

    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 Stunden 8 Minuten",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 Std. 8 Min.",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8 Std. 8 Min.",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 Stunden",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 Std.",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8 Std.",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "48 Minuten 42 Sekunden",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "48 Min. 42 Sek.",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "48 Min. 42 Sek.",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "35 Minuten",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "35 Min.",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "35 Min.",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "42 Sekunden",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "42 Sek.",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "42 Sek.",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "ein paar Sekunden",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "ein paar Sek.",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "ein paar Sek.",
    );
  });
  test("it_IT localization duration test", () {
    final MomentLocalization l10n = LocalizationItIt();

    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "un anno 2 mesi",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "1 anno 2 mesi",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "1 a. 2 ms.",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 anni",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 anni",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3 a.",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 mesi 17 giorni",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 mesi 17 giorni",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3 ms. 17 gg.",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "4 mesi",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "4 mesi",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "4 ms.",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "3 settimane 2 giorni",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "3 sett. 2 giorni",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "3 sett. 2 gg.",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "23 giorni",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "23 giorni",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "23 gg.",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "4 settimane",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "4 sett.",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "4 sett.",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "28 giorni",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "28 giorni",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "28 gg.",
    );

    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 giorni 7 ore",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 giorni 7 ore",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6 gg. 7 h",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 giorni",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 giorni",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6 gg.",
    );

    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 ore 8 minuti",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 ore 8 min",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8 h 8 m",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 ore",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 ore",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8 h",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "48 minuti 42 secondi",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "48 min 42 sec",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "48 m 42 s",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "35 minuti",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "35 min",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "35 m",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "42 secondi",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "42 sec",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "42 s",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "alcuni secondi",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "alcuni sec",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "alcuni sec",
    );
  });
  test("fr_FR localization duration test", () {
    final MomentLocalization l10n = LocalizationFrFr();

    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "un an 2 mois",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "1 an 2 mois",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "1 an 2 mois",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 ans",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 ans",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3 ans",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 mois 17 jours",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 mois 17 jours",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3 mois 17 j",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "4 mois",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "4 mois",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "4 mois",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "3 semaines 2 jours",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "3 sem. 2 jours",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "3 sem. 2 j",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "23 jours",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "23 jours",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "23 j",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "4 semaines",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "4 sem.",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "4 sem.",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "28 jours",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "28 jours",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "28 j",
    );

    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 jours 7 heures",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 jours 7 heures",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6 j 7 h",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 jours",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 jours",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6 j",
    );

    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 heures 8 minutes",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 heures 8 min",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8 h 8 min",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 heures",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 heures",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8 h",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "48 minutes 42 secondes",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "48 min 42 sec.",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "48 min 42 s",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "35 minutes",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "35 min",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "35 min",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "42 secondes",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "42 sec.",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "42 s",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "quelques secondes",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "quelques sec.",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "quelques sec.",
    );
  });
  test("pt_PT localization duration test", () {
    final MomentLocalization l10n = LocalizationPtPt();

    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "um ano 2 mêses",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "1 ano 2 mêses",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "1 a 2 mê",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 anos",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 anos",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3 a",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 mêses 17 dias",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 mêses 17 dias",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3 mê 17 d",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "4 mêses",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "4 mêses",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "4 mê",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "3 semanas 2 dias",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "3 sem 2 dias",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "3 sem 2 d",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "23 dias",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "23 dias",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "23 d",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "4 semanas",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "4 sem",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "4 sem",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "28 dias",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "28 dias",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "28 d",
    );

    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 dias 7 horas",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 dias 7 horas",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6 d 7 h",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 dias",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 dias",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6 d",
    );

    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 horas 8 minutos",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 horas 8 min",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8 h 8 m",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 horas",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 horas",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8 h",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "48 minutos 42 segundos",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "48 min 42 seg",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "48 m 42 s",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "35 minutos",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "35 min",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "35 m",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "42 segundos",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "42 seg",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "42 s",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "alguns segundos",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "alguns segundos",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "alguns seg",
    );
  });
  test("es_ES localization duration test", () {
    final MomentLocalization l10n = LocalizationEsEs();

    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "un año 2 meses",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "1 año 2 meses",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "1 año 2 ms.",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 años",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 años",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3 años",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 meses 17 días",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 meses 17 días",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3 ms. 17 d",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "4 meses",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "4 meses",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "4 ms.",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "3 semanas 2 días",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "3 semanas 2 días",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "3 sem. 2 d",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "23 días",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "23 días",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "23 d",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "4 semanas",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "4 semanas",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "4 sem.",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "28 días",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "28 días",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "28 d",
    );

    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 días 7 horas",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 días 7 horas",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6 d 7 h",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 días",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 días",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6 d",
    );

    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 horas 8 minutos",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 horas 8 min.",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8 h 8 min",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 horas",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 horas",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8 h",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "48 minutos 42 segundos",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "48 min. 42 seg.",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "48 min 42 s",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "35 minutos",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "35 min.",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "35 min",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "42 segundos",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "42 seg.",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "42 s",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "unos segundos",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "unos seg.",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "unos s",
    );
  });
  test("en_US localization duration test", () {
    final MomentLocalization l10n = LocalizationEnUs();

    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "a year 2 months",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "1 yr 2 mo",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "1y 2mo",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 years",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 yr",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3y",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 months 17 days",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 mo 17 day",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3mo 17d",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "4 months",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "4 mo",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "4mo",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "3 weeks 2 days",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "3 wk 2 day",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "3w 2d",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "23 days",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "23 day",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "23d",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "4 weeks",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "4 wk",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "4w",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "28 days",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "28 day",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "28d",
    );

    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 days 7 hours",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 day 7 hr",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6d 7h",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 days",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 day",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6d",
    );

    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 hours 8 minutes",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 hr 8 min",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8h 8m",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 hours",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 hr",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8h",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "48 minutes 42 seconds",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "48 min 42 sec",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "48m 42s",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "35 minutes",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "35 min",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "35m",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "42 seconds",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "42 sec",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "42s",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "a few seconds",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "a few sec",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "a sec",
    );
  });
  test("mn_MN localization duration test", () {
    final MomentLocalization l10n = LocalizationMnMn();

    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "1 жил 2 сар",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "1 жил 2 сар",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "1жил 2сар",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 жил",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 жил",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3жил",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 сар 17 өдөр",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 сар 17 өдөр",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3сар 17ө",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "4 сар",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "4 сар",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "4сар",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "3 долоо хоног 2 өдөр",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "3 долоо хон 2 өдөр",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "3дол.хон 2ө",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "23 өдөр",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "23 өдөр",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "23ө",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "4 долоо хоног",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "4 долоо хон",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "4дол.хон",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "28 өдөр",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "28 өдөр",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "28ө",
    );

    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 өдөр 7 цаг",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 өдөр 7 цаг",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6ө 7ц",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 өдөр",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 өдөр",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6ө",
    );

    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 цаг 8 минут",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 цаг 8 мин",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8ц 8м",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 цаг",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 цаг",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8ц",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "48 минут 42 секунд",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "48 мин 42 сек",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "48м 42с",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "35 минут",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "35 мин",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "35м",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "42 секунд",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "42 сек",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "42с",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "хэдэн хором",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "хором",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "хором",
    );
  });
  test("mn_Mong_MN localization duration test", () {
    final MomentLocalization l10n = LocalizationMnMongMn();

    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "1 ᠵᠢᠯ 2 ᠰᠠᠷ᠎ᠠ",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "1 ᠵᠢᠯ 2 ᠰᠠ᠊᠍",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "1ᠵᠢᠯ 2ᠰᠠ᠊᠍",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 ᠵᠢᠯ",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 ᠵᠢᠯ",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3ᠵᠢᠯ",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 ᠰᠠᠷ᠎ᠠ 17 ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 ᠰᠠ᠊᠍ 17 ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "3ᠰᠠ᠊᠍ 17ᠥ",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "4 ᠰᠠᠷ᠎ᠠ",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "4 ᠰᠠ᠊᠍",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "4ᠰᠠ᠊᠍",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "3 ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ 2 ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "3 ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨ᠍᠊᠍ 2 ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "3ᠳᠣ.ᠬᠣᠨ᠍᠊᠍ 2ᠥ",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "23 ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "23 ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "23ᠥ",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "4 ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "4 ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨ᠍᠊᠍",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "4ᠳᠣ.ᠬᠣᠨ᠍᠊᠍",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "28 ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "28 ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "28ᠥ",
    );

    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 ᠡᠳᠦᠷ 7 ᠴᠠᠭ",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 ᠡᠳᠦᠷ 7 ᠴᠠᠭ",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6ᠥ 7ᠴ",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "6ᠥ",
    );

    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 ᠴᠠᠭ 8 ᠮᠢᠨᠦᠢᠲ",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 ᠴᠠᠭ 8 ᠮᠢᠨ᠊᠍",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8ᠴ 8ᠮ",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 ᠴᠠᠭ",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 ᠴᠠᠭ",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "8ᠴ",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "48 ᠮᠢᠨᠦᠢᠲ 42 ᠰᠧᠻᠦ᠋ᠨ᠍ᠳ᠋",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "48 ᠮᠢᠨ᠊᠍ 42 ᠰᠧᠻ᠍᠊᠍",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "48ᠮ 42ᠰ",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "35 ᠮᠢᠨᠦᠢᠲ",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "35 ᠮᠢᠨ᠊᠍",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "35ᠮ",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "42 ᠰᠧᠻᠦ᠋ᠨ᠍ᠳ᠋",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "42 ᠰᠧᠻ᠍᠊᠍",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "42ᠰ",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "ᠬᠡᠳᠦᠨ ᠬᠣᠷᠤᠮ",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "ᠬᠣᠷᠤᠮ",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "ᠬᠣᠷᠤᠮ",
    );
  });
  test("mn_Qaaq_MN localization duration test", () {
    final MomentLocalization l10n = LocalizationMnQaaqMn();

    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "᠑ ᠵᠢᠯ ᠒ ᠰᠠᠷ᠎ᠠ",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "᠑ ᠵᠢᠯ ᠒ ᠰᠠ᠊᠍",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "᠑ᠵᠢᠯ ᠒ᠰᠠ᠊᠍",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "᠓ ᠵᠢᠯ",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "᠓ ᠵᠢᠯ",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "᠓ᠵᠢᠯ",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "᠓ ᠰᠠᠷ᠎ᠠ ᠑᠗ ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "᠓ ᠰᠠ᠊᠍ ᠑᠗ ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "᠓ᠰᠠ᠊᠍ ᠑᠗ᠥ",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "᠔ ᠰᠠᠷ᠎ᠠ",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "᠔ ᠰᠠ᠊᠍",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "᠔ᠰᠠ᠊᠍",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "᠓ ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ ᠒ ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "᠓ ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨ᠍᠊᠍ ᠒ ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "᠓ᠳᠣ.ᠬᠣᠨ᠍᠊᠍ ᠒ᠥ",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "᠒᠓ ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "᠒᠓ ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "᠒᠓ᠥ",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "᠔ ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "᠔ ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨ᠍᠊᠍",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.full,
      ),
      "᠔ᠳᠣ.ᠬᠣᠨ᠍᠊᠍",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "᠒᠘ ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "᠒᠘ ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "᠒᠘ᠥ",
    );

    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "᠖ ᠡᠳᠦᠷ ᠗ ᠴᠠᠭ",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "᠖ ᠡᠳᠦᠷ ᠗ ᠴᠠᠭ",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "᠖ᠥ ᠗ᠴ",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "᠖ ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "᠖ ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "᠖ᠥ",
    );

    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "᠘ ᠴᠠᠭ ᠘ ᠮᠢᠨᠦᠢᠲ",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "᠘ ᠴᠠᠭ ᠘ ᠮᠢᠨ᠊᠍",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "᠘ᠴ ᠘ᠮ",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "᠘ ᠴᠠᠭ",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "᠘ ᠴᠠᠭ",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "᠘ᠴ",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "᠔᠘ ᠮᠢᠨᠦᠢᠲ ᠔᠒ ᠰᠧᠻᠦ᠋ᠨ᠍ᠳ᠋",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "᠔᠘ ᠮᠢᠨ᠊᠍ ᠔᠒ ᠰᠧᠻ᠍᠊᠍",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.full),
      "᠔᠘ᠮ ᠔᠒ᠰ",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "᠓᠕ ᠮᠢᠨᠦᠢᠲ",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "᠓᠕ ᠮᠢᠨ᠊᠍",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "᠓᠕ᠮ",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "᠔᠒ ᠰᠧᠻᠦ᠋ᠨ᠍ᠳ᠋",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "᠔᠒ ᠰᠧᠻ᠍᠊᠍",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "᠔᠒ᠰ",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "ᠬᠡᠳᠦᠨ ᠬᠣᠷᠤᠮ",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "ᠬᠣᠷᠤᠮ",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.full),
      "ᠬᠣᠷᠤᠮ",
    );
  });
  test("ko_KO localization duration test", () {
    final MomentLocalization l10n = LocalizationKoKr();

    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true),
      "1년 2개월",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true),
      "3년",
    );

    expect(
      l10n.duration(_3mo_17d, dropPrefixOrSuffix: true),
      "3개월 17일",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true),
      "4개월",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
      ),
      "3주 2일",
    );
    expect(
      l10n.duration(_3w_2d_or_23d, dropPrefixOrSuffix: true),
      "23일",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
      ),
      "4주",
    );
    expect(
      l10n.duration(_4w_or_28d, dropPrefixOrSuffix: true),
      "28일",
    );

    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true),
      "6일 7시간",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true),
      "6일",
    );

    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true),
      "8시간 8분",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true),
      "8시간",
    );

    expect(
      l10n.duration(_48m_42s, dropPrefixOrSuffix: true),
      "48분 42초",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true),
      "35분",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true),
      "42초",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true),
      "몇 초",
    );
  });

  test("zh_CN localization duration test", () {
    final MomentLocalization l10n = LocalizationZhCn();

    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true),
      "1 年 2 个月",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true),
      "3 年",
    );

    expect(
      l10n.duration(_3mo_17d, dropPrefixOrSuffix: true),
      "3 个月 17 天",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true),
      "4 个月",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
      ),
      "3 周 2 天",
    );
    expect(
      l10n.duration(_3w_2d_or_23d, dropPrefixOrSuffix: true),
      "23 天",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "4 周",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "28 天",
    );

    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 天 7 小时",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 天",
    );

    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 小时 8 分钟",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 小时",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "48 分钟 42 秒",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true),
      "35 分钟",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true),
      "42 秒",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true),
      "几秒",
    );
  });

  test("ja_JP localization duration test", () {
    final MomentLocalization l10n = LocalizationJaJp();

    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true),
      "1年2ヶ月",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true),
      "3年",
    );

    expect(
      l10n.duration(_3mo_17d, dropPrefixOrSuffix: true),
      "3ヶ月17日",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true),
      "4ヶ月",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
      ),
      "3週間2日",
    );
    expect(
      l10n.duration(_3w_2d_or_23d, dropPrefixOrSuffix: true),
      "23日",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "4週間",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "28日",
    );

    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6日7時間",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6日",
    );

    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8時間8分",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8時間",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "48分42秒",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true),
      "35分",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true),
      "42秒",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true),
      "数秒",
    );
  });

  test("tr_TR localization duration test", () {
    final MomentLocalization l10n = LocalizationTrTr();

    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "bir yıl 2 ay",
    );
    expect(
      l10n.duration(_1y_2mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "1 yıl 2 ay",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 yıl",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 yıl",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "3 ay 17 gün",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "3 ay 17 gün",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "4 ay",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "4 ay",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "3 hafta 2 gün",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "3 hft 2 gün",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "23 gün",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "23 gün",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.none,
      ),
      "4 hafta",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: Abbreviation.semi,
      ),
      "4 hft",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "28 gün",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "28 gün",
    );

    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 gün 7 saat",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 gün 7 sa",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "6 gün",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "6 gün",
    );

    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 saat 8 dakika",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 sa 8 dk",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "8 saat",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "8 sa",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.none),
      "48 dakika 42 saniye",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "48 dk 42 sn",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "35 dakika",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "35 dk",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "42 saniye",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "42 sn",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.none),
      "birkaç saniye",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: Abbreviation.semi),
      "birkaç sn",
    );
  });
}
