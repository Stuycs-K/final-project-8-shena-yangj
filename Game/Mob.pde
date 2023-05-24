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
  public void move(ArrayList<Location> path,int mapWidth, int mapHeight) { 
    int place = 0;
    int pathslength = path.size()-1;
    boolean endOfPath = false;
    while (!endOfPath) {
      println(position);
      if (path.get(place).getX()<mapWidth || path.get(place).getY()<mapHeight) { //in map
        if (path.get(place).getY()==path.get(place+1).getY()) {
          position.changeLocation(position.getX()+moveSpeed,position.getY());
          //display();
        }
        
      }
      if (place+1>=pathslength) endOfPath = false;
    }
    //for (int i = 0;i<path.size()-1;i++) {
    //  private int x = position.getX();
    //  private int y = position.getY();
    //  if (path.get(i+1).getY()==path.get(i).getY()) { //same horizontally
    //    position.changeLocation(x+moveSpeed,y);
    //    //print("HERE");
    //  } else if (path.get(i+1).getX()==path.get(i).getY()) { //same vertically
    //    position.changeLocation(x,y+moveSpeed);
    //  }
    //}
  }
  public Location getLocation() {
    return position;
  }
  public void display() {
    println("x: "+position.getX()+" y: "+position.getY());
    fill(146,255,253);
    circle(position.getX(),position.getY(),20);
  }
}
