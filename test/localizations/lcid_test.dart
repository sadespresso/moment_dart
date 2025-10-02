import 'package:moment_dart/moment_dart.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test("Locale ids for each localization", () {
    expect(LocalizationArPs().locale, "ar_PS");
    expect(LocalizationMnMn().locale, "mn_MN");
    expect(LocalizationMnMongMn().locale, "mn_Mong_MN");
    expect(LocalizationMnQaaqMn().locale, "mn_Qaaq_MN");
    expect(LocalizationKoKr().locale, "ko_KR");
    expect(LocalizationJaJp().locale, "ja_JP");
    expect(LocalizationDeDe().locale, "de_DE");
    expect(LocalizationEsEs().locale, "es_ES");
    expect(LocalizationFrFr().locale, "fr_FR");
    expect(LocalizationTrTr().locale, "tr_TR");
    expect(LocalizationPtPt().locale, "pt_PT");
    expect(LocalizationItIt().locale, "it_IT");
    expect(LocalizationZhCn().locale, "zh_CN");
    expect(LocalizationRuRu().locale, "ru_RU");
  });
}
