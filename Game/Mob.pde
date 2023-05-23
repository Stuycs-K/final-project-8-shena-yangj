public class Mob{
  private int moveSpeed;
  private Location position;
  private int health;
  private float x,y;
  public Mob() {
    moveSpeed = 10;
    x = 100;
    y = 100;
    position = new Location(100,100);
    health = 100;
  }
  public Mob(int x, int y) {
    this.x = x;
    this.y = y;
    position = new Location(x,y);
  }
  public int getSpeed() {
    return moveSpeed;
  }
  public int getHealth() {
    return health;
  }
  public boolean doDamage(int change) { //return false if health < 0
    if (health>0) {
      health-=change;
      return true;
    } else return false;
  }
  public void move() { 
    x+=moveSpeed;
    y+=moveSpeed;
  }
  public Location getLocation() {
    return position;
  }
  public void display() {
    fill(146,255,253);
    circle(x,y,20);
  }
}
