import 'package:moment_dart/src/formatters/token.dart';

class FormatMatch {
  final int startIndex;
  final FormatterToken token;

  int get endIndex => token.name.length + startIndex;

  const FormatMatch({
    required this.startIndex,
    required this.token,
  });

  @override
  String toString() => token.name;
}
