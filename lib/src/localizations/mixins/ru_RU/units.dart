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
          "неск. сек.",
        ),
        DurationInterval.aSecond: RussianSingularUnitString(
          "секунда",
          "секунду",
          "1 сек.",
        ),
        DurationInterval.seconds: RussianPluralUnitString(
          singular: "$srDelta секунда",
          singularAccusative: "$srDelta секунду",
          few: "$srDelta секунды",
          many: "$srDelta секунд",
          short: "$srDelta сек.",
        ),
        DurationInterval.aMinute: RussianSingularUnitString(
          "1 минута",
          "минуту",
          "1 мин",
        ),
        DurationInterval.minutes: RussianPluralUnitString(
          singular: "$srDelta минута",
          singularAccusative: "$srDelta минуту",
          few: "$srDelta минуты",
          many: "$srDelta минут",
          short: "$srDelta мин",
        ),
        DurationInterval.anHour: RussianSingularUnitString("час", "час", "1 ч"),
        DurationInterval.hours: RussianPluralUnitString(
          singular: "$srDelta час",
          few: "$srDelta часа",
          many: "$srDelta часов",
          short: "$srDelta ч",
        ),
        DurationInterval.aDay:
            RussianSingularUnitString("день", "день", "1 дн."),
        DurationInterval.days: RussianPluralUnitString(
          singular: "$srDelta день",
          few: "$srDelta дня",
          many: "$srDelta дней",
          short: "$srDelta дн.",
        ),
        DurationInterval.aWeek: RussianSingularUnitString(
          "1 неделя",
          "неделю",
          "1 нед.",
        ),
        DurationInterval.weeks: RussianPluralUnitString(
          singular: "$srDelta неделя",
          singularAccusative: "$srDelta неделю",
          few: "$srDelta недели",
          many: "$srDelta недель",
          short: "$srDelta нед.",
        ),
        DurationInterval.aMonth: RussianSingularUnitString(
          "месяц",
          "месяц",
          "1 мес.",
        ),
        DurationInterval.months: RussianPluralUnitString(
          singular: "$srDelta месяц",
          few: "$srDelta месяца",
          many: "$srDelta месяцев",
          short: "$srDelta мес.",
        ),
        DurationInterval.aYear: RussianSingularUnitString(
          "год",
          "год",
          "1 г.",
        ),
        DurationInterval.years: RussianPluralUnitString(
          singular: "$srDelta год",
          few: "$srDelta года",
          many: "$srDelta лет",
          short: "$srDelta г.",
        ),
      };
}
