part of test_bot;

class TestStrings {

  static void run() {
    group("Strings", () {
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
      
      group("nonNullOrEmpty()", (){
        test("returns input string when it is not null", () {
          expect(Strings.nonNullOrEmpty("not null"), equals("not null"));
        });
        test("returns empty string when input string is null", () {
          expect(Strings.nonNullOrEmpty(null), equals(""));
        });
      });
      
      group("nonEmptyOrNull()", () {
        test("returns input string when it is not empty", () {
          expect(Strings.nonEmptyOrNull("not null"), equals("not null"));
        });
        test("returns null when input string is empty", () {
          expect(Strings.nonEmptyOrNull(""), isNull);
        });
      });
    });
  }
}