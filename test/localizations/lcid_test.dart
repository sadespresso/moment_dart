import 'package:moment_dart/moment_dart.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test("Locale ids for each localization", () {
    expect(LocalizationMnMn().locale, "mn_MN");
    expect(LocalizationMnMongMn().locale, "mn_Mong_MN");
    expect(LocalizationMnQaaqMn().locale, "mn_Qaaq_MN");
    expect(LocalizationKo().locale, "ko_KR");
    expect(LocalizationDeDe().locale, "de_DE");
    expect(LocalizationEsEs().locale, "es_ES");
    expect(LocalizationFrFr().locale, "fr_FR");
    expect(LocalizationItIt().locale, "it_IT");
    expect(LocalizationZhCn().locale, "zh_CN");
  });
}
