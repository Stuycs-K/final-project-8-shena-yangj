public class Tower {
  private int attackSpeed;
  private int power;
  private int range;
  private Location position;
  public Tower(int x, int y) {
    attackSpeed = 10;
    power = 10;
    range = 10;
    position = new Location(x,y);
  }
  public Tower(int x, int y, int attackSpeed, int power, int range) {
    this.attackSpeed = attackSpeed;
    this.power = power;
    this.range = range;
    position = new Location(x,y);
  }
  public Location getLocation() {
    return position;
  }
  private boolean attack(Mob m) {
    if (inRange(m.getLocation())) {
      m.doDamage(power);
      return true;
    } else return false;
  }
  private boolean inRange(Location p) {
    return (p.distTo(position)<=range);
  }
  public Location changePosition(int x, int y) {
    position.changeLocation(x, y);
    return position;
  }
  public void setPosition(int x, int y) {
    position = new Location(x, y);
  }
}
