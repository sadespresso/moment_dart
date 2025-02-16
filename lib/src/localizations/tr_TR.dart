// ignore_for_file: file_names
// Author: Batmend Ganbaatar (https://github.com/sadespresso)

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_range.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/localizations/mixins/weekday_shortforms.dart';
import 'package:moment_dart/src/types.dart';

/// Language: Turkish (Turkey)
/// Country: Turkey
class LocalizationTrTr extends MomentLocalization
    with
        MonthNames,
        Ordinal,
        SimpleUnits,
        SimpleRelative,
        SimpleDuration,
        SimpleRange,
        WeekdayShortForms {
  static LocalizationTrTr? _instance;

  LocalizationTrTr._internal() : super();

  factory LocalizationTrTr() {
    _instance ??= LocalizationTrTr._internal();

    return _instance!;
  }

  @override
  String get endonym => "Türkçe";

  @override
  String get languageCode => "tr";

  @override
  String get countryCode => "TR";

  @override
  String get languageNameInEnglish => "Turkish (Turkey)";

  @override
  String relativePast(String unit) => "$unit önce";
  @override
  String relativeFuture(String unit) => "$unit sonra";

  @override
  Map<int, String> get monthNames => {
        1: "Ocak",
        2: "Şubat",
        3: "Mart",
        4: "Nisan",
        5: "Mayıs",
        6: "Haziran",
        7: "Temmuz",
        8: "Ağustos",
        9: "Eylül",
        10: "Ekim",
        11: "Kasım",
        12: "Aralık",
      };

  @override
  Map<int, String> get monthNamesShort => monthNames.map(
        (key, value) => MapEntry(
          key,
          value.substring(0, 3),
        ),
      );

  @override
  Map<int, String> get weekdayName => {
        DateTime.monday: "Pazartesi",
        DateTime.tuesday: "Salı",
        DateTime.wednesday: "Çarşamba",
        DateTime.thursday: "Perşembe",
        DateTime.friday: "Cuma",
        DateTime.saturday: "Cumartesi",
        DateTime.sunday: "Pazar",
      };

  @override
  Map<int, String> get weekdayNameShort => {
        DateTime.monday: "Pzt",
        DateTime.tuesday: "Sal",
        DateTime.wednesday: "Çar",
        DateTime.thursday: "Per",
        DateTime.friday: "Cum",
        DateTime.saturday: "Cmt",
        DateTime.sunday: "Paz",
      };

  @override
  Map<int, String> get weekdayNameMin => {
        DateTime.monday: 'Pt',
        DateTime.tuesday: 'Sa',
        DateTime.wednesday: 'Ça',
        DateTime.thursday: 'Pe',
        DateTime.friday: 'Cu',
        DateTime.saturday: 'Ct',
        DateTime.sunday: 'Pz',
      };

  @override
  FormatSetOptional overrideFormatters() {
    return {
      // From [EnglishLikeOrdinal] mixin
      ...formattersWithOrdinal,
      // From [MonthNames] mixin
      ...formattersForMonthNames,
      // From [WeekdayShortForms] mixin
      ...formattersForWeekdayShortForms,
      // Localization aware formats
      FormatterToken.L: (dateTime) => reformat(dateTime, "DD.MM.YYYY"),
      FormatterToken.l: (dateTime) => reformat(dateTime, "D.M.YYYY"),
      FormatterToken.LL: (dateTime) => reformat(dateTime, "D MMMM YYYY"),
      FormatterToken.ll: (dateTime) => reformat(dateTime, "D MMM YYYY"),
      FormatterToken.LLL: (dateTime) => reformat(dateTime, "D MMMM YYYY HH:mm"),
      FormatterToken.lll: (dateTime) => reformat(dateTime, "D MMM YYYY H:mm"),
      FormatterToken.LLLL: (dateTime) =>
          reformat(dateTime, "dddd, D MMMM YYYY HH:mm"),
      FormatterToken.llll: (dateTime) =>
          reformat(dateTime, "ddd, D MMM YYYY H:mm"),
      FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
    };
  }

  @override
  String ordinalNumber(int n) {
    if (n == 0) return "$n'ıncı";

    final int unit = n % 10;
    final String? unitEnding = _ordinalUnitSuffixes[unit];

    if (unitEnding != null) return "$n$unitEnding";

    final int tenth = (n % 100) - unit;

    final String? tenEnding = _ordinalNonUnitSuffixes[tenth];
    if (tenEnding != null) return "$n$tenEnding";

    return "$n'üncü";
  }

  @override
  CalenderLocalizationData get calendarData => calenderLocalizationDataTrTr;

  static String last(String weekday) => "Geçen $weekday";
  static String at(String date, String time) => "$date saat $time";

  static const CalenderLocalizationData calenderLocalizationDataTrTr =
      CalenderLocalizationData(
    relativeDayNames: {
      -1: "Dün",
      0: "Bugün",
      1: "Yarın",
    },
    keywords: CalenderLocalizationKeywords(
      at: at,
      lastWeekday: last,
    ),
  );

  @override
  int get weekStart => DateTime.monday;

  @override
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.lessThanASecond: UnitString.duo(
          "birkaç saniye",
          "birkaç sn",
        ),
        DurationInterval.aSecond: UnitString.duo(
          "bir saniye",
          "1 sn",
        ),
        DurationInterval.seconds: UnitString.duo(
          "$srDelta saniye",
          "$srDelta sn",
        ),
        DurationInterval.aMinute: UnitString.duo(
          "bir dakika",
          "1 dk",
        ),
        DurationInterval.minutes: UnitString.duo(
          "$srDelta dakika",
          "$srDelta dk",
        ),
        DurationInterval.anHour: UnitString.duo(
          "bir saat",
          "1 sa",
        ),
        DurationInterval.hours: UnitString.duo(
          "$srDelta saat",
          "$srDelta sa",
        ),
        DurationInterval.aDay: UnitString.duo(
          "bir gün",
          "1 gün",
        ),
        DurationInterval.days: UnitString.duo(
          "$srDelta gün",
          "$srDelta gün",
        ),
        DurationInterval.aWeek: UnitString.duo(
          "bir hafta",
          "1 hft",
        ),
        DurationInterval.weeks: UnitString.duo(
          "$srDelta hafta",
          "$srDelta hft",
        ),
        DurationInterval.aMonth: UnitString.duo(
          "bir ay",
          "1 ay",
        ),
        DurationInterval.months: UnitString.duo(
          "$srDelta ay",
          "$srDelta ay",
        ),
        DurationInterval.aYear: UnitString.duo(
          "bir yıl",
          "1 yıl",
        ),
        DurationInterval.years: UnitString.duo(
          "$srDelta yıl",
          "$srDelta yıl",
        ),
      };

  @override
  SimpleRangeData get simpleRangeData => SimpleRangeData(
        thisWeek: "Bu hafta",
        year: (range, {DateTime? anchor, bool useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && range.year == anchor.year) {
            return "Bu yıl";
          }

          return "${range.year} yılı";
        },
        month: (range, {DateTime? anchor, bool useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && anchor.year == range.year) {
            if (anchor.month == range.month) {
              return "Bu ay";
            }

            return monthNames[range.month]!;
          }

          return "${monthNames[range.month]!} ${range.year}";
        },
        allAfter: (formattedDate) => "$formattedDate tarihinden sonra",
        allBefore: (formattedDate) => "$formattedDate tarihinden önce",
        customRangeAllTime: "Tüm zamanlar",
      );

  static const Map<int, String> _ordinalUnitSuffixes = {
    1: "'inci",
    2: "'nci",
    3: "'üncü",
    4: "'üncü",
    5: "'inci",
    7: "'nci",
    6: "'ncı",
    8: "'inci",
    9: "'uncu",
  };

  static const Map<int, String> _ordinalNonUnitSuffixes = {
    10: "'uncu",
    20: "'nci",
    30: "'uncu",
    40: "'ıncı",
    50: "'nci",
    60: "'ıncı",
    70: "'inci",
    80: "'inci",
    90: "'ıncı"
  };
}
