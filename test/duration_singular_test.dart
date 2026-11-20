// ignore_for_file: constant_identifier_names

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:test/test.dart';

const Duration _2h1m = Duration(hours: 2, minutes: 1);
const Duration _1h1m1s = Duration(hours: 1, minutes: 1, seconds: 1);
const Duration _1h = Duration(hours: 1);
const Duration _1m = Duration(minutes: 1);
const Duration _1d = Duration(days: 1);
const Duration _1y = Duration(days: 365);

/// A third-party localization built on the simple mixins that does not
/// override [SimpleUnits.durationUnits].
class _ThirdParty extends MomentLocalization with SimpleUnits, SimpleDuration {
  final LocalizationEnUs _en = LocalizationEnUs();

  @override
  Map<DurationInterval, UnitString> get units => _en.units;

  @override
  String relativePast(String unit) => "$unit ago";

  @override
  String relativeFuture(String unit) => "in $unit";

  @override
  String relative(
    Duration duration, {
    bool dropPrefixOrSuffix = false,
    Abbreviation form = Abbreviation.none,
  }) =>
      _en.relative(duration, dropPrefixOrSuffix: dropPrefixOrSuffix);

  @override
  Map<FormatterToken, FormatterTokenFn?> overrideFormatters() => {};

  @override
  CalendarLocalizationData? get calendarData => null;

  @override
  Map<int, String> get weekdayName => _en.weekdayName;

  @override
  String get languageCode => "xx";

  @override
  String? get countryCode => null;

  @override
  String get endonym => "Test";

  @override
  String get languageNameInEnglish => "Test";
}

void main() {
  group("duration() numbers singular units", () {
    test("en_US", () {
      final l10n = LocalizationEnUs();

      expect(l10n.duration(_2h1m), "in 2 hours 1 minute");
      expect(l10n.duration(-_1h1m1s, format: DurationFormat.all),
          "1 hour 1 minute 1 second ago");
      expect(l10n.duration(_1h), "in 1 hour");
      expect(l10n.duration(-_1m), "1 minute ago");
      expect(l10n.duration(_1d), "in 1 day");
      expect(l10n.duration(-_1y), "1 year ago");
      expect(l10n.duration(const Duration(days: 7), includeWeeks: true),
          "in 1 week");
      expect(l10n.duration(const Duration(seconds: 1)), "in 1 second");
      expect(l10n.duration(_1h, dropPrefixOrSuffix: true), "1 hour");
      expect(l10n.duration(Duration.zero), "in a few seconds");
    });

    test("de_DE", () {
      final l10n = LocalizationDeDe();

      expect(l10n.duration(_2h1m), "in 2 Stunden 1 Minute");
      expect(l10n.duration(-_1m), "vor 1 Minute");
      expect(l10n.duration(_1h), "in 1 Stunde");
      expect(l10n.duration(-_1d), "vor 1 Tag");
      expect(l10n.duration(_1y), "in 1 Jahr");
      expect(l10n.duration(_1y, dropPrefixOrSuffix: true), "1 Jahr");
      expect(l10n.duration(const Duration(days: 30)), "in 1 Monat");
      expect(l10n.duration(const Duration(days: 7), includeWeeks: true),
          "in 1 Woche");
    });

    test("es_ES", () {
      final l10n = LocalizationEsEs();

      expect(l10n.duration(_2h1m), "en 2 horas 1 minuto");
      expect(l10n.duration(_1h), "en 1 hora");
      expect(l10n.duration(-_1d), "hace 1 día");
      expect(l10n.duration(_1y), "en 1 año");
    });

    test("fr_FR", () {
      final l10n = LocalizationFrFr();

      expect(l10n.duration(_2h1m), "dans 2 heures 1 minute");
      expect(l10n.duration(_1h), "dans 1 heure");
      expect(l10n.duration(-_1d), "il y a 1 jour");
      expect(l10n.duration(_1y), "dans 1 an");
    });

    test("it_IT", () {
      final l10n = LocalizationItIt();

      expect(l10n.duration(_2h1m), "tra 2 ore 1 minuto");
      expect(l10n.duration(_1h), "tra 1 ora");
      expect(l10n.duration(-_1d), "1 giorno fa");
      expect(l10n.duration(_1y), "tra 1 anno");
    });

    test("pt_PT", () {
      final l10n = LocalizationPtPt();

      expect(l10n.duration(_2h1m), "em 2 horas 1 minuto");
      expect(l10n.duration(-_1h1m1s, format: DurationFormat.all),
          "há 1 hora 1 minuto 1 segundo");
      expect(l10n.duration(_1h), "em 1 hora");
      expect(l10n.duration(const Duration(days: 30)), "em 1 mês");
    });

    test("tr_TR", () {
      final l10n = LocalizationTrTr();

      expect(l10n.duration(_2h1m), "2 saat 1 dakika sonra");
      expect(l10n.duration(_1h), "1 saat sonra");
      expect(l10n.duration(-_1d), "1 gün önce");
      expect(l10n.duration(_1y), "1 yıl sonra");
    });

    test("CJK already numbered", () {
      expect(LocalizationJaJp().duration(_2h1m), "2時間1分後");
      expect(LocalizationKoKr().duration(_2h1m), "2시간 1분 후");
      expect(LocalizationZhCn().duration(_2h1m), "2 小时 1 分钟后");
    });
  });

  test("abbreviated duration forms keep the number", () {
    expect(LocalizationEnUs().duration(_2h1m, form: Abbreviation.semi),
        "in 2 hr 1 min");
    expect(LocalizationEnUs().duration(_2h1m, form: Abbreviation.full),
        "in 2h 1m");
    expect(
        LocalizationDeDe().duration(_1h, form: Abbreviation.semi), "in 1 Std.");
    expect(LocalizationEsEs().duration(_1h, form: Abbreviation.full), "en 1 h");
    expect(LocalizationTrTr().duration(-_1m, form: Abbreviation.semi),
        "1 dk önce");
  });

  test("relative() keeps the article form", () {
    expect(LocalizationEnUs().relative(_1h), "in an hour");
    expect(LocalizationEnUs().relative(-_1m), "a minute ago");
    expect(LocalizationDeDe().relative(_1h), "in einer Stunde");
    expect(LocalizationDeDe().relative(-_1d), "vor einem Tag");
    expect(LocalizationEsEs().relative(_1h), "en una hora");
    expect(LocalizationFrFr().relative(_1h), "dans une heure");
    expect(LocalizationItIt().relative(_1h), "tra un'ora");
    expect(LocalizationPtPt().relative(_1h), "em uma hora");
    expect(LocalizationTrTr().relative(_1h), "bir saat sonra");
  });

  test("durationUnits defaults to units for third-party localizations", () {
    expect(_ThirdParty().duration(_2h1m), "in 2 hours a minute");
  });
}
