public class Mob{
  PImage img;
  private float  moveSpeed;
  private int radius;
  private Location position;
  private int health;
  private boolean moveHorizontally;
  private color c;
  private int attackPower;
  public Mob() {
    img = loadImage("mob.png");
    moveSpeed = .5;//temp, original 10
    position = new Location(50,250,true);
    health = 100;
    moveHorizontally = false;
    radius = 20;
    c = color(random(255), random(255), random(255));
    attackPower = 10;
  }
  public Mob(int x, int y) {
    img = loadImage("mob.png");
    moveSpeed = 1;
    radius = 20;
    health = 100;
    position = new Location(x,y,true);
    moveHorizontally = false;
    c = color(random(255), random(255), random(255));
    attackPower = 10;
  }
  public Mob(float speed, int health, int x, int y) {
    img = loadImage("mob.png");
    moveSpeed = speed;
    this.health = health;
    radius = 20;
    position = new Location(x, y,true);
    moveHorizontally = false;
    c = color(random(255), random(255), random(255));
    attackPower = 10;
  }
    
  public float  getSpeed() {
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
  public void move(ArrayList<Location> path,int mapWidth, int mapHeight, int tileSize) {
    boolean endOfPath = false;
    //println(position);
    int place = pIndex(path); //which tile in the path its on
    //println("place: "+place);
    if (place>=path.size()-1) {
      endOfPath = true;
    }
    if (!endOfPath && (position.getX()<mapWidth || position.getY()<mapHeight)) { //in map & not last path tile
      Location temp = new Location(position.getX() + (tileSize /2), position.getY());
      Location temp2 = new Location(position.getX(), position.getY() + (tileSize / 2) + 1);
      Location temp3 = new Location(position.getX(), position.getY() - (tileSize /2 ) - 1);
      if ((position.getY() % (tileSize / 2) == 0 && position.getY() % 100 != 0) && (temp.isEqual(path.get(place + 1)) || position.getX() + (tileSize /2) >= path.get(place).getX() + (tileSize /2) && position.getX() + (tileSize /2 ) < path.get(place).getX() + tileSize)) {
        position.changeLocation(moveSpeed, 0);
        moveHorizontally = true;
      }
      else if (!(path.get(place).getY() > path.get(place + 1).getY()) && (temp2.isEqual(path.get(place + 1)) || position.getY() + (tileSize /2) < path.get(place).getY() + tileSize && position.getY() + (tileSize /2 ) >= path.get(place).getY() + (tileSize /2))) {
        position.changeLocation(0, moveSpeed);
        moveHorizontally = false;
      }
      else if (temp3.isEqual(path.get(place + 1)) || position.getY() - (tileSize /2) > path.get(place).getY()&& position.getY() - (tileSize /2 ) <= path.get(place).getY() + (tileSize /2)) {
        position.changeLocation(0, moveSpeed * -1);
        moveHorizontally = false;
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
    //circle(position.getX(),position.getY(),radius);
    image(img,position.getX()-20,position.getY()-20,50,50);
    fill(255-red(c),255-green(c),255-blue(c));
    textSize(10);
    text(health,position.getX()-8,position.getY()+2);
  }
  public int pIndex(ArrayList<Location> paths) { //find where mob is in the path
  Location test = new Location(position.getX(), position.getY());
  for (int i = 0; i < paths.size(); i++) {
    if (paths.get(i).isEqual(test)) {
      return i;
    }
   }
    return -1;
  }
}
