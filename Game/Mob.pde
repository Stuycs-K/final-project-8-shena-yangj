public class Mob{
  PImage[] mob=new PImage[4];
  private float moveSpeed;
  private int radius;
  private Location position;
  private int health;
  private int totalHealth;
  private boolean moveHorizontally;
  private int attackPower;
  public Mob(float x, float y, String difficulty) {
    if (difficulty.equals("EASY")) moveSpeed = 1;
    if (difficulty.equals("MEDIUM")) moveSpeed = 1;
    if (difficulty.equals("HARD")) moveSpeed = 2;
    mob[0] = loadImage("mob0.gif");
    mob[1] = loadImage("mob1.gif");
    mob[2] = loadImage("mob2.gif");
    mob[3] = loadImage("mob3.gif");
    moveSpeed = 1;
    radius = 20;
    health = 500;
    totalHealth = 500;
    position = new Location(x,y,true);
    moveHorizontally = false;
    attackPower = 10;
  }
  public Mob(float speed, int health, int x, int y) {
    mob[0] = loadImage("mob0.gif");
    mob[1] = loadImage("mob1.gif");
    mob[2] = loadImage("mob2.gif");
    mob[3] = loadImage("mob3.gif");
    moveSpeed = speed;
    this.health = health;
    totalHealth = health;
    radius = 20;
    position = new Location(x, y,true);
    moveHorizontally = false;
    attackPower = 10;
  }
  public void changeSpeed(int x) {
    moveSpeed += x;
  }
  public void setSpeed(float x) {
    moveSpeed = x;
  }
  public float  getSpeed() {
    return moveSpeed;
  }
  public void changeRadius(int x) {
    radius += x;
  }
  public void setRadius(int x) {
    radius = x;
  }
  public int getRadius() {
    return radius;
  }
  public int getHealth() {
    return health;
  }
  public void changeHealth(int x) {
    health += x;
  }
  public void sethealth(int x) {
    health = x;
  }
  public void changePower(int x) {
    attackPower += x;
  }
  public void setPower(int x) {
    attackPower = x;
  }
  public int getAttackPower() {
    return attackPower;
  }
  public int doDamage(int change) { //return false if health < 0
    if (health>0) {
      if (change > health) {
        int ret = health;
        health = 0;
        return ret;
      }
      else {
        health-=change;
        return change;
      }
    }
    return 0;
  }
  //path following and mob movement
  public void move(ArrayList<Location> path,int mapWidth, int mapHeight, int tileSize) {
    boolean endOfPath = false;
    int place = pIndex(path); //which tile in the path its on
    if (place>=path.size()-1) {
      endOfPath = true;
    }
    if (!endOfPath && (position.getX()<mapWidth || position.getY()<mapHeight)) { //in map & not last path tile
      Location temp = new Location(position.getX() + (tileSize /2), position.getY());
      Location temp2 = new Location(position.getX(), position.getY() + (tileSize / 2) + 1);
      Location temp3 = new Location(position.getX(), position.getY() - (tileSize /2 ) - 1);
      if ((position.getY() % (tileSize / 2) == 0 && position.getY() % 100 != 0) 
      && (temp.isEqual(path.get(place + 1)) || 
      position.getX() + (tileSize /2) >= path.get(place).getX() + (tileSize /2) && 
      position.getX() + (tileSize /2 ) < path.get(place).getX() + tileSize)) {
        position.changeLocation(moveSpeed, 0);
        moveHorizontally = true;
      }
      else if (!(path.get(place).getY() > path.get(place + 1).getY()) && (temp2.isEqual(path.get(place + 1)) || 
      position.getY() + (tileSize /2) < path.get(place).getY() + tileSize && position.getY() + (tileSize /2 ) >= path.get(place).getY() + (tileSize /2))) {
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
    if (!dead()) {image(mob[frameCount/10%4],position.getX()-20,position.getY()-20);
      tint(255);
      healthBar();
    }
  }
  public boolean dead() {
    return health<=0;
  }
  public void healthBar() {
    //total
    fill(255,0,0);
    //stroke(0);
    noStroke();
    rect(position.getX()-10,position.getY()-24,40,10,30);
    fill(0,255,0);
    noStroke();
    float percent = health/(float)totalHealth;
    rect(position.getX()-10,position.getY()-24,percent*40,10,30);
    fill(0,0,0);
    textSize(14);
    text(health,position.getX()-9,position.getY()-15);
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
