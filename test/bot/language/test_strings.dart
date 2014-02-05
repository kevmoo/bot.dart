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
      
      group("replaceLast()", () {
        var alphabet = "abcdefghijklmnopqrstuvwxyz";
        test("handles no matches", () {
          expect(Strings.replaceLast(alphabet,"123", "123"), equals(alphabet));
        });
        test("handles last match at start of string", () {
          expect(Strings.replaceLast(alphabet, "abc", "123"), equals("123defghijklmnopqrstuvwxyz"));
        });
        test("handles last match in middle of string", () {
          expect(Strings.replaceLast(alphabet, "mno", "123"), equals("abcdefghijkl123pqrstuvwxyz"));
        });
        test("handles last match at end of string", () {
          expect(Strings.replaceLast(alphabet, "xyz", "123"), equals("abcdefghijklmnopqrstuvw123"));
        });
        test("handles repeated characters", () {
          expect(Strings.replaceLast("aaaaaaaaa", "aaa", "bbb"), equals("aaaaaabbb"));
        });
        test("handles null source string", () {
          expect(() => Strings.replaceLast(null, "abc", "123"), throwsArgumentError);
        });
        test("handles empty source string", () {
          expect(Strings.replaceLast("", "abc", "123"), equals(""));
        });
        test("handles null from pattern", () {
          expect(() => Strings.replaceLast(null, "abc", "123"), throwsArgumentError);
        });
        test("handles empty from pattern", () {
          expect(Strings.replaceLast(alphabet, "", "123"), equals("abcdefghijklmnopqrstuvwxyz123"));
        });
        test("handles null to string", () {
          expect(() => Strings.replaceLast(null, "abc", "123"), throwsArgumentError);
        });
        test("handles empty to string", () {
          expect(Strings.replaceLast(alphabet, "uvw", ""), equals("abcdefghijklmnopqrstxyz"));
        });
        test("handles patterns properly", () {
          expect(Strings.replaceLast("Hello World!", new RegExp(r"(\w+!)"), "BoT!"), equals("Hello BoT!"));
        });
      });
    });
  }
}