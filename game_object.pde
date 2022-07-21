class PhysicsObject
{
  float x;
  float y;
  
  Body body;
  
  void makeBody(float x, float y, BodyType type)
  {
    BodyDef bd = new BodyDef();
    bd.type = type;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    
    body = box2d.createBody(bd);
    
    // Use data will be accessed when two bodies collide
    body.setUserData(this);
  }
  
  FixtureDef makeFixture(Shape s, float density, float friction, float restituion)
  {
    FixtureDef fd = new FixtureDef();
    fd.shape = s;
    fd.density = density;
    fd.friction = friction;
    fd.restitution = restituion;
    
    return fd;
  }
}
