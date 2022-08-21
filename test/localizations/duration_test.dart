import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  /// 1y 2mo
  const Duration t1 = Duration(days: 365 + 60); // y m
  /// 3y
  const Duration t2 = Duration(days: 365 * 3 + 0); // y
  /// 3m0 17d
  const Duration t3 = Duration(days: 30 * 3 + 17); // m d
  /// 4m
  const Duration t4 = Duration(days: 30 * 4 + 0); // m
  /// 3w 2d
  const Duration t5 = Duration(days: 21 + 2); // w d
  /// 4w
  const Duration t6 = Duration(days: 28 + 0); // w
  /// 6d 7h
  const Duration t7 = Duration(days: 6, hours: 7); // d h
  /// 6d
  const Duration t8 = Duration(days: 6, hours: 0); // d
  /// 8h 8m
  const Duration t9 = Duration(hours: 8, minutes: 8); // h m
  /// 8h
  const Duration t10 = Duration(hours: 8, minutes: 0); // h
  /// 48m 42s
  const Duration t11 = Duration(minutes: 48, seconds: 42); // m s
  /// 35m
  const Duration t12 = Duration(minutes: 35, seconds: 0); // m
  /// 42s
  const Duration t13 = Duration(seconds: 42); // s
  /// 0s
  const Duration t14 = Duration(microseconds: 1); // s

  test("de_DE localization duration test", () {
    final MomentLocalization l10n = LocalizationDeDe();

    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "ein Jahr 2 Monate",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 Jr. 2 Mo.",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1y 2mo",
    );

    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Jahre",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Jr.",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3y",
    );

    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Monate 17 Tage",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Mo. 17 Tg.",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3mo 17d",
    );

    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 Monate",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 Mo.",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4mo",
    );

    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 Wochen 2 Tage",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 Wochen 2 Tg.",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3w 2d",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 Tagen",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 Tg.",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23d",
    );

    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4w",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 Tagen",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 Tg.",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28d",
    );

    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen 7 Stunden",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg. 7 Std.",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d 7h",
    );

    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg.",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d",
    );

    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden 8 Minuten",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std. 8 Min.",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h 8m",
    );

    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std.",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h",
    );

    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 Minuten 42 Sekunden",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 Min. 42 Sek.",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48m 42s",
    );

    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 Minuten",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 Min.",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35m",
    );

    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 Sekunden",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 Sek.",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42s",
    );

    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "wenigen Sekunden",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "wenigen Sek.",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "wenigen Sek.",
    );
  });
  test("it_IT localization duration test", () {
    final MomentLocalization l10n = LocalizationItIt();

    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "einem Jahr 2 Monaten",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 Jr. 2 Mo.",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1y 2mo",
    );

    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Jahren",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Jr.",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3y",
    );

    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Monaten 17 Tagen",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Mo. 17 Tg.",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3mo 17d",
    );

    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 Monaten",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 Mo.",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4mo",
    );

    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 Wochen 2 Tagen",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 Wochen 2 Tg.",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3w 2d",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 Tagen",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 Tg.",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23d",
    );

    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4w",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 Tagen",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 Tg.",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28d",
    );

    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen 7 Stunden",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg. 7 Std.",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d 7h",
    );

    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg.",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d",
    );

    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden 8 Minuten",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std. 8 Min.",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h 8m",
    );

    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std.",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h",
    );

    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 Minuten 42 Sekunden",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 Min. 42 Sek.",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48m 42s",
    );

    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 Minuten",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 Min.",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35m",
    );

    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 Sekunden",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 Sek.",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42s",
    );

    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "wenigen Sekunden",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "wenigen Sek.",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "wenigen Sek.",
    );
  });
  test("fr_FR localization duration test", () {
    final MomentLocalization l10n = LocalizationFrFr();

    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "einem Jahr 2 Monaten",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 Jr. 2 Mo.",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1y 2mo",
    );

    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Jahren",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Jr.",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3y",
    );

    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Monaten 17 Tagen",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Mo. 17 Tg.",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3mo 17d",
    );

    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 Monaten",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 Mo.",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4mo",
    );

    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 Wochen 2 Tagen",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 Wochen 2 Tg.",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3w 2d",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 Tagen",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 Tg.",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23d",
    );

    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4w",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 Tagen",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 Tg.",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28d",
    );

    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen 7 Stunden",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg. 7 Std.",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d 7h",
    );

    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg.",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d",
    );

    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden 8 Minuten",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std. 8 Min.",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h 8m",
    );

    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std.",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h",
    );

    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 Minuten 42 Sekunden",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 Min. 42 Sek.",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48m 42s",
    );

    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 Minuten",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 Min.",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35m",
    );

    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 Sekunden",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 Sek.",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42s",
    );

    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "wenigen Sekunden",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "wenigen Sek.",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "wenigen Sek.",
    );
  });
  test("es_ES localization duration test", () {
    final MomentLocalization l10n = LocalizationEsEs();

    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "einem Jahr 2 Monaten",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 Jr. 2 Mo.",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1y 2mo",
    );

    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Jahren",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Jr.",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3y",
    );

    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Monaten 17 Tagen",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Mo. 17 Tg.",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3mo 17d",
    );

    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 Monaten",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 Mo.",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4mo",
    );

    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 Wochen 2 Tagen",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 Wochen 2 Tg.",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3w 2d",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 Tagen",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 Tg.",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23d",
    );

    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4w",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 Tagen",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 Tg.",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28d",
    );

    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen 7 Stunden",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg. 7 Std.",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d 7h",
    );

    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg.",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d",
    );

    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden 8 Minuten",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std. 8 Min.",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h 8m",
    );

    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std.",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h",
    );

    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 Minuten 42 Sekunden",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 Min. 42 Sek.",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48m 42s",
    );

    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 Minuten",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 Min.",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35m",
    );

    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 Sekunden",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 Sek.",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42s",
    );

    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "wenigen Sekunden",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "wenigen Sek.",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "wenigen Sek.",
    );
  });
  test("en_US localization duration test", () {
    final MomentLocalization l10n = LocalizationEnUs();

    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "a year 2 months",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 yr 2 mo",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1y 2mo",
    );

    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 years",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 yr",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3y",
    );

    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 months 17 days",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 mo 17 day",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3mo 17d",
    );

    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 months",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 mo",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4mo",
    );

    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 weeks 2 days",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 wk 2 day",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3w 2d",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 days",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 day",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23d",
    );

    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 weeks",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 wk",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4w",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 days",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 day",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28d",
    );

    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 days 7 hours",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 day 7 hr",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d 7h",
    );

    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 days",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 day",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d",
    );

    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 hours 8 minutes",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 hr 8 min",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h 8m",
    );

    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 hours",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 hr",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h",
    );

    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 minutes 42 seconds",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 min 42 sec",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48m 42s",
    );

    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 minutes",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 min",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35m",
    );

    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 seconds",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 sec",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42s",
    );

    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "a few seconds",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "a few sec",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "a sec",
    );
  });
  test("mn_MN localization duration test", () {
    final MomentLocalization l10n = LocalizationMnMn();

    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "1 жил 2 сар",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 жил 2 сар",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1жил 2сар",
    );

    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Jahren",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Jr.",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3y",
    );

    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Monaten 17 Tagen",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Mo. 17 Tg.",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3mo 17d",
    );

    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 Monaten",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 Mo.",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4mo",
    );

    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 Wochen 2 Tagen",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 Wochen 2 Tg.",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3w 2d",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 Tagen",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 Tg.",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23d",
    );

    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4w",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 Tagen",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 Tg.",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28d",
    );

    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen 7 Stunden",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg. 7 Std.",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d 7h",
    );

    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg.",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d",
    );

    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden 8 Minuten",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std. 8 Min.",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h 8m",
    );

    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std.",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h",
    );

    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 Minuten 42 Sekunden",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 Min. 42 Sek.",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48m 42s",
    );

    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 Minuten",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 Min.",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35m",
    );

    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 Sekunden",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 Sek.",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42s",
    );

    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "wenigen Sekunden",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "wenigen Sek.",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "wenigen Sek.",
    );
  });
  test("mn_Mong_MN localization duration test", () {
    final MomentLocalization l10n = LocalizationMnMongMn();

    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "einem Jahr 2 Monaten",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 Jr. 2 Mo.",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1y 2mo",
    );

    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Jahren",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Jr.",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3y",
    );

    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Monaten 17 Tagen",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Mo. 17 Tg.",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3mo 17d",
    );

    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 Monaten",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 Mo.",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4mo",
    );

    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 Wochen 2 Tagen",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 Wochen 2 Tg.",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3w 2d",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 Tagen",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 Tg.",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23d",
    );

    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4w",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 Tagen",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 Tg.",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28d",
    );

    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen 7 Stunden",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg. 7 Std.",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d 7h",
    );

    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg.",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d",
    );

    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden 8 Minuten",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std. 8 Min.",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h 8m",
    );

    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std.",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h",
    );

    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 Minuten 42 Sekunden",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 Min. 42 Sek.",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48m 42s",
    );

    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 Minuten",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 Min.",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35m",
    );

    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 Sekunden",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 Sek.",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42s",
    );

    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "wenigen Sekunden",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "wenigen Sek.",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "wenigen Sek.",
    );
  });
  test("mn_Qaaq_MN localization duration test", () {
    final MomentLocalization l10n = LocalizationDeDe();

    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "einem Jahr 2 Monaten",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 Jr. 2 Mo.",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1y 2mo",
    );

    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Jahren",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Jr.",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3y",
    );

    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Monaten 17 Tagen",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Mo. 17 Tg.",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3mo 17d",
    );

    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 Monaten",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 Mo.",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4mo",
    );

    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 Wochen 2 Tagen",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 Wochen 2 Tg.",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3w 2d",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 Tagen",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 Tg.",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23d",
    );

    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4w",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 Tagen",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 Tg.",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28d",
    );

    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen 7 Stunden",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg. 7 Std.",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d 7h",
    );

    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg.",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d",
    );

    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden 8 Minuten",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std. 8 Min.",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h 8m",
    );

    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std.",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h",
    );

    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 Minuten 42 Sekunden",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 Min. 42 Sek.",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48m 42s",
    );

    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 Minuten",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 Min.",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35m",
    );

    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 Sekunden",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 Sek.",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42s",
    );

    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "wenigen Sekunden",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "wenigen Sek.",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "wenigen Sek.",
    );
  });
  test("ko_KO localization duration test", () {
    final MomentLocalization l10n = LocalizationDeDe();

    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "einem Jahr 2 Monaten",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "1 Jr. 2 Mo.",
    );
    expect(
      l10n.duration(t1, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "1y 2mo",
    );

    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Jahren",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Jr.",
    );
    expect(
      l10n.duration(t2, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3y",
    );

    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "3 Monaten 17 Tagen",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "3 Mo. 17 Tg.",
    );
    expect(
      l10n.duration(t3, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "3mo 17d",
    );

    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "4 Monaten",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "4 Mo.",
    );
    expect(
      l10n.duration(t4, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "4mo",
    );

    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "3 Wochen 2 Tagen",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "3 Wochen 2 Tg.",
    );
    expect(
      l10n.duration(
        t5,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "3w 2d",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "23 Tagen",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "23 Tg.",
    );
    expect(
      l10n.duration(t5, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "23d",
    );

    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.full,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.mid,
      ),
      "4 Wochen",
    );
    expect(
      l10n.duration(
        t6,
        dropPrefixOrSuffix: true,
        includeWeeks: true,
        form: UnitStringForm.short,
      ),
      "4w",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "28 Tagen",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "28 Tg.",
    );
    expect(
      l10n.duration(t6, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "28d",
    );

    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen 7 Stunden",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg. 7 Std.",
    );
    expect(
      l10n.duration(t7, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d 7h",
    );

    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "6 Tagen",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "6 Tg.",
    );
    expect(
      l10n.duration(t8, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "6d",
    );

    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden 8 Minuten",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std. 8 Min.",
    );
    expect(
      l10n.duration(t9, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h 8m",
    );

    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "8 Stunden",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "8 Std.",
    );
    expect(
      l10n.duration(t10, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "8h",
    );

    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "48 Minuten 42 Sekunden",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "48 Min. 42 Sek.",
    );
    expect(
      l10n.duration(t11, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "48m 42s",
    );

    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "35 Minuten",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "35 Min.",
    );
    expect(
      l10n.duration(t12, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "35m",
    );

    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "42 Sekunden",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "42 Sek.",
    );
    expect(
      l10n.duration(t13, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "42s",
    );

    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.full),
      "wenigen Sekunden",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.mid),
      "wenigen Sek.",
    );
    expect(
      l10n.duration(t14, dropPrefixOrSuffix: true, form: UnitStringForm.short),
      "wenigen Sek.",
    );
  });
}
