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
      l10n.duration(_1y_2mo, form: UnitStringForm.full),
      "in einem Jahr 2 Monaten",
    );
    expect(
      l10n.duration(_1y_2mo, form: UnitStringForm.mid),
      "in 1 Jr. 2 Mo.",
    );
    expect(
      l10n.duration(_1y_2mo, form: UnitStringForm.short),
      "in 1y 2mo",
    );

    expect(
      l10n.duration(_3y, form: UnitStringForm.full),
      "in 3 Jahren",
    );
    expect(
      l10n.duration(_3y, form: UnitStringForm.mid),
      "in 3 Jr.",
    );
    expect(
      l10n.duration(_3y, form: UnitStringForm.short),
      "in 3y",
    );

    expect(
      l10n.duration(_3mo_17d, form: UnitStringForm.full),
      "in 3 Monaten 17 Tagen",
    );
    expect(
      l10n.duration(_3mo_17d, form: UnitStringForm.mid),
      "in 3 Mo. 17 Tg.",
    );
    expect(
      l10n.duration(_3mo_17d, form: UnitStringForm.short),
      "in 3mo 17d",
    );

    expect(
      l10n.duration(_4mo, form: UnitStringForm.full),
      "in 4 Monaten",
    );
    expect(
      l10n.duration(_4mo, form: UnitStringForm.mid),
      "in 4 Mo.",
    );
    expect(
      l10n.duration(_4mo, form: UnitStringForm.short),
      "in 4mo",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "in 3 Wochen 2 Tagen",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "in 3 Wochen 2 Tg.",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "in 3w 2d",
    );
    expect(
      l10n.duration(_3w_2d_or_23d, form: UnitStringForm.full),
      "in 23 Tagen",
    );
    expect(
      l10n.duration(_3w_2d_or_23d, form: UnitStringForm.mid),
      "in 23 Tg.",
    );
    expect(
      l10n.duration(_3w_2d_or_23d, form: UnitStringForm.short),
      "in 23d",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "in 4 Wochen",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "in 4 Wochen",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "in 4w",
    );
    expect(
      l10n.duration(_4w_or_28d, form: UnitStringForm.full),
      "in 28 Tagen",
    );
    expect(
      l10n.duration(_4w_or_28d, form: UnitStringForm.mid),
      "in 28 Tg.",
    );
    expect(
      l10n.duration(_4w_or_28d, form: UnitStringForm.short),
      "in 28d",
    );

    expect(
      l10n.duration(_6d_7h, form: UnitStringForm.full),
      "in 6 Tagen 7 Stunden",
    );
    expect(
      l10n.duration(_6d_7h, form: UnitStringForm.mid),
      "in 6 Tg. 7 Std.",
    );
    expect(
      l10n.duration(_6d_7h, form: UnitStringForm.short),
      "in 6d 7h",
    );

    expect(
      l10n.duration(_6d, form: UnitStringForm.full),
      "in 6 Tagen",
    );
    expect(
      l10n.duration(_6d, form: UnitStringForm.mid),
      "in 6 Tg.",
    );
    expect(
      l10n.duration(_6d, form: UnitStringForm.short),
      "in 6d",
    );

    expect(
      l10n.duration(_8h_8m, form: UnitStringForm.full),
      "in 8 Stunden 8 Minuten",
    );
    expect(
      l10n.duration(_8h_8m, form: UnitStringForm.mid),
      "in 8 Std. 8 Min.",
    );
    expect(
      l10n.duration(_8h_8m, form: UnitStringForm.short),
      "in 8h 8m",
    );

    expect(
      l10n.duration(_8h, form: UnitStringForm.full),
      "in 8 Stunden",
    );
    expect(
      l10n.duration(_8h, form: UnitStringForm.mid),
      "in 8 Std.",
    );
    expect(
      l10n.duration(_8h, form: UnitStringForm.short),
      "in 8h",
    );

    expect(
      l10n.duration(_48m_42s, form: UnitStringForm.full),
      "in 48 Minuten 42 Sekunden",
    );
    expect(
      l10n.duration(_48m_42s, form: UnitStringForm.mid),
      "in 48 Min. 42 Sek.",
    );
    expect(
      l10n.duration(_48m_42s, form: UnitStringForm.short),
      "in 48m 42s",
    );

    expect(
      l10n.duration(_35m, form: UnitStringForm.full),
      "in 35 Minuten",
    );
    expect(
      l10n.duration(_35m, form: UnitStringForm.mid),
      "in 35 Min.",
    );
    expect(
      l10n.duration(_35m, form: UnitStringForm.short),
      "in 35m",
    );

    expect(
      l10n.duration(_42s, form: UnitStringForm.full),
      "in 42 Sekunden",
    );
    expect(
      l10n.duration(_42s, form: UnitStringForm.mid),
      "in 42 Sek.",
    );
    expect(
      l10n.duration(_42s, form: UnitStringForm.short),
      "in 42s",
    );

    expect(
      l10n.duration(_zero, form: UnitStringForm.full),
      "in ein paar Sekunden",
    );
    expect(
      l10n.duration(_zero, form: UnitStringForm.mid),
      "in ein paar Sek.",
    );
    expect(
      l10n.duration(_zero, form: UnitStringForm.short),
      "in ein paar Sek.",
    );
  });

  test("de_DE (standalone) localization duration test", () {
    final MomentLocalization l10n = LocalizationDeDe();

    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "ein Jahr 2 Monate",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 Jr. 2 Mo.",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1y 2mo",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Jahre",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Jr.",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3y",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Monate 17 Tage",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Mo. 17 Tg.",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3mo 17d",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 Monate",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 Mo.",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4mo",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 Wochen 2 Tage",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 Wochen 2 Tg.",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3w 2d",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 Tage",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 Tg.",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23d",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4w",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 Tage",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 Tg.",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28d",
    );

    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tage 7 Stunden",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg. 7 Std.",
    );
    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d 7h",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tage",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg.",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d",
    );

    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden 8 Minuten",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std. 8 Min.",
    );
    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h 8m",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std.",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 Minuten 42 Sekunden",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 Min. 42 Sek.",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48m 42s",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 Minuten",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 Min.",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35m",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 Sekunden",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 Sek.",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42s",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "ein paar Sekunden",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "ein paar Sek.",
    );
    expect(
      l10n.duration(_zero,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "ein paar Sek.",
    );
  });
  test("it_IT localization duration test", () {
    final MomentLocalization l10n = LocalizationItIt();

    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "un anno 2 mesi",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 anno 2 mesi",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1 a. 2 ms.",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 anni",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 anni",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3 a.",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 mesi 17 giorni",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 mesi 17 giorni",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3 ms. 17 gg.",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 mesi",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 mesi",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4 ms.",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 settimane 2 giorni",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 sett. 2 giorni",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3 sett. 2 gg.",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 giorni",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 giorni",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23 gg.",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 settimane",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 sett.",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4 sett.",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 giorni",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 giorni",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28 gg.",
    );

    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 giorni 7 ore",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 giorni 7 ore",
    );
    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6 gg. 7 h",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 giorni",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 giorni",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6 gg.",
    );

    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 ore 8 minuti",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 ore 8 min",
    );
    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8 h 8 m",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 ore",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 ore",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8 h",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 minuti 42 secondi",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 min 42 sec",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48 m 42 s",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 minuti",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 min",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35 m",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 secondi",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 sec",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42 s",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "alcuni secondi",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "alcuni sec",
    );
    expect(
      l10n.duration(_zero,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "alcuni sec",
    );
  });
  test("fr_FR localization duration test", () {
    final MomentLocalization l10n = LocalizationFrFr();

    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "un an 2 mois",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 an 2 mois",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1 an 2 mois",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 ans",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 ans",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3 ans",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 mois 17 jours",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 mois 17 jours",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3 mois 17 j",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 mois",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 mois",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4 mois",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 semaines 2 jours",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 sem. 2 jours",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3 sem. 2 j",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 jours",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 jours",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23 j",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 semaines",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 sem.",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4 sem.",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 jours",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 jours",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28 j",
    );

    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 jours 7 heures",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 jours 7 heures",
    );
    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6 j 7 h",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 jours",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 jours",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6 j",
    );

    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 heures 8 minutes",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 heures 8 min",
    );
    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8 h 8 min",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 heures",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 heures",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8 h",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 minutes 42 secondes",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 min 42 sec.",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48 min 42 s",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 minutes",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 min",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35 min",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 secondes",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 sec.",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42 s",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "quelques secondes",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "quelques sec.",
    );
    expect(
      l10n.duration(_zero,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "quelques sec.",
    );
  });
  test("es_ES localization duration test", () {
    final MomentLocalization l10n = LocalizationEsEs();

    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "un año 2 meses",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 año 2 meses",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1 año 2 ms.",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 años",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 años",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3 años",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 meses 17 días",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 meses 17 días",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3 ms. 17 d",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 meses",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 meses",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4 ms.",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 semanas 2 días",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 semanas 2 días",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3 sem. 2 d",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 días",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 días",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23 d",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 semanas",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 semanas",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4 sem.",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 días",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 días",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28 d",
    );

    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 días 7 horas",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 días 7 horas",
    );
    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6 d 7 h",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 días",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 días",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6 d",
    );

    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 horas 8 minutos",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 horas 8 min.",
    );
    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8 h 8 min",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 horas",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 horas",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8 h",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 minutos 42 segundos",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 min. 42 seg.",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48 min 42 s",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 minutos",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 min.",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35 min",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 segundos",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 seg.",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42 s",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "unos segundos",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "unos seg.",
    );
    expect(
      l10n.duration(_zero,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "unos s",
    );
  });
  test("en_US localization duration test", () {
    final MomentLocalization l10n = LocalizationEnUs();

    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "a year 2 months",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 yr 2 mo",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1y 2mo",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 years",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 yr",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3y",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 months 17 days",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 mo 17 day",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3mo 17d",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 months",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 mo",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4mo",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 weeks 2 days",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 wk 2 day",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3w 2d",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 days",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 day",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23d",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 weeks",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 wk",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4w",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 days",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 day",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28d",
    );

    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 days 7 hours",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 day 7 hr",
    );
    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d 7h",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 days",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 day",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d",
    );

    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 hours 8 minutes",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 hr 8 min",
    );
    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h 8m",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 hours",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 hr",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 minutes 42 seconds",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 min 42 sec",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48m 42s",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 minutes",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 min",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35m",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 seconds",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 sec",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42s",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "a few seconds",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "a few sec",
    );
    expect(
      l10n.duration(_zero,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "a sec",
    );
  });
  test("mn_MN localization duration test", () {
    final MomentLocalization l10n = LocalizationMnMn();

    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "1 жил 2 сар",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 жил 2 сар",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1жил 2сар",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 жил",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 жил",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3жил",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 сар 17 өдөр",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 сар 17 өдөр",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3сар 17ө",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 сар",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 сар",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4сар",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 долоо хоног 2 өдөр",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 долоо хон 2 өдөр",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3дол.хон 2ө",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 өдөр",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 өдөр",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23ө",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 долоо хоног",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 долоо хон",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4дол.хон",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 өдөр",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 өдөр",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28ө",
    );

    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 өдөр 7 цаг",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 өдөр 7 цаг",
    );
    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6ө 7ц",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 өдөр",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 өдөр",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6ө",
    );

    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 цаг 8 минут",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 цаг 8 мин",
    );
    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8ц 8м",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 цаг",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 цаг",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8ц",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 минут 42 секунд",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 мин 42 сек",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48м 42с",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 минут",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 мин",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35м",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 секунд",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 сек",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42с",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "хэдэн хором",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "хором",
    );
    expect(
      l10n.duration(_zero,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "хором",
    );
  });
  test("mn_Mong_MN localization duration test", () {
    final MomentLocalization l10n = LocalizationMnMongMn();

    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "1 ᠵᠢᠯ ᠤᠨ 2 ᠰᠠᠷ᠎ᠠ",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 ᠵᠢᠯ ᠤᠨ 2 ᠰᠠ᠊᠍",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1ᠵᠢᠯ ᠤᠨ 2ᠰᠠ᠊᠍",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 ᠵᠢᠯ ᠤᠨ",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 ᠵᠢᠯ ᠤᠨ",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3ᠵᠢᠯ ᠤᠨ",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 ᠰᠠᠷ᠎ᠠ ᠶᠢᠨ 17 ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 ᠰᠠ᠊᠍ ᠶᠢᠨ 17 ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3ᠰᠠ᠊᠍ ᠶᠢᠨ 17ᠥ",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 ᠰᠠᠷ᠎ᠠ ᠶᠢᠨ",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 ᠰᠠ᠊᠍ ᠶᠢᠨ",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4ᠰᠠ᠊᠍ ᠶᠢᠨ",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ ᠤᠨ 2 ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨ᠍᠊᠍ ᠤᠨ 2 ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3ᠳᠣ.ᠬᠣᠨ᠍᠊᠍ ᠤᠨ 2ᠥ",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 ᠡᠳᠦᠷ ᠦᠨ",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 ᠡᠳᠦᠷ ᠦᠨ",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23ᠥ ᠦᠨ",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ ᠤᠨ",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨ᠍᠊᠍ ᠤᠨ",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4ᠳᠣ.ᠬᠣᠨ᠍᠊᠍ ᠤᠨ",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 ᠡᠳᠦᠷ ᠦᠨ",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 ᠡᠳᠦᠷ ᠦᠨ",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28ᠥ ᠦᠨ",
    );

    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 ᠡᠳᠦᠷ ᠦᠨ 7 ᠴᠠᠭ",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 ᠡᠳᠦᠷ ᠦᠨ 7 ᠴᠠᠭ",
    );
    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6ᠥ ᠦᠨ 7ᠴ",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 ᠡᠳᠦᠷ ᠦᠨ",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 ᠡᠳᠦᠷ ᠦᠨ",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6ᠥ ᠦᠨ",
    );

    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 ᠴᠠᠭ ᠤᠨ 8 ᠮᠢᠨᠦᠢᠲ",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 ᠴᠠᠭ ᠤᠨ 8 ᠮᠢᠨ᠊᠍",
    );
    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8ᠴ ᠤᠨ 8ᠮ",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 ᠴᠠᠭ ᠤᠨ",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 ᠴᠠᠭ ᠤᠨ",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8ᠴ ᠤᠨ",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 ᠮᠢᠨᠦᠢᠲ ᠦᠨ 42 ᠰᠧᠻᠦ᠋ᠨ᠍ᠳ᠋",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 ᠮᠢᠨ᠊᠍ ᠦᠨ 42 ᠰᠧᠻ᠍᠊᠍",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48ᠮ ᠦᠨ 42ᠰ",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 ᠮᠢᠨᠦᠢᠲ ᠦᠨ",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 ᠮᠢᠨ᠊᠍ ᠦᠨ",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35ᠮ ᠦᠨ",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 ᠰᠧᠻᠦ᠋ᠨ᠍ᠳ᠋",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 ᠰᠧᠻ᠍᠊᠍",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42ᠰ",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "ᠬᠡᠳᠦᠨ ᠬᠣᠷᠤᠮ",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "ᠬᠣᠷᠤᠮ",
    );
    expect(
      l10n.duration(_zero,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "ᠬᠣᠷᠤᠮ",
    );
  });
  test("mn_Qaaq_MN localization duration test", () {
    final MomentLocalization l10n = LocalizationMnQaaqMn();

    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "᠑ ᠵᠢᠯ ᠤᠨ ᠒ ᠰᠠᠷ᠎ᠠ",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "᠑ ᠵᠢᠯ ᠤᠨ ᠒ ᠰᠠ᠊᠍",
    );
    expect(
      l10n.duration(_1y_2mo,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "᠑ᠵᠢᠯ ᠤᠨ ᠒ᠰᠠ᠊᠍",
    );

    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "᠓ ᠵᠢᠯ ᠤᠨ",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "᠓ ᠵᠢᠯ ᠤᠨ",
    );
    expect(
      l10n.duration(_3y, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "᠓ᠵᠢᠯ ᠤᠨ",
    );

    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "᠓ ᠰᠠᠷ᠎ᠠ ᠶᠢᠨ ᠑᠗ ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "᠓ ᠰᠠ᠊᠍ ᠶᠢᠨ ᠑᠗ ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(_3mo_17d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "᠓ᠰᠠ᠊᠍ ᠶᠢᠨ ᠑᠗ᠥ",
    );

    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "᠔ ᠰᠠᠷ᠎ᠠ ᠶᠢᠨ",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "᠔ ᠰᠠ᠊᠍ ᠶᠢᠨ",
    );
    expect(
      l10n.duration(_4mo, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "᠔ᠰᠠ᠊᠍ ᠶᠢᠨ",
    );

    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "᠓ ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ ᠤᠨ ᠒ ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "᠓ ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨ᠍᠊᠍ ᠤᠨ ᠒ ᠡᠳᠦᠷ",
    );
    expect(
      l10n.duration(
        _3w_2d_or_23d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "᠓ᠳᠣ.ᠬᠣᠨ᠍᠊᠍ ᠤᠨ ᠒ᠥ",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "᠒᠓ ᠡᠳᠦᠷ ᠦᠨ",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "᠒᠓ ᠡᠳᠦᠷ ᠦᠨ",
    );
    expect(
      l10n.duration(_3w_2d_or_23d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "᠒᠓ᠥ ᠦᠨ",
    );

    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "᠔ ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ ᠤᠨ",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "᠔ ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨ᠍᠊᠍ ᠤᠨ",
    );
    expect(
      l10n.duration(
        _4w_or_28d,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "᠔ᠳᠣ.ᠬᠣᠨ᠍᠊᠍ ᠤᠨ",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "᠒᠘ ᠡᠳᠦᠷ ᠦᠨ",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "᠒᠘ ᠡᠳᠦᠷ ᠦᠨ",
    );
    expect(
      l10n.duration(_4w_or_28d,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "᠒᠘ᠥ ᠦᠨ",
    );

    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "᠖ ᠡᠳᠦᠷ ᠦᠨ ᠗ ᠴᠠᠭ",
    );
    expect(
      l10n.duration(_6d_7h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "᠖ ᠡᠳᠦᠷ ᠦᠨ ᠗ ᠴᠠᠭ",
    );
    expect(
      l10n.duration(_6d_7h,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "᠖ᠥ ᠦᠨ ᠗ᠴ",
    );

    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "᠖ ᠡᠳᠦᠷ ᠦᠨ",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "᠖ ᠡᠳᠦᠷ ᠦᠨ",
    );
    expect(
      l10n.duration(_6d, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "᠖ᠥ ᠦᠨ",
    );

    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "᠘ ᠴᠠᠭ ᠤᠨ ᠘ ᠮᠢᠨᠦᠢᠲ",
    );
    expect(
      l10n.duration(_8h_8m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "᠘ ᠴᠠᠭ ᠤᠨ ᠘ ᠮᠢᠨ᠊᠍",
    );
    expect(
      l10n.duration(_8h_8m,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "᠘ᠴ ᠤᠨ ᠘ᠮ",
    );

    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "᠘ ᠴᠠᠭ ᠤᠨ",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "᠘ ᠴᠠᠭ ᠤᠨ",
    );
    expect(
      l10n.duration(_8h, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "᠘ᠴ ᠤᠨ",
    );

    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "᠔᠘ ᠮᠢᠨᠦᠢᠲ ᠦᠨ ᠔᠒ ᠰᠧᠻᠦ᠋ᠨ᠍ᠳ᠋",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "᠔᠘ ᠮᠢᠨ᠊᠍ ᠦᠨ ᠔᠒ ᠰᠧᠻ᠍᠊᠍",
    );
    expect(
      l10n.duration(_48m_42s,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "᠔᠘ᠮ ᠦᠨ ᠔᠒ᠰ",
    );

    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "᠓᠕ ᠮᠢᠨᠦᠢᠲ ᠦᠨ",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "᠓᠕ ᠮᠢᠨ᠊᠍ ᠦᠨ",
    );
    expect(
      l10n.duration(_35m, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "᠓᠕ᠮ ᠦᠨ",
    );

    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "᠔᠒ ᠰᠧᠻᠦ᠋ᠨ᠍ᠳ᠋",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "᠔᠒ ᠰᠧᠻ᠍᠊᠍",
    );
    expect(
      l10n.duration(_42s, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "᠔᠒ᠰ",
    );

    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "ᠬᠡᠳᠦᠨ ᠬᠣᠷᠤᠮ",
    );
    expect(
      l10n.duration(_zero, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "ᠬᠣᠷᠤᠮ",
    );
    expect(
      l10n.duration(_zero,
          dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "ᠬᠣᠷᠤᠮ",
    );
  });
  test("ko_KO localization duration test", () {
    final MomentLocalization l10n = LocalizationKo();

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
}
