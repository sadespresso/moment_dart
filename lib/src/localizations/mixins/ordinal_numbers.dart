import 'package:moment_dart/moment_dart.dart';

/// This mixin provides:
///
/// * [formattersWithOrdinal] - getter for set of formatters related to ordinals
mixin Ordinal on MomentLocalization {
  String ordinalNumber(int n);

  /// Overrides:
  ///
  /// `Mo`, `Qo`, `Do`, `DDDo`, `d_o`, and `wo`
  Map<FormatterToken, FormatterTokenFn> get formattersWithOrdinal => {
        FormatterToken.Mo: (DateTime dateTime) => ordinalNumber(dateTime.month),
        FormatterToken.Qo: (DateTime dateTime) =>
            ordinalNumber(dateTime.quarter),
        FormatterToken.Do: (DateTime dateTime) => ordinalNumber(dateTime.day),
        FormatterToken.DDDo: (DateTime dateTime) =>
            ordinalNumber(dateTime.dayOfYear),
        FormatterToken.d_o: (DateTime dateTime) =>
            ordinalNumber(dateTime.weekday),
        FormatterToken.wo: (DateTime dateTime) => ordinalNumber(dateTime.week)
      };
}
