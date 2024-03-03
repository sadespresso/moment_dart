import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/time_range.dart';

mixin PageableRange<T extends TimeRange> on TimeRange {
  /// Returns a new instance, preserves the timezone
  T get next;

  /// Returns a new instance, preserves the timezone
  T get last;
}
