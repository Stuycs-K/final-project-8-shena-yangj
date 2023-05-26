public class Tower {
  private int attackDelay;
  private int power;
  private int range;
  private Location position;
  public Tower(int x, int y) {
    attackDelay = 10;
    power = 10;
    range = tileSize + (2 * tileSize);
    position = new Location(x,y);
  }
  public Tower(int x, int y, int attackDelay, int power, int range) {
    this.attackDelay = attackDelay;
    this.power = power;
    this.range = (range * tileSize) + tileSize;
    position = new Location(x,y);
  }
  public Location getLocation() {
    return position;
  }
  private void attack(Mob m, int time) {
    if (time % attackDelay == 0) {
      if (inRange(m.getLocation())) {
        m.doDamage(power);
      }
    }
  }
  private boolean inRange(Location p) {
    Location temp = new Location((position.getX() + (tileSize /2 )), (position.getY() + (tileSize /2 )), true);
    return (p.distTo(temp)<=range);
  }
  public Location changePosition(int x, int y) {
    position.changeLocation(x, y);
    return position;
  }
  public void setPosition(int x, int y) {
    position = new Location(x, y);
  }
  public String toString() {
    return (position + "AD: " + attackDelay + "P: " + power + "R: " + range);
  }
}
