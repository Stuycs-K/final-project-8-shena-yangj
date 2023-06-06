public class Laser{
  Tower tower;
  public Laser(Tower tower) {
    this.tower = tower;
  }
  void display(Mob mob) {
    pushStyle();
    colorMode(HSB,100);
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
    //strokeWeight(20);
    //stroke(0,0,100);
    //line(tower.getLocation().getX()+tileSize/2,tower.getLocation().getY()+tileSize/2,mob.getLocation().getX(),mob.getLocation().getY());
    
    //strokeWeight(17);
    //stroke(0,100,50);
    //line(tower.getLocation().getX()+tileSize/2,tower.getLocation().getY()+tileSize/2,mob.getLocation().getX(),mob.getLocation().getY());
    
    //blendMode(ADD);
    //strokeWeight(20);
    //stroke(0,0,50);
    //line(tower.getLocation().getX()+tileSize/2,tower.getLocation().getY()+tileSize/2,mob.getLocation().getX(),mob.getLocation().getY());
    for (float i = 0.0;i<100;i++) {
      stroke(0,90+i,100);
      //stroke(0,100,100-100*i);
      //stroke(0,100,0+i*1000);
      strokeWeight(15-i*.1);
      line(tower.getLocation().getX()+tileSize/2,tower.getLocation().getY()+tileSize/2,mob.getLocation().getX(),mob.getLocation().getY());
    }
    blendMode(BLEND);
    stroke(0,100,100);
    strokeWeight(7);
    line(tower.getLocation().getX()+tileSize/2,tower.getLocation().getY()+tileSize/2,mob.getLocation().getX(),mob.getLocation().getY());
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
