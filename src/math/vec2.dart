class Vec2 extends Coordinate {
  const Vec2([num x = 0, num y = 0]) : super(x,y);

  static Vec2 difference(Coordinate a, Coordinate b){
    return new Vec2(a.x - b.x, a.y - b.y);
  }
  
  Vec2 operator +(Coordinate other){
    return new Vec2(x + other.x, y + other.y);
  }
  
  Vec2 operator -(Coordinate other) { 
      return new Vec2(x - other.x, y - other.y);
  } 
  
  Vec2 operator *(Coordinate other) { 
      return new Vec2(x * other.x, y * other.y);
  } 
  
  Vec2 operator /(Coordinate other) { 
      return new Vec2(x / other.x, y / other.y);
  } 
  
  Vec2 operator %(Coordinate other) { 
      return new Vec2(x % other.x, y % other.y);
  } 
  
  num getDistance (Coordinate other) {
    num distX = other.x - x;
    num distY = other.y - y;
    return Math.sqrt(distX * distX + distY * distY);
  }
  
  num dot(Vec2 other) =>  x * other.x + y * other.y;
  
  num cross(Vec2 other) => x * other.y - y * other.x;
  
  num getAngle (Vec2 other) => Math.acos(dot(other));
  

  String toString() => '{"x":${x},"y":${y}}';
  
}
