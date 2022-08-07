import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  test("Mongolain Number word gender test", () {
    // Powers of 10
    expect(LocalizationMnMongMn.isFeminine(1), true);
    expect(LocalizationMnMongMn.isFeminine(10), false);
    expect(LocalizationMnMongMn.isFeminine(100), false);
    expect(LocalizationMnMongMn.isFeminine(1000), false);
    expect(LocalizationMnMongMn.isFeminine(10000), false);

    // Units
    expect(LocalizationMnMongMn.isFeminine(2), false);
    expect(LocalizationMnMongMn.isFeminine(3), false);
    expect(LocalizationMnMongMn.isFeminine(4), true);
    expect(LocalizationMnMongMn.isFeminine(5), false);
    expect(LocalizationMnMongMn.isFeminine(6), false);
    expect(LocalizationMnMongMn.isFeminine(7), false);
    expect(LocalizationMnMongMn.isFeminine(8), false);
    expect(LocalizationMnMongMn.isFeminine(9), true);
    expect(LocalizationMnMongMn.isFeminine(10), false);
    expect(LocalizationMnMongMn.isFeminine(123452), false);
    expect(LocalizationMnMongMn.isFeminine(123453), false);
    expect(LocalizationMnMongMn.isFeminine(123454), true);
    expect(LocalizationMnMongMn.isFeminine(123455), false);
    expect(LocalizationMnMongMn.isFeminine(123456), false);
    expect(LocalizationMnMongMn.isFeminine(123457), false);
    expect(LocalizationMnMongMn.isFeminine(123458), false);
    expect(LocalizationMnMongMn.isFeminine(123459), true);
    expect(LocalizationMnMongMn.isFeminine(1234510), false);

    // Tens
    expect(LocalizationMnMongMn.isFeminine(123410), false);
    expect(LocalizationMnMongMn.isFeminine(123420), false);
    expect(LocalizationMnMongMn.isFeminine(123430), false);
    expect(LocalizationMnMongMn.isFeminine(123440), true);
    expect(LocalizationMnMongMn.isFeminine(123450), false);
    expect(LocalizationMnMongMn.isFeminine(123460), false);
    expect(LocalizationMnMongMn.isFeminine(123470), false);
    expect(LocalizationMnMongMn.isFeminine(123480), false);
    expect(LocalizationMnMongMn.isFeminine(123490), true);
  });
}
