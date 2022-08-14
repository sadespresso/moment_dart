import 'package:moment_dart/moment_dart.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test("MomentLocalizations.byLanguage test", () {
    expect(
      MomentLocalizations.byLanguage('mn'),
      TypeMatcher<LocalizationMnMn>(),
    );
    expect(
      MomentLocalizations.byLanguage('mn', scriptCode: 'Mong'),
      TypeMatcher<LocalizationMnMongMn>(),
    );
    expect(
      MomentLocalizations.byLanguage('mn', scriptCode: 'Qaaq'),
      TypeMatcher<LocalizationMnQaaqMn>(),
    );
    expect(
      MomentLocalizations.byLanguage('ko'),
      TypeMatcher<LocalizationKo>(),
    );
    expect(
      MomentLocalizations.byLanguage('de'),
      TypeMatcher<LocalizationDeDe>(),
    );
    expect(
      MomentLocalizations.byLanguage('es'),
      TypeMatcher<LocalizationEsEs>(),
    );
    expect(
      MomentLocalizations.byLanguage('fr'),
      TypeMatcher<LocalizationFrFr>(),
    );
    expect(
      MomentLocalizations.byLanguage('it'),
      TypeMatcher<LocalizationItIt>(),
    );
  });

  test("MomentLocalizations.byLanguage strict test", () {
    expect(
      MomentLocalizations.byLanguage('mn', strict: true),
      TypeMatcher<LocalizationMnMn>(),
    );
    expect(
      MomentLocalizations.byLanguage('mn', countryCode: 'MN', strict: true),
      TypeMatcher<LocalizationMnMn>(),
    );

    expect(
      MomentLocalizations.byLanguage(
        'mn',
        scriptCode: 'Mong',
        countryCode: 'MN',
        strict: true,
      ),
      TypeMatcher<LocalizationMnMongMn>(),
    );
    expect(
      MomentLocalizations.byLanguage(
        'mn',
        scriptCode: 'Mong',
        countryCode: 'CN',
        strict: true,
      ),
      null,
    );

    expect(
      MomentLocalizations.byLanguage(
        'mn',
        scriptCode: 'Qaaq',
        countryCode: 'MN',
        strict: true,
      ),
      TypeMatcher<LocalizationMnQaaqMn>(),
    );
    expect(
      MomentLocalizations.byLanguage(
        'mn',
        scriptCode: 'Qaaq',
        strict: true,
      ),
      TypeMatcher<LocalizationMnQaaqMn>(),
    );

    expect(
      MomentLocalizations.byLanguage(
        'ko',
        strict: true,
      ),
      TypeMatcher<LocalizationKo>(),
    );
    expect(
      MomentLocalizations.byLanguage(
        'ko',
        countryCode: 'KR',
        strict: true,
      ),
      TypeMatcher<LocalizationKo>(),
    );

    expect(
      MomentLocalizations.byLanguage(
        'de',
        countryCode: 'DE',
        strict: true,
      ),
      TypeMatcher<LocalizationDeDe>(),
    );
    expect(
      MomentLocalizations.byLanguage(
        'de',
        strict: true,
      ),
      TypeMatcher<LocalizationDeDe>(),
    );

    expect(
      MomentLocalizations.byLanguage(
        'es',
        strict: true,
      ),
      TypeMatcher<LocalizationEsEs>(),
    );
    expect(
      MomentLocalizations.byLanguage(
        'es',
        countryCode: 'ES',
        strict: true,
      ),
      TypeMatcher<LocalizationEsEs>(),
    );

    expect(
      MomentLocalizations.byLanguage(
        'fr',
        strict: true,
      ),
      TypeMatcher<LocalizationFrFr>(),
    );
    expect(
      MomentLocalizations.byLanguage(
        'fr',
        countryCode: 'FR',
        strict: true,
      ),
      TypeMatcher<LocalizationFrFr>(),
    );

    expect(
      MomentLocalizations.byLanguage(
        'it',
        strict: true,
      ),
      TypeMatcher<LocalizationItIt>(),
    );
    expect(
      MomentLocalizations.byLanguage(
        'it',
        countryCode: 'IT',
        strict: true,
      ),
      TypeMatcher<LocalizationItIt>(),
    );
  });
}