public class Mob{
  private int moveSpeed;
  private Location position;
  private int health;
  private boolean moveHorizontally;
  private color c;
  public Mob() {
    moveSpeed = 10;
    position = new Location(50,250,true);
    health = 100;
    moveHorizontally = false;
    c = color(random(255), random(255), random(255));
  }
  public Mob(int x, int y) {
    moveSpeed = 10;
    health = 100;
    position = new Location(x,y,true);
    moveHorizontally = false;
    c = color(random(255), random(255), random(255));
  }
  public Mob(int speed, int health, int x, int y) {
    moveSpeed = speed;
    this.health = health;
    position = new Location(x, y,true);
    moveHorizontally = false;
    c = color(random(255), random(255), random(255));
  }
    
  public int getSpeed() {
    return moveSpeed;
  }
  public int getHealth() {
    return health;
  }
  public void doDamage(int change) { //return false if health < 0
    if (health>0) {
      health-=change;
    }
  }
  //path following and mob movement
  public void move(ArrayList<Location> path,int mapWidth, int mapHeight, int tileSize, int pathListLength) {
    boolean endOfPath = false;
    //println(position);
    int place = pIndex(path); //which tile in the path its on
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
    fill(255-red(c),255-green(c),255-blue(c));
    textSize(10);
    text(health,position.getX()-8,position.getY()+2);
  }
  public int pIndex(ArrayList<Location> paths) { //find where mob is in the path
    int pIndex = 0;
    for (int i = 0;i<paths.size();i++) {
      //moving to the right originally
      if (paths.get(i).getX()+tileSize>=position.getX() && position.getX()>paths.get(i).getX()) {
        //x's are the same
        if (moveHorizontally) { //moving vertically
          return i;
        }
      } else if (paths.get(i).getY()+tileSize>=position.getY() && position.getY()>paths.get(i).getY()) {
        if (!moveHorizontally) {
          return i;
        } 
      }
    }
    return pIndex;
  }
}
