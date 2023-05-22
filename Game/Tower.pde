public class Tower {
  private int attackSpeed;
  private int power;
  private int range;
  private Location position;
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
}
