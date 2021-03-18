public class Rocket extends Entity {
  //fields
  public PVector vel, force;
  public boolean active = true;
  public Brain brain;
  public Obstacle nextObstacle;
  public int nextObstacleIndex = 0;

  //constructor
  public Rocket(int x, int y) {
    super(#0000FF, 10, 30, x, y);
    float angle = random(PI * 1.3, PI * 1.7);
    vel = PVector.fromAngle(angle);
    force = PVector.fromAngle(angle).mult(0.1);
    brain = new Brain(this);
    nextObstacle = obstacles[0];
  }

  public void move() {
    didPassObstacle();
    
    force = brain.pickDirection(nextObstacle);
    
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
  
  private void didPassObstacle() {
    if (this.getCollisionBox().intersects(nextObstacle.getCollisionBox())) {
      nextObstacleIndex++;
      nextObstacle = obstacles[nextObstacleIndex];
    }
  }

  private void rocketVsObstacle(Obstacle o) {
    if (this.getCollisionBox().intersects(o.getCollisionBoxes()[0])
      || this.getCollisionBox().intersects(o.getCollisionBoxes()[1])) {
      this.active = false;
    }
  }
}
