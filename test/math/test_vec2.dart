class TestVec2 {
  static void run(){
    group('Vec2 -- ', (){
      test('should be sum with other Vec2', (){
        Vec2 v = new Vec2(1,1) + new Vec2(2,1);
        Expect.equals(3, v.x);
        Expect.equals(2, v.y);
      });
      
      test('should be subtract by other Vec2', (){
        Vec2 v = new Vec2(5,3) - new Vec2(2,1);
        Expect.equals(3, v.x);
        Expect.equals(2, v.y);
      });
      
      test('should be multiply by other Vec2', (){
        Vec2 v = new Vec2(2,3) * new Vec2(2,3);
        Expect.equals(4, v.x);
        Expect.equals(9, v.y);
      });
      
      test('should be divided by other Vec2', (){
        Vec2 v = new Vec2(4,8) / new Vec2(2,4);
        Expect.equals(2, v.x);
        Expect.equals(2, v.y);
      });
      
      test('should be compared by other Vec2', (){
        Expect.isTrue(new Vec2(2,2) == new Vec2(2,2));
        Expect.isTrue(new Vec2(2,1) != new Vec2(2,2));
      });
      
      test('should get the distance to another point', (){
        Expect.equals(5, new Vec2(0, 0).getDistance(new Vec2(3, 4)));
      });
      
      test('should get length of the vector', (){
        Expect.equals(5, new Vec2(3, 4).length());
      });
      
      test('should calc the dot product', (){
        Expect.equals(23, new Vec2(2, 3).dot(new Vec2(4, 5)));
      });
      
      test('should calc the cross product', (){
        Expect.equals(-2, new Vec2(2, 3).cross(new Vec2(4, 5)));
      });
      
      test('should create a copy of itself', (){
        Vec2 original = new Vec2(1,2);
        Vec2 copy = original.copy();
        Expect.equals(copy.x, original.x);
        Expect.equals(copy.y, original.y);
      });
    });
  }
}
