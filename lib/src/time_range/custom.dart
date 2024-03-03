import 'package:moment_dart/src/extensions.dart';
import 'package:moment_dart/src/time_range.dart';

class CustomTimeRange extends TimeRange {
  @override

  /// Returns if [from] is in UTC timezone.
  ///
  /// Does NOT check it [to] is in UTC timezone.
  bool get isUtc => from.isUtc;

  @override
  final DateTime from;
  @override
  final DateTime to;

  /// The timezone is assumed by the [from] passed in here.
  ///
  /// [CustomTimeRange] does NOT ensure that [from] and [to] have the same timezone.
  const CustomTimeRange(this.from, this.to)
      : assert(from <= to, "[from] must be before or equal to [to]");

  @override
  CustomTimeRange toUtc() =>
      isUtc ? this : CustomTimeRange(from.toUtc(), to.toUtc());
}
