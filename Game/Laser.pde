public class Laser{
  Tower tower;
  public Laser(Tower tower) {
    this.tower = tower;
  }
  void display(Mob mob) {
    pushStyle();
    colorMode(HSB,100);
    blendMode(ADD); for (float i = 0.0;i<100;i++) {
      stroke(0,90+i,100);
      strokeWeight(15-i*.1);
      line(tower.getLocation().getX()+tileSize/2,tower.getLocation().getY()+tileSize/2,mob.getLocation().getX(),mob.getLocation().getY());
    }
    blendMode(BLEND);
    stroke(0,100,100);
    strokeWeight(7);
    line(tower.getLocation().getX()+tileSize/2,tower.getLocation().getY()+tileSize/2,mob.getLocation().getX(),mob.getLocation().getY());
    popStyle();
  }
}
