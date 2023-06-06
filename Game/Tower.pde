public class Tower {
  private int attackSpeed;
  private int power;
  private int numRange;
  private int range;
  private Location position;
  private int level;
  PImage img;
  public Tower(int x, int y) {
    img = loadImage("tower.png");
    attackSpeed = 10;
    power = 10;
    numRange = 2;
    range = tileSize + (numRange * tileSize);
    position = new Location(x,y);
  }
  public Tower(int x, int y, int attackSpeed, int power, int range) {
    img = loadImage("tower.png");
    this.attackSpeed = attackSpeed;
    this.power = power;
    numRange = range;
    this.range = (numRange * tileSize) + tileSize;
    position = new Location(x,y);
  }
  public Location getLocation() {
    return position;
  }
  private boolean attack(Mob m, int time) {
    if (time % (60 / attackSpeed) == 0) {
      if (inRange(m.getLocation())) {
        m.doDamage(power);
        return true;
      }
    }
    return false;
  }
  private boolean inRange(Location p) {
    Location temp = new Location((position.getX() + (tileSize /2 )), (position.getY() + (tileSize /2 )), true);
    return (p.distTo(temp)<=range);
  }
  public Location changePosition(int x, int y) {
    position.changeLocation(x, y);
    return position;
  }
  public void changeAttack(int x) {
    attackSpeed += x;
  }
  public void setAttack(int x) {
    attackSpeed = x;
  }
  public void setPosition(int x, int y) {
    position = new Location(x, y);
  }
  public int getAttack() {
    return attackSpeed;
  }
  public int getPower() {
    return power;
  }
  public int getRange() {
    return numRange;
  }
  public String toString() {
    return (position + "AD: " + attackSpeed + "P: " + power + "R: " + range);
  }
  public void display() {
    float x = position.getX();
    float y = position.getY();
    image(towerimg,x+15,y,75,100);
  }
  public int getLevel() {
    return level;
  }
  public void upgrade () {
    level++;
    attackSpeed = attackSpeed + 5;
    power = power + 5;
    numRange++;
    range = (numRange * tileSize) + tileSize;
  }
}
