part of test_bot;

class TestStrings {

  static void run() {
    group("isNullOrEmpty()", () {
      test("returns true for null", () {
        expect(Strings.isNullOrEmpty(null), true);
      });
      
      test("returns true for empty string", () {
        expect(Strings.isNullOrEmpty(""), true);
      });
      
      test("returns false for non-empty string", () {
        expect(Strings.isNullOrEmpty("not empty"), false);
      });
    });
  }
}