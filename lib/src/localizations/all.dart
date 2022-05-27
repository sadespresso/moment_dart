library moment_dart_localizations;

import './en_US.dart';
export './en_US.dart';

import './mn_MN.dart';
export './mn_MN.dart';

import './mn_TM.dart';
export './mn_TM.dart';

import './mn_TM_tn.dart';
export './mn_TM_tn.dart';

import './ko_KO.dart';
export './ko_KO.dart';

import './de_DE.dart';
export './de_DE.dart';

abstract class MomentLocalizations {
  /// English (United States)
  static LocalizationEnUs enUS() => LocalizationEnUs();

  /// Mongolian (Cyrillic)
  static LocalizationMongolianCyrillic mn() => LocalizationMongolianCyrillic();

  /// Mongolian (Traditional Mongolian Script with Roman Numerals)
  static LocalizationMongolianTraditional mnTM() =>
      LocalizationMongolianTraditional();

  /// Mongolian (Traditional Mongolian Script with Traditional Numerals)
  static LocalizationMongolianTraditionalNumbers mnTMtn() =>
      LocalizationMongolianTraditionalNumbers();

  /// Korean (South Korea)
  static LocalizationKorean ko() => LocalizationKorean();

  /// German (Germany, Standard)
  static LocalizationGermanStandard deDE() => LocalizationGermanStandard();
}
