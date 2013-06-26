part of test_bot;

class TestObjects {

  static void run() {
    group("Objects", () {
      group("firstNonNull()", () {
        test("returns first argument when first is not null and second is null", () {
          expect(Objects.firstNonNull("first", null), "first");
        });
        
        test("returns first argument when first is not null and second is not null", () {
          expect(Objects.firstNonNull("first", "second"), "first");
        });
    
        test("returns second argument when first is null and second is not null", () {
          expect(Objects.firstNonNull(null, "second"), "second");
        });
        
        test("throws error when both arguments are null", () {
          expect(() => Objects.firstNonNull(null, null), throwsArgumentError);
        });
      });
    });
  }
}