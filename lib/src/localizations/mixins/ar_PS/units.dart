import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';

/// Unit string that follows the Arabic (CLDR) plural categories.
///
/// The dual has two cases: nominative when it stands alone ("دقيقتان") and
/// genitive after "منذ"/"بعد" ("منذ دقيقتين").
class ArabicUnitString extends UnitString {
  final String one;
  final String twoNominative;
  final String twoGenitive;

  /// n % 100 in 3..10
  final String few;

  /// n % 100 in 11..99
  final String many;

  /// 0, and n % 100 in 0..2 for n >= 100
  final String other;

  const ArabicUnitString({
    required this.one,
    required this.twoNominative,
    required this.twoGenitive,
    required this.few,
    required this.many,
    required this.other,
  });

  const ArabicUnitString.single(String value)
      : one = value,
        twoNominative = value,
        twoGenitive = value,
        few = value,
        many = value,
        other = value;

  @override
  String get(Abbreviation form, bool dropPrefixOrSuffix, [int count = 1]) {
    final int mod = count % 100;

    if (count == 1) return one;
    if (count == 2) return dropPrefixOrSuffix ? twoNominative : twoGenitive;
    if (mod >= 3 && mod <= 10) return few;
    if (mod >= 11) return many;
    return other;
  }
}

mixin ArPsUnits on SimpleUnits {
  @override
  Map<DurationInterval, ArabicUnitString> get units {
    final ArabicUnitString seconds = ArabicUnitString(
      one: "ثانية",
      twoNominative: "ثانيتان",
      twoGenitive: "ثانيتين",
      few: "$srDelta ثوانٍ",
      many: "$srDelta ثانية",
      other: "$srDelta ثانية",
    );
    final ArabicUnitString minutes = ArabicUnitString(
      one: "دقيقة",
      twoNominative: "دقيقتان",
      twoGenitive: "دقيقتين",
      few: "$srDelta دقائق",
      many: "$srDelta دقيقة",
      other: "$srDelta دقيقة",
    );
    final ArabicUnitString hours = ArabicUnitString(
      one: "ساعة",
      twoNominative: "ساعتان",
      twoGenitive: "ساعتين",
      few: "$srDelta ساعات",
      many: "$srDelta ساعة",
      other: "$srDelta ساعة",
    );
    final ArabicUnitString days = ArabicUnitString(
      one: "يوم",
      twoNominative: "يومان",
      twoGenitive: "يومين",
      few: "$srDelta أيام",
      many: "$srDelta يومًا",
      other: "$srDelta يوم",
    );
    final ArabicUnitString weeks = ArabicUnitString(
      one: "أسبوع",
      twoNominative: "أسبوعان",
      twoGenitive: "أسبوعين",
      few: "$srDelta أسابيع",
      many: "$srDelta أسبوعًا",
      other: "$srDelta أسبوع",
    );
    final ArabicUnitString months = ArabicUnitString(
      one: "شهر",
      twoNominative: "شهران",
      twoGenitive: "شهرين",
      few: "$srDelta أشهر",
      many: "$srDelta شهرًا",
      other: "$srDelta شهر",
    );
    final ArabicUnitString years = ArabicUnitString(
      one: "عام",
      twoNominative: "عامان",
      twoGenitive: "عامين",
      few: "$srDelta أعوام",
      many: "$srDelta عامًا",
      other: "$srDelta عام",
    );

    return {
      DurationInterval.lessThanASecond:
          const ArabicUnitString.single("بضع ثوانٍ"),
      DurationInterval.aSecond: seconds,
      DurationInterval.seconds: seconds,
      DurationInterval.aMinute: minutes,
      DurationInterval.minutes: minutes,
      DurationInterval.anHour: hours,
      DurationInterval.hours: hours,
      DurationInterval.aDay: days,
      DurationInterval.days: days,
      DurationInterval.aWeek: weeks,
      DurationInterval.weeks: weeks,
      DurationInterval.aMonth: months,
      DurationInterval.months: months,
      DurationInterval.aYear: years,
      DurationInterval.years: years,
    };
  }
}
