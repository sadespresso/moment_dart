import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/localizations/utils/duration_unit.dart';
import 'package:moment_dart/src/localizations/utils/relative_interval.dart';
import 'package:moment_dart/src/localizations/utils/unit_form.dart';

/// This mixin provides:
///
/// * [srDelta] - string getter;
/// * [units] - map of unit translations that use [srDelta] as unit placeholder
/// * [relativePast] - A function suffixes/prefixes given duration
/// * [relativeFuture] - A function suffixes/prefixes given duration
mixin MnMongMnUnits on SimpleUnits {
  /// This is used as a placeholder for unit in plural expressions
  @override
  String get srDelta => "%";

  String getUnit(
    DurationInterval interval,
    UnitStringForm form, {
    bool dropPrefixOrSuffix = false,
  }) {
    final String result = units[interval]![form];

    if (dropPrefixOrSuffix) return result;

    final useFeminineSuffix = interval != DurationInterval.fewSeconds &&
        (interval.unit == DurationUnit.minute ||
            interval.unit == DurationUnit.second ||
            interval.unit == DurationUnit.day);

    late final String suffix; // Language specific stuff

    if (interval.unit == DurationUnit.month) {
      suffix = " ᠶᠢᠨ";
    } else {
      suffix = (useFeminineSuffix ? " ᠦᠨ" : " ᠤᠨ");
    }

    return result + suffix;
  }

  @override
  String relativePast(String unit) => "$unit ᠡᠮᠦᠨ᠎ᠡ";
  @override
  String relativeFuture(String unit) => "$unit ᠳᠠᠷᠠᠭ᠎ᠠ";

  @override
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.fewSeconds: UnitString(
          "ᠬᠡᠳᠦᠨ ᠬᠣᠷᠤᠮ",
          "ᠬᠣᠷᠤᠮ",
          "ᠬᠣᠷᠤᠮ",
        ),
        DurationInterval.aSecond: UnitString(
          "1 ᠰᠧᠻᠦ᠋ᠨ᠍ᠳ᠋",
          "1 ᠰᠧᠻ᠊᠍",
          "1ᠰ",
        ),
        DurationInterval.seconds: UnitString(
          "$srDelta ᠰᠧᠻᠦ᠋ᠨ᠍ᠳ᠋",
          "$srDelta ᠰᠧᠻ᠍᠊᠍",
          "$srDeltaᠰ",
        ),
        DurationInterval.aMinute: UnitString(
          "1 ᠮᠢᠨᠦᠢᠲ",
          "1 ᠮᠢᠨ᠊᠍",
          "1ᠮ",
        ),
        DurationInterval.minutes: UnitString(
          "$srDelta ᠮᠢᠨᠦᠢᠲ",
          "$srDelta ᠮᠢᠨ᠊᠍",
          "$srDeltaᠮ",
        ),
        DurationInterval.anHour: UnitString(
          "1 ᠴᠠᠭ",
          "1 ᠴᠠᠭ",
          "1ᠴ",
        ),
        DurationInterval.hours: UnitString(
          "$srDelta ᠴᠠᠭ",
          "$srDelta ᠴᠠᠭ",
          "$srDeltaᠴ",
        ),
        DurationInterval.aDay: UnitString(
          "1 ᠡᠳᠦᠷ",
          "1 ᠡᠳᠦᠷ",
          "1ᠥ",
        ),
        DurationInterval.days: UnitString(
          "$srDelta ᠡᠳᠦᠷ",
          "$srDelta ᠡᠳᠦᠷ",
          "$srDeltaᠥ",
        ),
        DurationInterval.aWeek: UnitString(
          "1 ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ",
          "1 ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨ᠍᠊᠍",
          "1ᠳᠣ.ᠬᠣᠨ᠍᠊᠍",
        ),
        DurationInterval.weeks: UnitString(
          "$srDelta ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ",
          "$srDelta ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨ᠍᠊᠍",
          "$srDeltaᠳᠣ.ᠬᠣᠨ᠍᠊᠍",
        ),
        DurationInterval.aMonth: UnitString(
          "1 ᠰᠠᠷ᠎ᠠ",
          "1 ᠰᠠ᠊᠍",
          "1ᠰᠠ᠊᠍",
        ),
        DurationInterval.months: UnitString(
          "$srDelta ᠰᠠᠷ᠎ᠠ",
          "$srDelta ᠰᠠ᠊᠍",
          "$srDeltaᠰᠠ᠊᠍",
        ),
        DurationInterval.aYear: UnitString(
          "1 ᠵᠢᠯ",
          "1 ᠵᠢᠯ",
          "1ᠵᠢᠯ",
        ),
        DurationInterval.years: UnitString(
          "$srDelta ᠵᠢᠯ",
          "$srDelta ᠵᠢᠯ",
          "$srDeltaᠵᠢᠯ",
        ),
      };
}
