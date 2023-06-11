public class Tower {
  private int attackSpeed;
  private int power;
  private int numRange;
  private int range;
  private Location position;
  private int slevel;
  private int plevel;
  private int rlevel;
  private int dmgDealt;
  Laser laser;
  PImage img;
  public Tower(int x, int y) {
    dmgDealt = 0;
    slevel = 0;
    plevel = 0;
    rlevel = 0;
    img = loadImage("tower.png");
    attackSpeed = 10;
    power = 10;
    numRange = 2;
    range = tileSize + (numRange * tileSize);
    position = new Location(x,y);
    laser = new Laser(this);
  }
  public Tower(int x, int y, int attackSpeed, int power, int range) {
    dmgDealt = 0;
    slevel = 0;
    plevel = 0;
    rlevel = 0;
    img = loadImage("tower.png");
    this.attackSpeed = attackSpeed;
    this.power = power;
    numRange = range;
    this.range = (numRange * tileSize) + tileSize;
    position = new Location(x,y);
    laser = new Laser(this);
  }
  public Location getLocation() {
    return position;
  }
  private boolean attack(Mob m, int time) {
    if (attackSpeed > 60) {
      attackSpeed = 60;
    }
    if (time % (60 / attackSpeed) == 0) {
      if (inRange(m.getLocation())) {
        dmgDealt += m.doDamage(power);
        return true;
      }
    }
    return false;
  }
  public void laser(Mob m) {
    laser.display(m);
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
    image(towerimg,x+10,y);
  }
  public int speedLevel() {
    return slevel;
  }
  public int powerLevel() {
    return plevel;
  }
  public int rangeLevel() {
    return rlevel;
  }
  public void upgradeRange() {
    rlevel++;
    numRange++;
    range = (numRange * tileSize) + tileSize;
  }
  public void upgradeSpeed() {
    slevel++;
    attackSpeed = attackSpeed + 5;
  }
  public void upgradePower() {
    plevel++;
    power = power + 5;
  }
  public String damage() {
    if (dmgDealt > 999) {
      int ret = ((dmgDealt * 10) / 1000);
      return (ret / 10.0) + "k";
    }
    else {
      return dmgDealt + "";
    }
  }
  public void breakArmor(TankMob a, int damage) {
     a.changeArmor(damage);
  }
}
