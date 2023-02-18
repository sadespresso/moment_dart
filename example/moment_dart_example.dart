import "package:moment_dart/moment_dart.dart";

void main() {
  final MomentLocalization localization = MomentLocalizations.enUS();

  /// If localization is omitted, it defaults to English (United States)
  final Moment moment =
      Moment.now(localization: localization) - Duration(days: 1);
  final Moment epoch =
      Moment(DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true));
  final Moment epochPlusFiveDays = epoch + Duration(days: 5);
  final Moment epochPlusAYear = epoch + Duration(days: 365);

  localization.relative(const Duration(seconds: 2)); // "in a few seconds"
  epochPlusFiveDays.from(epoch, dropPrefixOrSuffix: true); // "5 days"
  epochPlusFiveDays.from(epoch); // "in 5 days"
  epoch.calendar(
      reference: epochPlusFiveDays, omitHours: true); // "Last Thursday"
  epochPlusFiveDays.calendar(reference: epoch, omitHours: true); // "Tuesday"
  epochPlusAYear.from(epoch); //"in a year"
  epochPlusAYear.calendar(reference: epoch); // "01/01/1971 at 12:00AM"

  /// Returns relative string, such as `Yesterday`, `Last Sunday`, or default date format concatenated with default hour format.
  ///
  /// You can omit the hours using [omitHours] argument.
  ///
  /// [reference] is `Moment.now()` by default.
  moment.calendar();

  /// Equivalent to `moment.from(Moment.now())`
  ///
  /// Example when using [LocalizationEnUs]:
  ///
  /// If [this] is yesterday, will result `"a day ago"`
  ///
  /// If [this] is tomorrow, will result `"in a day"`
  moment.fromNow();

  /// Unmatched strings will be left as is.
  moment.format("YYYY년 MMMM Do dddd A hh:mm");

  /// String encapsulated in square brackets will be escaped.
  moment.format("[YEAR:] YYYY, [MONTH:] MMMM, Do dddd A hh:mm");

  print(Moment(DateTime(1971, 2, 14), localization: LocalizationEnUs())
      .format("[YEAR:] YYYY, [MONTH:] MMMM, Do dddd A hh:mm"));
}
