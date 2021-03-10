public class Rocket extends Entity {
  //fields
  public PVector vel, force;
  public boolean active = true;

  //constructor
  public Rocket(int x, int y) {
    super(#0000FF, 10, 30, x, y);
    float angle = random(PI * 1.3, PI * 1.7);
    vel = PVector.fromAngle(angle);
    force = PVector.fromAngle(angle);
  }

  public void move() {
    this.pos.add(vel);
    this.vel.add(force);
  }

  private void rocketVsBorder() {
    if (this.pos.x > width
      || this.pos.x < 0
      || this.pos.y > height)
    {
      this.active = false;
    }
  }
  
  private void rocketVsObstacle(Obstacle o) {
    if (this.getCollisionBox().intersects(o.getCollisionBox())) {
      this.active = false;
    }
  }
}
