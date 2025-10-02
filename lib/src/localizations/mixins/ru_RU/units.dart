import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/ru_RU/unit_string.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';

abstract class CountDependentUnitString extends UnitString {
  const CountDependentUnitString();

  @override
  String get(Abbreviation form, bool dropPrefixOrSuffix, [int count = 1]);
}

mixin RuRuUnits on SimpleUnits {
  @override
  String relativePast(String unit) {
    return "$unit назад";
  }

  @override
  String relativeFuture(String unit) {
    return "через $unit";
  }

  @override
  Map<DurationInterval, CountDependentUnitString> get units => {
        DurationInterval.lessThanASecond: RussianSingularUnitString(
          "несколько секунд",
          "несколько секунд",
          "неск. сек",
        ),
        DurationInterval.aSecond: RussianSingularUnitString(
          "секунда",
          "секунду",
          "сек",
        ),
        DurationInterval.seconds: RussianPluralUnitString(
          singular: "$srDelta секунда",
          few: "$srDelta секунды",
          many: "$srDelta секунд",
          short: "$srDeltaсек",
        ),
        DurationInterval.aMinute: RussianSingularUnitString(
          "1 минута",
          "минуту",
          "мин",
        ),
        DurationInterval.minutes: RussianPluralUnitString(
          singular: "$srDelta минута",
          few: "$srDelta минуты",
          many: "$srDelta минут",
          short: "$srDeltaмин",
        ),
        DurationInterval.anHour: RussianSingularUnitString("час", "час", "ч"),
        DurationInterval.hours: RussianPluralUnitString(
          singular: "$srDelta час",
          few: "$srDelta часа",
          many: "$srDelta часов",
          short: "$srDeltaч",
        ),
        DurationInterval.aDay: RussianSingularUnitString("день", "день", "дн"),
        DurationInterval.days: RussianPluralUnitString(
          singular: "$srDelta день",
          few: "$srDelta дня",
          many: "$srDelta дней",
          short: "$srDeltaдн",
        ),
        DurationInterval.aWeek: RussianSingularUnitString(
          "1 неделя",
          "неделю",
          "1 нед",
        ),
        DurationInterval.weeks: RussianPluralUnitString(
          singular: "$srDelta неделя",
          few: "$srDelta недели",
          many: "$srDelta недель",
          short: "$srDeltaнед",
        ),
        DurationInterval.aMonth: RussianSingularUnitString(
          "месяц",
          "месяц",
          "1мес",
        ),
        DurationInterval.months: RussianPluralUnitString(
          singular: "$srDelta месяц",
          few: "$srDelta месяца",
          many: "$srDelta месяцев",
          short: "$srDeltaмес",
        ),
        DurationInterval.aYear: RussianSingularUnitString(
          "год",
          "год",
          "1г",
        ),
        DurationInterval.years: RussianPluralUnitString(
          singular: "$srDelta год",
          few: "$srDelta года",
          many: "$srDelta лет",
          short: "$srDeltaг.",
        ),
      };
}
