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
  public void move(ArrayList<Location> path,int mapWidth, int mapHeight, int place, int tileSize) {
    //int place = 0;
    int pathslength = path.size()-1;
    //boolean endOfPath = false;
    println(position);
    //if (place+1>=pathslength) endOfPath = true;
    if (position.getX()<mapWidth || position.getY()<mapHeight) { //in map
      if (path.get(place).getY()==path.get(place+1).getY()) {
        if (position.getY()==path.get(place).getY()+tileSize/2) {
          position.changeLocation(moveSpeed,0);
        } else position.changeLocation(0,moveSpeed);
      } else if (path.get(place+1).getX()==path.get(place).getX()) { //same vertically
        if (position.getX()==path.get(place).getX()+tileSize/2) {
          position.changeLocation(0,moveSpeed);
        } else position.changeLocation(moveSpeed,0);
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
