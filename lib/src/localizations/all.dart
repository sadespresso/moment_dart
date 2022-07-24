library moment_dart_localizations;

import 'it.dart';
export 'it.dart';

import 'en_US.dart';
export 'en_US.dart';

import 'mn.dart';
export 'mn.dart';

import 'mn_traditional.dart';
export 'mn_traditional.dart';

import 'mn_traditional_numbers.dart';
export 'mn_traditional_numbers.dart';

import 'ko.dart';
export 'ko.dart';

import 'de_DE.dart';
export 'de_DE.dart';

import 'es.dart';
export 'es.dart';

import 'fr.dart';
export 'fr.dart';

abstract class MomentLocalizations {
  MomentLocalizations._();

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

  /// German (Germany - Standard)
  static LocalizationGermanStandard deDE() => LocalizationGermanStandard();

  /// Spanish (Spain)
  static LocalizationEs es() => LocalizationEs();

  /// French (France)
  static LocalizationFr fr() => LocalizationFr();

  /// Italian (Italy)
  static LocalizationIt it() => LocalizationIt();
}
