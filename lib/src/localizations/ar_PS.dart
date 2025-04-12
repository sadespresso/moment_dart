// ignore_for_file: file_names
// Author: Ultrate (https://github.com/Ultrate)

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_range.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/localizations/mixins/weekday_shortforms.dart';
import 'package:moment_dart/src/types.dart';

/// Language: Arabic
/// Country: Palestine
class LocalizationArPs extends MomentLocalization
    with
        MonthNames,
        SimpleUnits,
        SimpleRelative,
        SimpleDuration,
        SimpleRange,
        WeekdayShortForms {
  static LocalizationArPs? _instance;

  LocalizationArPs._internal() : super();

  factory LocalizationArPs() {
    _instance ??= LocalizationArPs._internal();
    return _instance!;
  }

  @override
  String get endonym => "العربية";

  @override
  String get languageCode => "ar";

  @override
  String get countryCode => "PS";

  @override
  String get languageNameInEnglish => "Arabic";

  @override
  String relativePast(String unit) => "منذ $unit";
  @override
  String relativeFuture(String unit) => "خلال $unit";

  @override
  Map<int, String> get monthNames => {
        1: "يناير",
        2: "فبراير",
        3: "مارس",
        4: "أبريل",
        5: "ماي",
        6: "يونيو",
        7: "يوليوز",
        8: "غشت",
        9: "شتنبر",
        10: "أكتوبر",
        11: "نونبر",
        12: "دجنبر",
      };

  @override
  Map<int, String> get monthNamesShort => {
        1: "ينا",
        2: "فبر",
        3: "مار",
        4: "أبر",
        5: "ماي",
        6: "يون",
        7: "يول",
        8: "غشت",
        9: "شتن",
        10: "أكت",
        11: "نون",
        12: "دجن",
      };

  @override
  Map<int, String> get weekdayName => {
        DateTime.monday: "الاثنين",
        DateTime.tuesday: "الثلاثاء",
        DateTime.wednesday: "الأربعاء",
        DateTime.thursday: "الخميس",
        DateTime.friday: "الجمعة",
        DateTime.saturday: "السبت",
        DateTime.sunday: "الأحد",
      };

  @override
  Map<int, String> get weekdayNameShort => {
        DateTime.monday: "إثن",
        DateTime.tuesday: "ثلا",
        DateTime.wednesday: "أرب",
        DateTime.thursday: "خمي",
        DateTime.friday: "جمعة",
        DateTime.saturday: "سبت",
        DateTime.sunday: "أحد",
      };

  @override
  FormatSetOptional overrideFormatters() {
    String getShortMonth(DateTime dt) => monthNamesShort[dt.month]!;
    String getShortWeekday(DateTime dt) => weekdayNameShort[dt.weekday]!;

    return {
      ...formattersForMonthNames,
      ...formattersForWeekdayShortForms,
      FormatterToken.L: (dateTime) => reformat(dateTime, "DD/MM/YYYY"),
      FormatterToken.l: (dateTime) => reformat(dateTime, "D/M/YYYY"),
      FormatterToken.LL: (dateTime) => reformat(dateTime, "D MMMM YYYY"),
      FormatterToken.ll: (dateTime) =>
          "${dateTime.day} ${getShortMonth(dateTime)} ${dateTime.year}",
      FormatterToken.LLL: (dateTime) => reformat(dateTime, "D MMMM YYYY HH:mm"),
      FormatterToken.lll: (dateTime) =>
          "${dateTime.day} ${getShortMonth(dateTime)} ${dateTime.year} ${reformat(dateTime, 'HH:mm')}",
      FormatterToken.LLLL: (dateTime) =>
          "${weekdayName[dateTime.weekday]}، ${reformat(dateTime, 'D MMMM YYYY HH:mm')}",
      FormatterToken.llll: (dateTime) =>
          "${getShortWeekday(dateTime)}، ${dateTime.day} ${getShortMonth(dateTime)} ${dateTime.year} ${reformat(dateTime, 'HH:mm')}",
      FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
    };
  }

  @override
  CalenderLocalizationData get calendarData => _calendarLocalizationDataAr;

  static String _lastWeekdayGenderAware(String weekday) {
    if (weekday.endsWith('ة')) {
      return "$weekday الماضية";
    }
    return "$weekday الماضي";
  }

  static String _at(String date, String time) => "$date الساعة $time";

  static final CalenderLocalizationData _calendarLocalizationDataAr =
      CalenderLocalizationData(
    relativeDayNames: {
      -1: "أمس",
      0: "اليوم",
      1: "غداً",
    },
    keywords: CalenderLocalizationKeywords(
      at: _at,
      lastWeekday: _lastWeekdayGenderAware,
    ),
  );

  @override
  int get weekStart => DateTime.saturday;

  @override
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.lessThanASecond: UnitString.single("بضع ثوانٍ"),
        DurationInterval.aSecond: UnitString.single("ثانية"),
        DurationInterval.seconds: UnitString.single("$srDelta ثوانٍ"),
        DurationInterval.aMinute: UnitString.single("دقيقة"),
        DurationInterval.minutes: UnitString.single("$srDelta دقائق"),
        DurationInterval.anHour: UnitString.single("ساعة"),
        DurationInterval.hours: UnitString.single("$srDelta ساعات"),
        DurationInterval.aDay: UnitString.single("يوم"),
        DurationInterval.days: UnitString.single("$srDelta أيام"),
        DurationInterval.aWeek: UnitString.single("أسبوع"),
        DurationInterval.weeks: UnitString.single("$srDelta أسابيع"),
        DurationInterval.aMonth: UnitString.single("شهر"),
        DurationInterval.months: UnitString.single("$srDelta أشهر"),
        DurationInterval.aYear: UnitString.single("عام"),
        DurationInterval.years: UnitString.single("$srDelta أعوام"),
      };

  @override
  SimpleRangeData get simpleRangeData => SimpleRangeData(
        thisWeek: "هذا الأسبوع",
        year: (range, {DateTime? anchor, bool useRelative = true}) {
          anchor ??= Moment.now();
          if (useRelative && range.year == anchor.year) {
            return "هذا العام";
          }
          return "عام ${range.year}";
        },
        month: (range, {DateTime? anchor, bool useRelative = true}) {
          anchor ??= Moment.now();
          if (useRelative && anchor.year == range.year) {
            if (anchor.month == range.month) {
              return "هذا الشهر";
            }
            return monthNames[range.month]!;
          }
          return "${monthNames[range.month]!} ${range.year}";
        },
        allAfter: (formattedDate) => "بعد $formattedDate",
        allBefore: (formattedDate) => "قبل $formattedDate",
        customRangeAllTime: "كل الوقت",
      );
}
