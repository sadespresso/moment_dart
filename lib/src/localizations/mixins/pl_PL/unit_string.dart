import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/pl_PL/units.dart';

class PolishSingularUnitString extends CountDependentUnitString {
  final String mianownik;
  final String biernik;
  final String short;

  const PolishSingularUnitString(
    this.mianownik,
    this.biernik,
    this.short,
  );

  @override
  String get(Abbreviation form, bool dropPrefixOrSuffix, [int count = 1]) {
    if (form != Abbreviation.none) {
      return short;
    }

    if (dropPrefixOrSuffix) {
      return mianownik;
    }

    return biernik;
  }
}

class PolishPluralUnitString extends CountDependentUnitString {
  final String singular;
  final String few;
  final String many;
  final String short;

  const PolishPluralUnitString({
    required this.singular,
    required this.few,
    required this.many,
    required this.short,
  });

  @override
  String get(Abbreviation form, bool dropPrefixOrSuffix, [int count = 1]) {
    if (form != Abbreviation.none) {
      return short;
    }
    // Rules for Polish pluralization (same as Russian/Slavic):
    // 1. If number ends with 1 but not 11: singular
    // 2. If number ends with 2-4 but not 12-14: few
    // 3. Otherwise: many
    if ((count % 10) == 1 && (count % 100) != 11) {
      return singular;
    } else if ([2, 3, 4].contains(count % 10) &&
        ![12, 13, 14].contains(count % 100)) {
      return few;
    } else {
      return many;
    }
  }
}
