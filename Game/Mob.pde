public class Mob{
  private int moveSpeed;
  private Location position;
  private int health;
  public Mob() {
    moveSpeed = 10;
    position = new Location(50,250);
    health = 100;
  }
  public Mob(int x, int y) {
    moveSpeed = 10;
    health = 100;
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
  //path following
  public void move(ArrayList<Location> path,int mapWidth, int mapHeight, int place) {
    println("place: "+place);
    //int place = 0;
    int pathslength = path.size()-1;
    boolean endOfPath = false;
    //while (!endOfPath) {
      println(position);
      if (place+1>=pathslength) endOfPath = true;
      if (!endOfPath && (path.get(place).getX()<mapWidth || path.get(place).getY()<mapHeight)) { //in map
        if (path.get(place).getY()==path.get(place+1).getY()) {
          position.changeLocation(moveSpeed,0);
        } else if (path.get(place+1).getX()==path.get(place).getX()) { //same vertically
        position.changeLocation(0,moveSpeed);
        }
      }
  }
  public Location getLocation() {
    return position;
  }
  public void display() {
    fill(146,255,253);
    circle(position.getX(),position.getY(),20);
  }
}
