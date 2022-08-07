import 'package:moment_dart/src/localizations/all.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test("localization test", () {
    expect(
      MomentLocalizations.byLocale("mn_MN"),
      TypeMatcher<LocalizationMnMn>(),
    );
    expect(
      MomentLocalizations.byLocale("mn"),
      TypeMatcher<LocalizationMnMn>(),
    );

    expect(
      MomentLocalizations.byLocale("mn_Mong_MN"),
      TypeMatcher<LocalizationMnMongMn>(),
    );

    expect(
      MomentLocalizations.byLocale("mn_Qaaq_MN"),
      TypeMatcher<LocalizationMnQaaqMn>(),
    );

    expect(
      MomentLocalizations.byLocale("ko_KR"),
      TypeMatcher<LocalizationKo>(),
    );

    expect(
      MomentLocalizations.byLocale("de_DE"),
      TypeMatcher<LocalizationDeDe>(),
    );
    expect(
      MomentLocalizations.byLocale("de"),
      TypeMatcher<LocalizationDeDe>(),
    );

    expect(
      MomentLocalizations.byLocale("es_ES"),
      TypeMatcher<LocalizationEsEs>(),
    );
    expect(
      MomentLocalizations.byLocale("es"),
      TypeMatcher<LocalizationEsEs>(),
    );

    expect(
      MomentLocalizations.byLocale("fr_FR"),
      TypeMatcher<LocalizationFrFr>(),
    );
    expect(
      MomentLocalizations.byLocale("fr"),
      TypeMatcher<LocalizationFrFr>(),
    );

    expect(
      MomentLocalizations.byLocale("it_IT"),
      TypeMatcher<LocalizationItIt>(),
    );
    expect(
      MomentLocalizations.byLocale("it"),
      TypeMatcher<LocalizationItIt>(),
    );
  });
}
