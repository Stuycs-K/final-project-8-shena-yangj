import java.util.*; 
int time;
int round;
int totalHealth;
int maxTowers;
int balance;
int tileSize;
int mapWidth;
int mapHeight;
int selectNum;
int reward;
int score;
int interval;
int powerChosen;
int powerTime;
PImage towerimg;
boolean gameOver;
int timer;
Location endZone;
ArrayList<Integer> prices;
Tower selectedTower;
boolean selected;
ArrayList<Tower> selects;
ArrayList<Tower> towers;
ArrayList<Mob> mobs;
ArrayList<Location> paths;
void setup() {
  powerTime = 0;
  timer = 0;
  size(1000, 800);
  towerimg = loadImage("tower.png");
  tileSize=100;
  mapWidth = width-200;
  mapHeight = height;
  background(148, 114, 70);
  time=0;
  round = 100;
  gameOver = false;
  interval = 30;
  mobs = new ArrayList<Mob>();
  towers = new ArrayList<Tower>();
  paths = new ArrayList<Location>();
  balance = 50;
  selected = false;
  totalHealth = 100;
  maxTowers = 10;
  powerChosen = -1;
  prices = new ArrayList<Integer> ();
  for (int i = 0; i < 4; i++) {
    prices.add((i * 25) + 50);
  }
  selectNum = -1;
  reward = 10;
  selects = new ArrayList<Tower> ();
  for (int i = 0; i < 4; i++) {
    int r = (int)(Math.random() * (prices.get(i) / 2))+1;
    selects.add(new Tower(0,0,r, (prices.get(i) / r), 1));
    //println(selects.get(i));
  }
  score = 0;
  initialGenerateMap();menu();
}
void menu() {
  textSize(15);
  stroke(0);
  fill(146,152,255);
  rect(mapWidth + 1,0,mapWidth,mapHeight);
  for (int i = 0; i < 4; i++) {
    fill(144,10,255);
    rect(mapWidth + 21, 10 + (100 * i), 100 + 60, 100);
    fill(255,0,0);
    text("Price: " + prices.get(i), mapWidth + 23, 30 + (100 * i));
    text("AttackDelay: " + selects.get(i).getAttack(), mapWidth + 23, 50 + (100 * i));
    text("Power: " + selects.get(i).getPower(), mapWidth + 23, 70 + (100 * i));
  }
  for (int i = 0; i < 2; i++) {
    fill(255,255,0);
    rect(mapWidth + 21, 450 + (75 * i), 80, 75);
    rect(mapWidth + 101, 450 + (75 * i), 80, 75);
    fill(255,0,0);
  }
  if (selectNum >= 0) {
    stroke(200);
    fill(144,10,255);
    rect(mapWidth + 21, 10 + (100 * selectNum), 100 + 60, 100);
    fill(255,0,0);
    text("Price: " + prices.get(selectNum), mapWidth + 23, 30 + (100 * selectNum));
    text("AttackDelay: " + selects.get(selectNum).getAttack(), mapWidth + 23, 50 + (100 * selectNum));
    text("Power: " + selects.get(selectNum).getPower(), mapWidth + 23, 70 + (100 * selectNum));
    stroke(0);
  }
  textSize(25);
  text("Towers: " + towers.size() + "/" + maxTowers, mapWidth + 21, mapHeight - 20);
  text("Mob count: " + mobs.size(), mapWidth + 21, mapHeight - 50);
  text("Balance: " + balance, mapWidth + 21, mapHeight - 80);
  text("Round Timer: " + round, mapWidth + 10, mapHeight - 140);
  text("Total Health: "+totalHealth, mapWidth+10,mapHeight-160);
  text("Score: " + score, mapWidth + 21, mapHeight - 110);
  textSize(15);
  strokeWeight(5);
  stroke(255,87,51);
  endZone = new Location(paths.get(paths.size()-1).getX()+tileSize,paths.get(paths.size()-1).getY());
  line(endZone.getX()+5,endZone.getY(),endZone.getX()+5,endZone.getY()+tileSize);
  strokeWeight(3);
  stroke(0);
}
//for all powerups, should make some type of indicator that they are usable, put them each on a "cooldown" timer of sorts.
//display timer for all powerups
void money() { //0
  //money gain
  if (powerTime == 0) {
    reward = reward * 2;  
    powerTime = 5;
    powerChosen = 0;
  }
  //make another variable to track the amount added by default as time passes
  //somehow change back to original
}
void fireball() { //1
//make so that in tick, for each tick of powerTime, it will change the color of the "crater"
  if (powerTime == 0) {
    int blast = 10;
    int dmg = 15;
    Location temp = new Location(mouseX, mouseY);
    for (int i = 0; i < mobs.size(); i++ ) {
      if (temp.distTo(mobs.get(i).getLocation()) <= blast) {
        mobs.get(i).doDamage(dmg);
      }
    }
    powerTime = 5;
    powerChosen = 1;
  }
  //make animation somehow
}
void speedTower() { //2
  if (powerTime == 0) {
    for (int i = 0; i < towers.size(); i++) {
      towers.get(i).setAttack(towers.get(i).getAttack() * 2);
    }
    powerTime = 5;
    powerChosen = 2;
  }
  
  //somehow change back?
}
void slowMob() { //3
  if (powerTime == 0) {
    
    for (int i = 0; i < mobs.size(); i++) {
      mobs.get(i).setSpeed(mobs.get(i).getSpeed() / 2);
    }
    powerTime = 5;
    powerChosen = 3;
  }
  
}
void mouseClicked() {
  fill(144,10,255);
  if (mouseX >= mapWidth + 20 && mouseX <= (mapWidth + 100 + 80)) {
    for (int i = 0; i < 4; i++) {
      if (mouseY >= 10 + (100 * i) && mouseY <= 110 + (100 * i)) {
        stroke(200);
        fill(144,10,255);
        rect(mapWidth + 21, 10 + (100 * i), 100 + 60, 100);
        fill(255,0,0);
        text("Price: " + prices.get(i), mapWidth + 23, 30 + (100 * i));
        text("AttackDelay: " + selects.get(i).getAttack(), mapWidth + 23, 50 + (100 * i));
        text("Power: " + selects.get(i).getPower(), mapWidth + 23, 70 + (100 * i));
        selectedTower = selects.get(i);
        selected = true;
        selectNum = i;
      }
    }
    if (timer <= 0) {
      if (mouseX <= mapWidth + 21 + 80 && mouseY >= 450 && mouseY <= 525) {
        money();
      }
      if (mouseX <= mapWidth + 21 + 80 && mouseY >= 526 && mouseY <= 590) {
        fireball();
      }
      if (mouseX >= mapWidth + 21 + 81 && mouseX <= mapWidth + 21 + 180 && mouseY >= 450 && mouseY <= 525) {
        speedTower();
      }
      if (mouseX >= mapWidth + 21 + 81 && mouseX <= mapWidth + 21 + 180 && mouseY >= 526 && mouseY <= 590) {
        slowMob();
      }
    }
    
    //finish later
    
  }
  if (mouseX <= mapWidth && selected && towers.size() < maxTowers) {
    placeTower(mouseX, mouseY);
    selected = false;
    menu();
  }
    
}
void generateMap() {
  fill(148,114,70); //background color
  rect(0,0,mapWidth,mapHeight);
  menu();
  //paths = new ArrayList<Location>();
  stroke(0);
  for (int i = 0;i<mapWidth;i+=tileSize) {
    strokeWeight(3);
    line(i,0,i,mapHeight);
  }
  for (int i = 0;i<mapHeight;i+=tileSize) {
    line(0,i,mapWidth,i);
  }
  fill(60, 201, 70);
  for (int i = 0;i<mapWidth;i+=tileSize) {
    for (int j = 0;j<mapHeight;j+=tileSize) {
      if (j==tileSize*2 && i<mapHeight/2) {
        square(i,j,tileSize);
      } else if (i==tileSize * 3 && (j >= 0 && j <= tileSize * 2)) {
        square(i,j,tileSize);
      } else if (i>=tileSize * 4 && j==0) {
        square(i,j,tileSize);
      }
    }
  }
  fill(255,0,0);
  //for (int i = 0;i<towers.size();i++) {
  //  square(towers.get(i).getLocation().getX(),towers.get(i).getLocation().getY(),tileSize);
  //  towers.get(i).display();
    print("tower size: "+towers.size());
    println(towers.toString());
  //  //displayTowers();
  //}
  fill(60,201,70);
  displayTowers();
}
void initialGenerateMap() {
  paths = new ArrayList<Location>();
  stroke(0);
  for (int i = 0;i<mapWidth;i+=tileSize) {
    strokeWeight(3);
    line(i,0,i,mapHeight);
  }
  for (int i = 0;i<mapHeight;i+=tileSize) {
    line(0,i,mapWidth,i);
  }
  fill(60, 201, 70);
  for (int i = 0;i<mapWidth;i+=tileSize) {
    for (int j = 0;j<mapHeight;j+=tileSize) {
      if (j==tileSize*2 && i<mapHeight/2) {
        square(i,j,tileSize);
        paths.add(new Location(i,j));
      } else if (i==tileSize * 3 && paths.size() <= 4) {
        for (int w = 100; w >= 0;w -= tileSize) {
          square(i,w,tileSize);
        }
        
      } else if (i>=tileSize * 4 && j==0) {
        square(i,j,tileSize);
        paths.add(new Location(i,j));
      }
    }
  }
  paths.add(4, new Location(tileSize * 3, 100));
  paths.add(5, new Location(tileSize * 3, 0));
}

void displayTowers() {
  for (Tower tower : towers) {
    //float x = towers.get(i).getLocation().getX();
    //float y = towers.get(i).getLocation().getY();
    //image(towerimg,x+15,y,75,100);
    tower.display();
  }
}
void changeBalance(int amount) {
  balance += amount;
}
boolean towerOnPath(int x, int y) {
  boolean ans = false;
  for(int i = 0;i<paths.size();i++) {
    float pathx = paths.get(i).getX();
    float pathy = paths.get(i).getY();
    if (x>=pathx && x<=pathx+tileSize && y>=pathy && y<=pathy+tileSize) {
      ans = true;
    }
  }
  return ans;
}

boolean placeTower(int x, int y) {
  if (x >= 0 && x < mapWidth && y >= 0 && y < mapHeight) {
    textSize(20);
    fill(255,255,255);
    //check if on path here
    if (towerOnPath(x,y)) {
      text("Cannot place tower on path",mouseX,mouseY);
      return false;
    }
    if (balance >= prices.get(selectNum)) {
      x = (x / tileSize) * tileSize;
      y = (y / tileSize) * tileSize;
      //fill(255,0,0);
      square(x, y, tileSize);
      //image(towerimg,x,y);
      balance -= prices.get(selectNum);
      towers.add(new Tower(x, y, selectedTower.getAttack(), selectedTower.getPower(), selectedTower.getRange()));
      menu();
      //check for path somehow
      selectNum = -1;
      return true;
    }
    else {
      String display = "Not Enough Money";
      textSize(20);
      fill(255,255,255);
      text(display, mouseX, mouseY);
      selectNum = -1;
      return false;
    }
  }
  return false;
}

void tick() {
  if (time % 60 == 0) {
    round--;
    if (timer != 0) {
      timer--;
    }
    if (powerChosen >= 0) {
      powerTime--;
    }
  }
  if (time % 120 == 0) {
    changeBalance(10);
  }
  if (powerTime == 0) {
    if (powerChosen == 1) {//fire
    }
    if (powerChosen == 2) {//speedtower
      for (int i = 0; i < towers.size(); i++) {
        towers.get(i).setAttack(towers.get(i).getAttack() / 2);
      }
    }
    if (powerChosen == 3) {//slowMob
      for (int i = 0; i < mobs.size(); i++) {
        mobs.get(i).setSpeed(mobs.get(i).getSpeed() * 2);
      }
    }
}
void draw() {
  menu();
  if (time % 240==0) {//make a mob every few seconds
  //if (time==0) {
    mobs.add(new Mob(50,250));
  }
  
  for (int i = 0; i < mobs.size(); i++) {
    if (mobs.get(i).getHealth() <= 0) {
      mobs.remove(mobs.get(i));
      i--;
      balance += reward;
      score++;
      //eventually make diff score depending on mob killed
      //reward should depend on future difficulty modes
    }
  }
  generateMap();
  for (int i = 0;i<mobs.size();i++) {
    if (mobs.get(i).getLocation().getX()>= endZone.getX()) {
      
      totalHealth-=mobs.get(i).getAttackPower();
      mobs.remove(i);
      if (i < mobs.size()) {
        mobs.get(i).move(paths,mapWidth,mapHeight,tileSize);
        mobs.get(i).display();
      }
      //+ mobs.get(i).getRadius()
      println("totalHealth: "+totalHealth);
      continue; //continue w/ next mob since otherwise will run rest of method too
    }
    if (totalHealth<=0 || round <= 0) {
      gameOver = true;
      menu();
      break;
    }
    mobs.get(i).move(paths,mapWidth,mapHeight,tileSize);
    mobs.get(i).display();
  }
  if (gameOver) {
    if (totalHealth <= 0) {
      print("YOU LOSE");
      delay(2000);
      exit();
    }
    if (round <= 0) {
      print("YOU WIN");
      delay(2000);
      exit();
    }
  }
  for (Tower a : towers) {
    for (Mob b : mobs) {
      if (a.attack(b, time)) {
        break;
      }
    }
  }
  time++;
  tick();
}
