public class Laser{
  Tower tower;
  public Laser(Tower tower) {
    this.tower = tower;
  }
  void display(Mob mob) {
    stroke(255,0,0);
    strokeWeight(7);
    line(tower.getLocation().getX()+tileSize/2,tower.getLocation().getY()+tileSize/2,mob.getLocation().getX(),mob.getLocation().getY());
  }
}
