library moment_dart_localizations;

import '../localization.dart';

import 'it_IT.dart';
export 'it_IT.dart';

import 'en_US.dart';
export 'en_US.dart';

import 'mn_MN.dart';
export 'mn_MN.dart';

import 'mn_Mong_MN.dart';
export 'mn_Mong_MN.dart';

import 'ko_KR.dart';
export 'ko_KR.dart';

import 'ja_JP.dart';
export 'ja_JP.dart';

import 'de_DE.dart';
export 'de_DE.dart';

import 'es_ES.dart';
export 'es_ES.dart';

import 'fr_FR.dart';
export 'fr_FR.dart';

import 'tr_TR.dart';
export 'tr_TR.dart';

import 'pt_PT.dart';
export 'pt_PT.dart';

import 'zh_CN.dart';
export 'zh_CN.dart';

typedef LocalizationFn = MomentLocalization Function();

abstract class MomentLocalizations {
  MomentLocalizations._();

  static Map<String, LocalizationFn> locales = {
    "en_US": () => LocalizationEnUs(),
    "mn_MN": () => LocalizationMnMn(),
    "mn_Mong_MN": () => LocalizationMnMongMn(),
    "mn_Qaaq_MN": () => LocalizationMnQaaqMn(),
    "ko_KR": () => LocalizationKoKr(),
    "ja_JP": () => LocalizationJaJp(),
    "de_DE": () => LocalizationDeDe(),
    "es_ES": () => LocalizationEsEs(),
    "fr_FR": () => LocalizationFrFr(),
    "pt_PT": () => LocalizationPtPt(),
    "tr_TR": () => LocalizationTrTr(),
    "it_IT": () => LocalizationItIt(),
    "zh_CN": () => LocalizationZhCn(),
  };

  /// Retreives locale
  ///
  /// Tries to find locales matching the criteria
  ///
  /// If `strict == false`, it tries to find closest
  /// possible match by omitting scriptCode.
  /// If still no luck, tries again with omitting countryCode
  static MomentLocalization? byLanguage(
    String languageCode, {
    String? countryCode,
    String? scriptCode,
    bool strict = false,
  }) =>
      _byLanguage(
        languageCode,
        countryCode: countryCode,
        scriptCode: scriptCode,
        strict: strict,
      );
  static MomentLocalization? _byLanguage(
    String languageCode, {
    String? countryCode,
    String? scriptCode,
    bool strict = false,
  }) {
    String prefix = languageCode;

    if (scriptCode != null) prefix += "_$scriptCode";
    if (countryCode != null) prefix += "_$countryCode";

    try {
      final String key =
          locales.keys.firstWhere((element) => element.startsWith(prefix));

      return locales[key]!();
    } on StateError {
      if (!strict) {
        if (countryCode != null) {
          // Omitting country code to try locales with matching language code and script code
          return _byLanguage(languageCode, scriptCode: scriptCode);
        }

        if (scriptCode != null) {
          // Omitting script code to try locales with matching language code and script code
          return _byLanguage(languageCode);
        }

        // If both are null, we've got nothing to omit to widen our result.
      }

      return null;
    }
  }

  static final RegExp _soleLanguageCode = RegExp(r'^[a-z]{2}$');

  /// Retreives locale by code.
  ///
  /// e.g.:
  /// * "en_US" // English (United States)
  /// * "es-ES" // Spanish (Spain)
  /// * "es" // Spanish (Spain) - Here, language code is same as country code, so Moment will return "es_ES".
  /// * "en" // **Throws error** since [MomentLocalization] with such locale doesn't exist
  ///
  /// Note that you can use dash or underscore interchangeably. **But underscore is preferred**
  static MomentLocalization? byLocale(String locale) => _byLocale(locale);

  static MomentLocalization? _byLocale(
    String locale, [
    bool tryAddCountryCode = true,
  ]) {
    final String localeFormatted = locale.replaceAll('-', '_');

    if (locales[localeFormatted] == null) {
      if (tryAddCountryCode && _soleLanguageCode.hasMatch(locale)) {
        return _byLocale("${locale}_${locale.toUpperCase()}", false);
      }
      return null;
    }

    return locales[localeFormatted]!();
  }

  /// English (United States)
  static LocalizationEnUs enUS() => LocalizationEnUs();

  /// Mongolian (Cyrillic)
  static LocalizationMnMn mn() => LocalizationMnMn();

  /// Mongolian (Traditional Mongolian Script with Roman Numerals)
  static LocalizationMnMongMn mnMong() => LocalizationMnMongMn();

  /// Mongolian (Traditional Mongolian Script with Traditional Numerals)
  static LocalizationMnQaaqMn mnMongtn() => LocalizationMnQaaqMn();

  /// Korean (South Korea)
  static LocalizationKoKr koKr() => LocalizationKoKr();

  /// Japanese (Japan)
  static LocalizationJaJp jaJp() => LocalizationJaJp();

  /// German (Germany - Standard)
  static LocalizationDeDe de() => LocalizationDeDe();

  /// Spanish (Spain)
  static LocalizationEsEs es() => LocalizationEsEs();

  /// French (France)
  static LocalizationFrFr fr() => LocalizationFrFr();

  /// Turkish (Turkey)
  static LocalizationTrTr tr() => LocalizationTrTr();

  /// Portuguese (Portuguese Republic)
  static LocalizationPtPt pt() => LocalizationPtPt();

  /// Italian (Italy)
  static LocalizationItIt it() => LocalizationItIt();

  /// Simplified Chinese (China)
  static LocalizationZhCn zhCn() => LocalizationZhCn();
}
