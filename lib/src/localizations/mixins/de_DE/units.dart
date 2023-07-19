import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/localizations/utils/abbreviation.dart';

class UnitStringDeDe extends UnitString {
  final String full;
  final String mid;
  final String short;

  final String? standalone;

  const UnitStringDeDe(this.full, this.mid, this.short, {this.standalone});

  @override
  String get(Abbreviation form, bool dropPrefixOrSuffix) {
    switch (form) {
      case Abbreviation.none:
        return dropPrefixOrSuffix ? (standalone ?? full) : full;
      case Abbreviation.semi:
        return mid;
      case Abbreviation.full:
        return short;
    }
  }
}
