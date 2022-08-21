import 'package:moment_dart/src/extensions/benefits.dart';
import 'package:moment_dart/src/localizations/utils/duration_unit.dart';

/// [units] must be in descending order
class DurationFormat {
  final List<DurationUnit> units;

  /// [units] should be provi ded in descending order
  ///
  /// If not, result produced with [this] format is unexpected
  const DurationFormat(this.units);

  int get length => units.length;

  /// Returns [units.last], will throw [StateError] if [units] is empty
  DurationUnit get last => units.last;
  bool get isAuto => length == 0;

  /// Returns most suitable [DurationFormat] for [duration]
  ///
  /// Set [includeWeeks] to true if you need *week* as a unit
  static DurationFormat resolveAuto(
    Duration duration, [
    bool includeWeeks = false,
  ]) {
    // I don't really want to deal with minus sign when making comparisons.
    duration = duration.abs();

    if (duration.inYears >= 1) {
      return DurationFormat.ym;
    } else if (duration.inMonths >= 1) {
      return DurationFormat.md;
    } else if (includeWeeks && duration.inWeeks >= 1) {
      return DurationFormat.wd;
    } else if (duration.inDays >= 1) {
      return DurationFormat.dh;
    } else if (duration.inHours >= 1) {
      return DurationFormat.hm;
    } else if (duration.inMinutes >= 1) {
      return DurationFormat.ms;
    } else {
      return DurationFormat.s;
    }
  }

  /// Tries to find the most optimal format for the duration
  static const DurationFormat auto = DurationFormat([]);

  /// X year(s) y months
  static const DurationFormat ym =
      DurationFormat([DurationUnit.year, DurationUnit.month]);

  /// X month(s) y day(s)
  static const DurationFormat md =
      DurationFormat([DurationUnit.month, DurationUnit.day]);

  /// X week(s) y day(s)
  static const DurationFormat wd =
      DurationFormat([DurationUnit.week, DurationUnit.day]);

  /// X day(s) y hour(s)
  static const DurationFormat dh =
      DurationFormat([DurationUnit.day, DurationUnit.hour]);

  /// X minute(s) y second(s)
  static const DurationFormat hm =
      DurationFormat([DurationUnit.hour, DurationUnit.minute]);

  /// X minute(s) y second(s)
  static const DurationFormat ms =
      DurationFormat([DurationUnit.minute, DurationUnit.second]);

  /// X second(s)
  static const DurationFormat s = DurationFormat([DurationUnit.second]);
}
