import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

class Box extends DrawableObject
{
  float w;
  float h; 
  
  Box(float x, float y, float w, float h, 
      color col, BodyType type)
  {
    this.x = x;
    this.y = y;

    this.w = w;
    this.h = h;
    
    this.col = col;
    
    makeBody(x, y, type);
    FixtureDef fd = makeFixture((Shape)makeBoxShape(), 2, 0.3, 0.5);
    body.createFixture(fd);
  }
  
  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }
  
  PolygonShape makeBoxShape()
  {
    PolygonShape ps = new PolygonShape();
    float box2Dw = box2d.scalarPixelsToWorld(w/2);
    float box2Dh = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2Dw, box2Dh);
    
    return ps;
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
    
    rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();
  }
  
  void changeColor(color newColor)
  {
    col = newColor;
  }
}
