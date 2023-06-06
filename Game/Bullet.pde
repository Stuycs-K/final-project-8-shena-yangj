class Bullet {
  PVector bullet;
  //PVector position;
  PVector velocity;
  float speedFactor;
  Mob mob;
  Tower tower;
  Bullet(Tower tower, Mob mob) {
    speedFactor = .5;
    bullet = new PVector(tower.getLocation().getX(),tower.getLocation().getY());
    this.mob = mob;
    this.tower = tower;
  }
  void move() {
    PVector vector = new PVector(tower.getLocation().getX()-mob.getLocation().getX(),tower.getLocation().getY()-mob.getLocation().getY());
    //scale Pvector
    //vector.normalize();
    //vector.mult(speedFactor);
    //bullet.x+=vector.x;
    //bullet.y=vector.y;
    bullet.x+=speedFactor;
    bullet.y+=speedFactor;
    
  }
  void display() {
    if (!hitMob()) {
      fill(255,0,0);
      rect(bullet.x,bullet.y,15,15);
    }
    println("x: "+bullet.x+" y: "+bullet.y);
    
  }
  boolean hitMob() {
    return (mob.getLocation().getX()==bullet.x-mob.getRadius() && mob.getLocation().getY()==bullet.y-mob.getRadius());
  }
  PVector getBulletVector() {
    return bullet;
  }
}
