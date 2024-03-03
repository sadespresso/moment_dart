import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/time_range.dart';

mixin PageableRange<T extends TimeRange> on TimeRange {
  T get next;
  T get last;
}
