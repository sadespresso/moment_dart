import 'package:moment_dart/moment_dart.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('Test if global localization is changing', () {
    expect(Moment.now().localization.locale, "en_US");
    Moment.setGlobalLocalization(MomentLocalizations.fr());
    expect(Moment.now().localization.locale, "fr_FR");
    Moment.setGlobalLocalization(MomentLocalizations.jaJp());
    expect(Moment.now().localization.locale, "ja_JP");
    Moment.setGlobalLocalization(MomentLocalizations.ar());
    expect(Moment.now().localization.locale, "ar");
  });
}
