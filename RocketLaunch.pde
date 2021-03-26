ArrayList<Rocket> rockets = new ArrayList();
Obstacle[] obstacles = new Obstacle[5];

public void setup() {
  size(300,900);
  spawnObstacles();
  frameRate(240);
}

public void draw() {
  background(220);
  
  for (Obstacle o : obstacles) {
    o.draw();
  }
  //1.2 draw, move, and collide all rockets
  for (Rocket rocket : rockets) {
  if (rocket != null && rocket.active) {
    rocket.move();
    rocket.rocketVsBorder();
    for (Obstacle o : obstacles)
      rocket.rocketVsObstacle(o);
    rocket.draw();
  }
  }
  if (rockets.size() > 0 && allRocketsDestroyed()) {
    Rocket best = bestRocket();
    spawnNextGenRockets(best);
  }
}

public void spawnNextGenRockets(Rocket best) {
  for (int i = 0; i < rockets.size(); i++) {
    rockets.set(i, new Rocket(width/2,height-40, best.brain));
  }
}

public boolean allRocketsDestroyed() {
  //boolean allDestroyed = false;
  for (int i = 0; i < rockets.size(); i++) {
    //is this rocket destroyed?
    if (rockets.get(i).active) {
      return false;
    }    
  }
  return true;
}

public Rocket bestRocket() {
  //create variables with default, wrong answers
  int index = -1;
  int bestHeight = Integer.MIN_VALUE;
  float bestDistance = Float.MAX_VALUE;
  //interate through all rockets
  for (int i = 0; i < rockets.size(); i++ ) {
    System.out.println( rockets.get(i) );
    //check for new best rocket (smaller y)
    //rockets.get(i) .pos.y bestHeight <
    int thisObstacleIndex = rockets.get(i).nextObstacleIndex;
    if (thisObstacleIndex > bestHeight && rockets.get(i).closest < bestDistance) {
      //change answer of best rocket
      index =  i;
      bestHeight = (int) rockets.get(i).pos.y;
    }
  }
  return rockets.get(index);
}

public void mouseReleased() {
    //1.1 spawn 20 rockets when mouse is clicked
    for (int i = 0; i < 1000; i++) {
     Rocket new_rocket = new Rocket(mouseX, mouseY);
     rockets.add(new_rocket);
    }
}

private void spawnObstacles() {
  for (int i = 0; i < obstacles.length; i++) {
    int x = (int) map(random(1),0,1,width * 0.15, width * 0.85);
    //2.1 obstacles are evenly spaced vertically
    int y = (int) map(i,0,obstacles.length,700,0);
    obstacles[i] = new Obstacle(x, y);
  }
}
