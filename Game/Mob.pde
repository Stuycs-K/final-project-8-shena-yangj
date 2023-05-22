public class Mob{
  private int moveSpeed;
  private Location position;
  private int health;
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
  public boolean move(int x, int y) { 
    return position.changeLocation(x,y); 
  }
  public String getLocation() {
    return "("+position.getX()+","+position.getY()+")";
  }
}
