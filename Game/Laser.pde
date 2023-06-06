public class Laser{
  Tower tower;
  public Laser(Tower tower) {
    this.tower = tower;
  }
  void display(Mob mob) {
    pushStyle();
    colorMode(HSB);
    //blendMode(ADD);
    //solid laser
    //stroke(0,100,100);
    //strokeWeight(7);
    //line(tower.getLocation().getX()+tileSize/2,tower.getLocation().getY()+tileSize/2,mob.getLocation().getX(),mob.getLocation().getY());
    //laser glow
    //blendMode(ADD);
    //for (int r = 0;r<.5;r+=0.1) {
    //for (int r = 0;r<.5;r+=.1) {
    //  println("HERE");
    //  stroke(0,100,100);
    //  strokeWeight(15*r);
    //  line(tower.getLocation().getX()+tileSize/2,tower.getLocation().getY()+tileSize/2,mob.getLocation().getX(),mob.getLocation().getY());
    //}
    blendMode(ADD);
    for (float i = 0.0;i<.5;i+=.05) {
      stroke(0,400,400-1000*i);
      strokeWeight(10+i*5);
      line(tower.getLocation().getX()+tileSize/2,tower.getLocation().getY()+tileSize/2,mob.getLocation().getX(),mob.getLocation().getY());
    }
    //stroke(0,100,60);
    //strokeWeight(15);
    //line(tower.getLocation().getX()+tileSize/2,tower.getLocation().getY()+tileSize/2,mob.getLocation().getX(),mob.getLocation().getY());
    //glow.beginDraw();
    //filter(BLUR);
    //stroke(0,100,100);
    //strokeWeight(7);
    //line(tower.getLocation().getX()+tileSize/2,tower.getLocation().getY()+tileSize/2,mob.getLocation().getX(),mob.getLocation().getY());
    //glow.endDraw();
    //}
    popStyle();
  }
}
