public class Rocket extends Entity {
  //fields
  public PVector vel, force;
  public boolean active = true;
  public Brain brain;

  //constructor
  public Rocket(int x, int y) {
    super(#0000FF, 10, 30, x, y);
    float angle = random(PI * 1.3, PI * 1.7);
    vel = new PVector(0,0);//PVector.fromAngle(angle);
    force = new PVector(0,0);//PVector.fromAngle(angle);
    brain = new Brain(this);
  }

  public void move() {
    force = brain.pickDirection(obstacles[0]);
    
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
    if (this.getCollisionBox().intersects(o.getCollisionBoxes()[0])
      || this.getCollisionBox().intersects(o.getCollisionBoxes()[1])) {
      this.active = false;
    }
  }
}
