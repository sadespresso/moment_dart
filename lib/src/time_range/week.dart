import 'package:moment_dart/src/extensions.dart';
import 'package:moment_dart/src/time_range/custom.dart';
import 'package:moment_dart/src/time_range/pageable_range.dart';

class LocalWeekTimeRange extends CustomTimeRange
    implements PageableRange<LocalWeekTimeRange> {
  LocalWeekTimeRange(DateTime dateTime)
      : super(dateTime.startOfLocalWeek(), dateTime.endOfLocalWeek());

  @override
  CustomTimeRange toUtc() => throw UnsupportedError(
      "Local week time range cannot be converted to UTC");

  @override
  LocalWeekTimeRange get next => throw UnimplementedError();

  @override
  LocalWeekTimeRange get last => throw UnimplementedError();
}

class IsoWeekTimeRange extends CustomTimeRange
    with PageableRange<IsoWeekTimeRange> {
  IsoWeekTimeRange(DateTime dateTime)
      : super(dateTime.startOfLocalWeek(1), dateTime.endOfLocalWeek(1));

  int get weekYear => from.weekYear;
  int get week => from.week;

  @override
  CustomTimeRange toUtc() =>
      throw UnsupportedError("ISO week time range cannot be converted to UTC");

  @override
  IsoWeekTimeRange get next => IsoWeekTimeRange(from.nextMonday());

  @override
  IsoWeekTimeRange get last => IsoWeekTimeRange(from.lastMonday());
}
