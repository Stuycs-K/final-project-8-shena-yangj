public class Mob{
  private int moveSpeed;
  private int radius;
  private Location position;
  private int health;
  private boolean moveHorizontally;
  private color c;
  private int attackPower;
  public Mob() {
    moveSpeed = 10;//temp, original 10
    position = new Location(50,250,true);
    health = 100;
    moveHorizontally = false;
    radius = 20;
    c = color(random(255), random(255), random(255));
    attackPower = 10;
  }
  public Mob(int x, int y) {
    moveSpeed = 10;
    radius = 20;
    health = 100;
    position = new Location(x,y,true);
    moveHorizontally = false;
    c = color(random(255), random(255), random(255));
    attackPower = 10;
  }
  public Mob(int speed, int health, int x, int y) {
    moveSpeed = speed;
    this.health = health;
    radius = 20;
    position = new Location(x, y,true);
    moveHorizontally = false;
    c = color(random(255), random(255), random(255));
    attackPower = 10;
  }
    
  public int getSpeed() {
    return moveSpeed;
  }
  public int getRadius() {
    return radius;
  }
  public int getHealth() {
    return health;
  }
  public int getAttackPower() {
    return attackPower;
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
    int place = pIndex(path, pathListLength); //which tile in the path its on
    //println("place: "+place);
    if (place>=pathListLength-1) {
      endOfPath = true;
      //print("End of path is true | place: "+place);
    }
    if (!endOfPath && (position.getX()<mapWidth || position.getY()<mapHeight)) { //in map & not last path tile
      //if (path.get(place).getY()==path.get(place+1).getY()) {
      //  if (position.getY()==path.get(place).getY()+tileSize/2) {
      //    position.changeLocation(moveSpeed,0);
      //    moveHorizontally = true;
      //  } else {
      //    position.changeLocation(0,moveSpeed);
      //    moveHorizontally = false;
      //  }
      //} else if (path.get(place+1).getX()==path.get(place).getX()) { //same vertically
      //  if (position.getX()==path.get(place).getX()+tileSize/2) {
      //    position.changeLocation(0,moveSpeed);
      //    moveHorizontally = false;
      //  } else {
      //    position.changeLocation(moveSpeed,0);
      //    moveHorizontally = true;
      //  }
      //}
      Location temp = new Location(position.getX() + moveSpeed, position.getY());
      Location temp2 = new Location(position.getX(), position.getY() + moveSpeed);
      //println(temp);
      //println(temp2);
      //println(place);
      //println(path.get(place));
      //println(path.get(place + 1));
      if (temp.isEqual(path.get(place)) || temp.isEqual(path.get(place + 1))) {
        position.changeLocation(moveSpeed, 0);
        moveHorizontally = true;
      }
      else if (temp2.isEqual(path.get(place)) || temp2.isEqual(path.get(place + 1))) {
        position.changeLocation(0, moveSpeed);
        moveHorizontally = false;
      }
      else {
        position.changeLocation(0, moveSpeed * -1);
        moveHorizontally = false;
      }
    } else if (endOfPath) {
      //print("HERE");
      if (moveHorizontally) position.changeLocation(moveSpeed,0);
      else position.changeLocation(0,moveSpeed); //was moving vertically before
    }
  }
  
  public Location getLocation() {
    return position;
  }
  public void display() {
    fill(c);
    circle(position.getX(),position.getY(),radius);
    fill(255-red(c),255-green(c),255-blue(c));
    textSize(10);
    text(health,position.getX()-8,position.getY()+2);
  }
  public int pIndex(ArrayList<Location> paths, int pathLength) { //find where mob is in the path
  //  int pIndex = 0;
  //  for (int i = 0;i<pathLength;i++) {
  //    //print("I: "+i);
  //    //moving to the right originally
  //    if (paths.get(i).getX()+tileSize>=position.getX() && position.getX()>paths.get(i).getX()) {
  //      //x's are the same
  //      if (moveHorizontally) { //moving vertically
  //        return i;
  //      }
  //    } else if (paths.get(i).getY()+tileSize>=position.getY() && position.getY()>paths.get(i).getY()) {
  //      if (!moveHorizontally) {
  //        return i;
  //      } else pIndex++;
  //    }
  //  }
  //  return pIndex;
  //}
  
  Location test = new Location(position.getX(), position.getY());
  //println("P: " + paths.get(1));
  //println("B: " + test);
  //println(paths.size());
  for (int i = 0; i < paths.size(); i++) {
    if (paths.get(i).isEqual(test)) {
      return i;
    }
   }
    return -1;
  }
  }
