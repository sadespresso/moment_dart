import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/localizations/utils/unit_form.dart';

class UnitStringDeDe extends UnitString {
  final String full;
  final String mid;
  final String short;

  final String? standalone;

  const UnitStringDeDe(this.full, this.mid, this.short, {this.standalone});

  @override
  String get(UnitStringForm form, bool dropPrefixOrSuffix) {
    switch (form) {
      case UnitStringForm.full:
        return dropPrefixOrSuffix ? (standalone ?? full) : full;
      case UnitStringForm.mid:
        return mid;
      case UnitStringForm.short:
        return short;
    }
  }
}
