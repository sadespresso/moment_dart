import 'package:moment_dart/src/localizations.dart';
import 'package:moment_dart/src/localizations/mn_MN.dart';
import 'package:moment_dart/src/moment.dart';
import 'package:test/test.dart';

void main() {
  Localization localizationMongolianCyrillic = LocalizationMongolianCyrillic();
  final moment = Moment.now(localization: localizationMongolianCyrillic) - Duration(days: 1);

  test('First Test', () {
    expect(moment.lastMonday().weekday, 1);
    expect(localizationMongolianCyrillic.relative(const Duration(seconds: 2)), "хэдэн хоромын дараа");
    expect(localizationMongolianCyrillic.weekdayName(1), "Даваа");
  });
}
