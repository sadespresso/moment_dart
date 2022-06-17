// ignore_for_file: file_names

import 'package:moment_dart/src/formatters/token.dart';
import 'package:moment_dart/src/localizations/mn_TM.dart';

/// Language: Traditional Mongolian (Unicode), uses Traditional Numbers
/// Country: Mongolia
class LocalizationMongolianTraditionalNumbers
    extends LocalizationMongolianTraditional {
  LocalizationMongolianTraditionalNumbers() : super();

  static const Map<String, String> mongolianNumbers = {
    "0": "᠐",
    "1": "᠑",
    "2": "᠒",
    "3": "᠓",
    "4": "᠔",
    "5": "᠕",
    "6": "᠖",
    "7": "᠗",
    "8": "᠘",
    "9": "᠙",
  };

  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) {
    return toTraditionalNumber(super.relative(duration, dropPrefixOrSuffix));
  }

  String toTraditionalNumber(String input) {
    mongolianNumbers.forEach((key, value) {
      input = input.replaceAll(key, value);
    });

    return input;
  }

  @override
  String orderedNumber(int i) => toTraditionalNumber(super.orderedNumber(i));

  @override
  Map<FormatterToken, FormatterTokenFn?> formats() => super.formats().map(
        (key, value) => MapEntry(
          key,
          value == null
              ? null
              : (DateTime dateTime) => toTraditionalNumber(
                    value(dateTime),
                  ),
        ),
      );
}
