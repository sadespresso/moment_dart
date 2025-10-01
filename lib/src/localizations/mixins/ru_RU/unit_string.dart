import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/ru_RU/units.dart';

class RussianSingularUnitString extends CountDependentUnitString {
  final String imenitelniyPadej;
  final String vinitelniyPadej;
  final String short;

  const RussianSingularUnitString(
    this.imenitelniyPadej,
    this.vinitelniyPadej,
    this.short,
  );

  @override
  String get(Abbreviation form, bool dropPrefixOrSuffix, [int count = 1]) {
    if (form != Abbreviation.none) {
      return short;
    }

    if (dropPrefixOrSuffix) {
      return imenitelniyPadej;
    }

    return vinitelniyPadej;
  }
}

class RussianPluralUnitString extends CountDependentUnitString {
  final String singular;
  final String few;
  final String many;
  final String short;

  RussianPluralUnitString(
      {required this.singular,
      required this.few,
      required this.many,
      required this.short});

  @override
  String get(Abbreviation form, bool dropPrefixOrSuffix, [int count = 1]) {
    if (form != Abbreviation.none) {
      return short;
    }
    // Rules for Russian pluralization:
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
