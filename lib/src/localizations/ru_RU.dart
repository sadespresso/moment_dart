// ignore_for_file: file_names
// Author: Your Name/GitHub Handle (Or remove if you prefer)

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_range.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/types.dart';

// TODO: Potentially add specific mixins for Russian if needed, e.g., for complex grammar rules.

/// Language: Russian
/// Country: Russia
class LocalizationRuRu extends MomentLocalization
    with
        MonthNames,
        Ordinal, // Assuming Russian ordinal numbers follow a pattern that can be handled by this or a custom mixin
        SimpleUnits,
        SimpleRelative,
        SimpleDuration,
        SimpleRange {
  static LocalizationRuRu? _instance;

  LocalizationRuRu._internal() : super();

  factory LocalizationRuRu() {
    _instance ??= LocalizationRuRu._internal();
    return _instance!;
  }

  @override
  String get endonym => "Русский";

  @override
  String get languageCode => "ru";

  @override
  String get countryCode => "RU";

  @override
  String get languageNameInEnglish => "Russian (Russia)";

  // TODO: Implement all abstract members and provide Russian translations.

  @override
  Map<int, String> get monthNames => {
        1: "январь",
        2: "февраль",
        3: "март",
        4: "апрель",
        5: "май",
        6: "июнь",
        7: "июль",
        8: "август",
        9: "сентябрь",
        10: "октябрь",
        11: "ноябрь",
        12: "декабрь",
      };

  @override
  Map<int, String> get monthNamesShort => {
        1: "янв.",
        2: "февр.",
        3: "март",
        4: "апр.",
        5: "май",
        6: "июнь",
        7: "июль",
        8: "авг.",
        9: "сент.",
        10: "окт.",
        11: "нояб.",
        12: "дек.",
      };

  @override
  Map<int, String> get weekdayName => {
        DateTime.monday: "понедельник",
        DateTime.tuesday: "вторник",
        DateTime.wednesday: "среда",
        DateTime.thursday: "четверг",
        DateTime.friday: "пятница",
        DateTime.saturday: "суббота",
        DateTime.sunday: "воскресенье",
      };

  @override
  Map<int, String> get weekdayNameShort => {
        DateTime.monday: "пн",
        DateTime.tuesday: "вт",
        DateTime.wednesday: "ср",
        DateTime.thursday: "чт",
        DateTime.friday: "пт",
        DateTime.saturday: "сб",
        DateTime.sunday: "вс",
      };

  @override
  Map<int, String> get weekdayNameMin => {
        DateTime.monday: "пн",
        DateTime.tuesday: "вт",
        DateTime.wednesday: "ср",
        DateTime.thursday: "чт",
        DateTime.friday: "пт",
        DateTime.saturday: "сб",
        DateTime.sunday: "вс",
      };

  @override
  String ordinalNumber(int n) {
    // For day of the month formatting like "1-е января"
    // This function is for Ordinal mixin, used by `Mo` (Month ordinal) and `Do` (Day of month ordinal)
    // `Do` -> 1st, 2nd, 3rd
    // Russian: 1-е, 2-е, 3-е, ... 31-е
    return "\${n}-е";
  }

  @override
  String relativePast(String unit) => "\$unit назад";
  @override
  String relativeFuture(String unit) => "через \$unit";

  @override
  FormatSetOptional overrideFormatters() {
    return {
      ...formattersWithOrdinal,
      ...formattersForMonthNames,
      // Russian specific date/time formats
      FormatterToken.L: (dateTime) => reformat(dateTime, "DD.MM.YYYY"),
      FormatterToken.l: (dateTime) => reformat(dateTime, "D.M.YYYY"),
      FormatterToken.LL: (dateTime) =>
          reformat(dateTime, "D MMMM YYYY г."), // Note: "г." is for "года" - year
      FormatterToken.ll: (dateTime) => reformat(dateTime, "D MMM YYYY г."),
      FormatterToken.LLL: (dateTime) =>
          reformat(dateTime, "D MMMM YYYY г., HH:mm"),
      FormatterToken.lll: (dateTime) =>
          reformat(dateTime, "D MMM YYYY г., HH:mm"),
      FormatterToken.LLLL: (dateTime) =>
          reformat(dateTime, "dddd, D MMMM YYYY г., HH:mm"),
      FormatterToken.llll: (dateTime) =>
          reformat(dateTime, "ddd, D MMM YYYY г., HH:mm"),
      FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
    };
  }

  @override
  CalenderLocalizationData get calendarData => calenderLocalizationDataRu;

  static const CalenderLocalizationData calenderLocalizationDataRu =
      CalenderLocalizationData(
    relativeDayNames: {
      -1: "Вчера",
      0: "Сегодня",
      1: "Завтра",
    },
    keywords: CalenderLocalizationKeywords(
      at: (date, time) => "\$date в \$time", // e.g., "Сегодня в 14:00"
      lastWeekday: (weekday) =>
          "Прошлый \$weekday", // e.g., "Прошлый понедельник"
    ),
  );

  @override
  int get weekStart => DateTime.monday; // Typical in Russia

  @override
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.lessThanASecond: UnitString.withForm(
          "несколько секунд",
          "неск. сек.",
          "~сек",
        ),
        DurationInterval.aSecond: UnitString.withForm(
          "секунда",
          "1 сек.",
          "1с",
        ),
        DurationInterval.seconds: UnitString.withForm(
          "\$srDelta секунд", // Genitive plural, common for 5+ or if specific logic isn't handled by SimpleUnits
          "\$srDelta сек.",
          "\$srDeltaс",
        ),
        DurationInterval.aMinute: UnitString.withForm(
          "минута",
          "1 мин.",
          "1м",
        ),
        DurationInterval.minutes: UnitString.withForm(
          "\$srDelta минут", // Genitive plural
          "\$srDelta мин.",
          "\$srDeltaм",
        ),
        DurationInterval.anHour: UnitString.withForm(
          "час",
          "1 ч.",
          "1ч",
        ),
        DurationInterval.hours: UnitString.withForm(
          "\$srDelta часов", // Genitive plural
          "\$srDelta ч.",
          "\$srDeltaч",
        ),
        DurationInterval.aDay: UnitString.withForm(
          "день",
          "1 д.",
          "1д",
        ),
        DurationInterval.days: UnitString.withForm(
          "\$srDelta дней", // Genitive plural
          "\$srDelta д.",
          "\$srDeltaд",
        ),
        DurationInterval.aWeek: UnitString.withForm(
          "неделя",
          "1 нед.",
          "1н",
        ),
        DurationInterval.weeks: UnitString.withForm(
          "\$srDelta недель", // Genitive plural
          "\$srDelta нед.",
          "\$srDeltaн",
        ),
        DurationInterval.aMonth: UnitString.withForm(
          "месяц",
          "1 мес.",
          "1мес",
        ),
        DurationInterval.months: UnitString.withForm(
          "\$srDelta месяцев", // Genitive plural
          "\$srDelta мес.",
          "\$srDeltaмес",
        ),
        DurationInterval.aYear: UnitString.withForm(
          "год",
          "1 г.",
          "1г",
        ),
        DurationInterval.years: UnitString.withForm(
          "\$srDelta лет", // Genitive plural
          "\$srDelta г.",
          "\$srDeltaл",
        ),
      };

  @override
  SimpleRangeData get simpleRangeData => SimpleRangeData(
        thisWeek: "На этой неделе",
        thisYear: (DateTime anchor) => "В этом году",
        year: (range, {DateTime? anchor, bool useRelative = true}) {
          if (useRelative &&
              anchor != null &&
              anchor.year == range.year) {
            return "В этом году";
          }
          return "Год \${range.year}";
        },
        thisMonth: (DateTime anchor) => "В этом месяце",
        month: (range, {DateTime? anchor, bool useRelative = true}) {
          final now = anchor ?? DateTime.now();
          if (useRelative &&
              now.year == range.year &&
              now.month == range.month) {
            return "В этом месяце";
          }
          if (useRelative && now.year == range.year) {
            return monthNames[range.month]!; // Full month name
          }
          return "\${monthNames[range.month]!} \${range.year}";
        },
        allAfter: (formattedDate) => "После \$formattedDate",
        allBefore: (formattedDate) => "До \$formattedDate",
        customRangeAllTime: "За все время",
      );

  // If Russian has specific word forms for weekdays, override this.
  // @override
  // String getWeekdayNameShort(int weekday) => super.getWeekdayNameShort(weekday);
  // @override
  // String getWeekdayNameMin(int weekday) => super.getWeekdayNameMin(weekday);
}
