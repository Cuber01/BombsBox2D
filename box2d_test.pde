import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;

ArrayList<Box> boxes;
Spring spring;

void setup()
{
  size(640, 360);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();
  
  boxes = new ArrayList<Box>();
  spring = new Spring();

  Box floor = new Box(300, 340, 489, 16, color(0, 0, 0), BodyType.STATIC);
  boxes.add(floor);
}

void mousePressed()
{
    if(mouseButton == LEFT)
    {
      Box p = new Box(mouseX, mouseY, 16, 16, color(230, 230, 230), BodyType.DYNAMIC);
      boxes.add(p);
    }
    
    if(mouseButton == RIGHT)
    {
      for(Box box : boxes)
      {
        if(box.contains(mouseX, mouseY))
        {
          spring.bind(mouseX,mouseY, box);
        }
      }      
    }
}

void mouseReleased() 
{
    spring.destroy();
}

void beginContact(Contact cp) 
{
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1.getClass() == Box.class && o2.getClass() == Box.class)
  {
    Box bx1 = (Box) o1;
    bx1.changeColor(color(255,0,0));
    Box bx2 = (Box) o2;
    bx2.changeColor(color(255,0,0));
  }

}

// Objects stop touching each other
void endContact(Contact cp) {
}

void draw()
{
    background(255);
    box2d.step();
    
    for(Box box : boxes)
    {
      box.display();
    }
    
    spring.display();
    spring.update(mouseX, mouseY);
}
