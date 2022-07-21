import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

class Bomb
{
  float x;
  float y;
  
  float r;
  
  color col;
  
  Body body;
  
  Bomb(float x, float y, float r, color col)
  {
    this.x = x;
    this.y = y;

    this.col = col;
    
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    
    body = box2d.createBody(bd);
    
    // Use data will be accessed when two bodies collide
    body.setUserData(this);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 2;
    fd.friction = 0;
    fd.restitution = 0;

    body.createFixture(fd);
  }
  
  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }
  
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    
    fill(col);
    stroke(0);
    strokeWeight(1.5);
    
    ellipse(0, 0, r*2, r*2);
    line(0, 0, r, 0);
    popMatrix();
  }
  
  void changeColor(color newColor)
  {
    col = newColor;
  }
}
