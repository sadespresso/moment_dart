import 'package:moment_dart/moment_dart.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('Test if global localization is changing', () {
    expect(Moment.now().localization.locale, "en_US");
    Moment.setGlobalLocalization(MomentLocalizations.fr());
    expect(Moment.now().localization.locale, "fr_FR");
  });
}
