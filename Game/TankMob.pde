public class TankMob extends Mob {
  //private int armor;
  PImage[] tankmob=new PImage[4];
  private Location position;
  private float moveSpeed;
  private boolean moveHorizontally;
  private int health;
  private int totalHealth;
  private int attackPower;
  public TankMob (float x, float y,String difficulty) {
    super(x,y,difficulty);
    //img = loadImage("tankmob.png");
    tankmob[0] = loadImage("tankmob0.gif");
    tankmob[1] = loadImage("tankmob1.gif");
    tankmob[2] = loadImage("tankmob2.gif");
    tankmob[3] = loadImage("tankmob3.gif");
    //armor = 10;
    attackPower = 20;
    if (difficulty.equals("EASY")) moveSpeed = 1;
    if (difficulty.equals("MEDIUM")) moveSpeed = 1;
    if (difficulty.equals("HARD")) moveSpeed = 2;
    moveHorizontally=false;
    health = 750;
    totalHealth = 750;
    position = new Location(x,y,true);
  }
  public TankMob(int speed, int health, int x, int y, int armor) {
    super(speed, health, x, y);
    //img = loadImage("tankmob.png");
    tankmob[0] = loadImage("tankmob0.gif");
    tankmob[1] = loadImage("tankmob1.gif");
    tankmob[2] = loadImage("tankmob2.gif");
    tankmob[3] = loadImage("tankmob3.gif");
    attackPower = 20;
    health = 750;
    totalHealth = 750;
    position = new Location(x,y,true);
    if (difficulty.equals("EASY")) moveSpeed = 1;
    if (difficulty.equals("MEDIUM")) moveSpeed = 1;
    if (difficulty.equals("HARD")) moveSpeed = 2;
    moveHorizontally=false;
    //this.armor = armor; 
  }
  public void move(ArrayList<Location> path,int mapWidth, int mapHeight, int tileSize) {
    boolean endOfPath = false;
    int place = pIndex(path); //which tile in the path its on
    println(place + "/" + (path.size() -1 ));
    if (place>=path.size()-1) {
      endOfPath = true;
    }
    println(endOfPath);
    if (!endOfPath && (position.getX()<mapWidth || position.getY()<mapHeight)) { //in map & not last path tile
      //print("place: "+place);
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
  //public int getArmor() {
  //  return armor;
  //}
  //public int changeArmor(int change) {
  //  armor -= change;
  //  return armor;
  //}
  //public void setArmor(int armor) {
  //  this.armor = armor;
  //}
  public void display() {
    if (!dead()) {
      //image(img,position.getX()-20,position.getY()-14,50,50);
      image(tankmob[frameCount/10%4],position.getX()-20,position.getY()-20,50,50);
      tint(255);
      healthBar();
    }
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
  public int getHealth() {
    return health;
  }
  public int getAttackPower() {
    return attackPower;
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
    //print(test);
    for (int i = 0; i < paths.size(); i++) {
      //println("p: " + paths.get(i) + "/" + test);
      if (paths.get(i).isEqual(test)) {
        return i;
      }
     }
    return -1;
  }
  public Location getLocation() {
    return position;
  }
  //public int doDamage(int change) {
  //  double percent = armor / 100.0;
  //  if (super.health > 0) {
  //    if (change * percent > super.health) {
  //      int ret = super.health;
  //      super.health = 0;
  //      return ret;
  //    }
  //    else {
  //      super.health -= (change * percent);
  //      return (int)(change * percent);
  //    }
  //  }
  //  return 0;
  //}
}
