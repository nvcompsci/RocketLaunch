import java.awt.Rectangle;

public class Entity {
  public color c;
  public int w, h;
  public PVector pos;
  
  public Entity(color c, int w, int h, int x, int y) {
    this.c = c;
    this.w = w;
    this.h = h;
    this.pos = new PVector(x,y);
  }
  
  public void draw() {
    fill(c);
    rect(pos.x, pos.y, w, h);
  }
  
  public Rectangle getCollisionBox() {
    return new Rectangle((int)pos.x, (int)pos.y, w, h);
  }
}
