Rocket rocket;
Obstacle[] obstacles = new Obstacle[10];

public void setup() {
  size(300,900);
  spawnObstacles();
}

public void draw() {
  background(220);
  
  for (Obstacle o : obstacles) {
    o.draw();
  }
  
  if (rocket != null && rocket.active) {
    rocket.move();
    for (Obstacle o : obstacles)
      rocket.rocketVsObstacle(o);
    rocket.draw();
  }
}

public void mouseReleased() {
   rocket = new Rocket(mouseX, mouseY);
}

private void spawnObstacles() {
  for (int i = 0; i < obstacles.length; i++) {
    int x = (int) random(width);
    int y = (int) random(height * 0.7);
    obstacles[i] = new Obstacle(x, y);
  }
}
