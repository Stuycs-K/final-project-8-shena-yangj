public class Tower {
  private int attackSpeed;
  private int power;
  private int range;
  private Location position;
  public Tower(int x, int y) {
    attackSpeed = 10;
    power = 10;
    range = tileSize + (2 * tileSize);
    position = new Location(x,y);
  }
  public Tower(int x, int y, int attackSpeed, int power, int range) {
    this.attackSpeed = attackSpeed;
    this.power = power;
    this.range = (range * tileSize) + tileSize;
    position = new Location(x,y);
  }
  public Location getLocation() {
    return position;
  }
  private void attack(Mob m, int time) {
    if (time % attackSpeed == 0) {
      if (inRange(m.getLocation())) {
        m.doDamage(power);
      }
    }
  }
  private boolean inRange(Location p) {
    Location temp = new Location((position.getX() + 50), (position.getY() + 50), true);
    return (p.distTo(temp)<=range);
  }
  public Location changePosition(int x, int y) {
    position.changeLocation(x, y);
    return position;
  }
  public void setPosition(int x, int y) {
    position = new Location(x, y);
  }
}
