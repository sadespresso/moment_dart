import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  test("Mongolain Number word gender test", () {
    // Powers of 10
    expect(LocalizationMongolianTraditional.isFeminine(1), true);
    expect(LocalizationMongolianTraditional.isFeminine(10), false);
    expect(LocalizationMongolianTraditional.isFeminine(100), false);
    expect(LocalizationMongolianTraditional.isFeminine(1000), false);
    expect(LocalizationMongolianTraditional.isFeminine(10000), false);

    // Units
    expect(LocalizationMongolianTraditional.isFeminine(2), false);
    expect(LocalizationMongolianTraditional.isFeminine(3), false);
    expect(LocalizationMongolianTraditional.isFeminine(4), true);
    expect(LocalizationMongolianTraditional.isFeminine(5), false);
    expect(LocalizationMongolianTraditional.isFeminine(6), false);
    expect(LocalizationMongolianTraditional.isFeminine(7), false);
    expect(LocalizationMongolianTraditional.isFeminine(8), false);
    expect(LocalizationMongolianTraditional.isFeminine(9), true);
    expect(LocalizationMongolianTraditional.isFeminine(10), false);
    expect(LocalizationMongolianTraditional.isFeminine(123452), false);
    expect(LocalizationMongolianTraditional.isFeminine(123453), false);
    expect(LocalizationMongolianTraditional.isFeminine(123454), true);
    expect(LocalizationMongolianTraditional.isFeminine(123455), false);
    expect(LocalizationMongolianTraditional.isFeminine(123456), false);
    expect(LocalizationMongolianTraditional.isFeminine(123457), false);
    expect(LocalizationMongolianTraditional.isFeminine(123458), false);
    expect(LocalizationMongolianTraditional.isFeminine(123459), true);
    expect(LocalizationMongolianTraditional.isFeminine(1234510), false);

    // Tens
    expect(LocalizationMongolianTraditional.isFeminine(123410), false);
    expect(LocalizationMongolianTraditional.isFeminine(123420), false);
    expect(LocalizationMongolianTraditional.isFeminine(123430), false);
    expect(LocalizationMongolianTraditional.isFeminine(123440), true);
    expect(LocalizationMongolianTraditional.isFeminine(123450), false);
    expect(LocalizationMongolianTraditional.isFeminine(123460), false);
    expect(LocalizationMongolianTraditional.isFeminine(123470), false);
    expect(LocalizationMongolianTraditional.isFeminine(123480), false);
    expect(LocalizationMongolianTraditional.isFeminine(123490), true);
  });
}
