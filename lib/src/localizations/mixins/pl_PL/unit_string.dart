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
    // Polish pluralization rules (differ from Russian for "one"):
    // 1. Exactly 1: singular (unlike Russian where 21, 31, etc. are also singular)
    // 2. If number ends with 2-4 but not 12-14: few
    // 3. Otherwise: many
    if (count == 1) {
      return singular;
    } else if ([2, 3, 4].contains(count % 10) &&
        ![12, 13, 14].contains(count % 100)) {
      return few;
    } else {
      return many;
    }
  }
}
