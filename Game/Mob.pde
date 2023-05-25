public class Mob{
  private int moveSpeed;
  private Location position;
  private int health;
  private boolean moveHorizontally;
  private color c;
  public Mob() {
    moveSpeed = 10;
    position = new Location(50,250);
    health = 100;
    moveHorizontally = false;
    c = color(random(255), random(255), random(255));
  }
  public Mob(int x, int y) {
    moveSpeed = 10;
    health = 100;
    position = new Location(x,y);
    moveHorizontally = false;
    c = color(random(255), random(255), random(255));
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
  //path following and mob movement
  public void move(ArrayList<Location> path,int mapWidth, int mapHeight, int place, int tileSize, int pathListLength) {
    boolean endOfPath = false;
    println(position);
    if (place>=pathListLength) endOfPath = true;
    if (!endOfPath && (position.getX()<mapWidth || position.getY()<mapHeight)) { //in map & not last path tile
      if (path.get(place).getY()==path.get(place+1).getY()) {
        if (position.getY()==path.get(place).getY()+tileSize/2) {
          position.changeLocation(moveSpeed,0);
          moveHorizontally = true;
        } else {
          position.changeLocation(0,moveSpeed);
          moveHorizontally = false;
        }
      } else if (path.get(place+1).getX()==path.get(place).getX()) { //same vertically
        if (position.getX()==path.get(place).getX()+tileSize/2) {
          position.changeLocation(0,moveSpeed);
          moveHorizontally = false;
        } else {
          position.changeLocation(moveSpeed,0);
          moveHorizontally = true;
        }
      }
    } else if (endOfPath) {
      if (moveHorizontally) position.changeLocation(moveSpeed,0);
      else position.changeLocation(0,moveSpeed); //was moving vertically before
    }
  }
  public Location getLocation() {
    return position;
  }
  public void display() {
    fill(c);
    circle(position.getX(),position.getY(),20);
  }
}
