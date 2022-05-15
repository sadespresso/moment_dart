library moment_dart_localizations;

import 'package:moment_dart/src/localizations.dart';

import './en_US.dart';
import './mn_MN.dart';
import './mn_TM.dart';
import './mn_TM_tn.dart';
import './ko_KO.dart';
import './de_DE.dart';

abstract class MomentLocalizations {
  /// English (United States)
  static MomentLocalization enUS() => LocalizationEnUs();

  /// Mongolian (Cyrillic)
  static MomentLocalization mn() => LocalizationMongolianCyrillic();

  /// Mongolian (Traditional Mongolian Script with Roman Numerals)
  static MomentLocalization mnTM() => LocalizationMongolianTraditional();

  /// Mongolian (Traditional Mongolian Script with Traditional Numerals)
  static MomentLocalization mnTMtn() => LocalizationMongolianTraditionalNumbers();

  /// Korean (South Korea)
  static MomentLocalization ko() => LocalizationKorean();

  /// German (Germany, Standard)
  static MomentLocalization deDE() => LocalizationGermanStandard();
}
