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
String difficulty;
boolean titleScreen;
boolean levelScreen;
int powerChosen;
int powerTime;
PImage towerimg;
PImage powerIcon;
PImage speedIcon;
PImage rangeIcon;
boolean gameOver;
PImage dirt;
int timer;
boolean towerMenu;
Location endZone;
ArrayList<Integer> prices;
Tower selectedTower;
PImage grass;
boolean selected;
ArrayList<Tower> selects;
ArrayList<Tower> towers;
ArrayList<Mob> mobs;
ArrayList<Location> paths;
int effected;
Tower upTower;
void init() {
  titleScreen = true;
  levelScreen=false;
  towerimg = loadImage("tower.png");
  towerimg.resize(75,100);
  tileSize=100;
  dirt = loadImage("grass2.PNG");
  dirt.resize(width,height);
  background(dirt);
  grass = loadImage("grass.PNG");
  grass.resize(tileSize,tileSize);
  powerIcon = loadImage("Power (2).png");
  rangeIcon = loadImage("Range.png");
  speedIcon = loadImage("Speed.png");
  upTower = new Tower(0,0);
  towerMenu = false;
  timer = 0;
  effected = 0;
  powerTime = 0;
  mapWidth = width-200;
  mapHeight = height;
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
  }
  score = 0;
  titleScreen();
}
void setup() {
  size(1000, 800);
  init();
  frameRate(10);
}
void titleScreen() {
  pushStyle();
  background(255);
  PFont font = createFont("Tahoma Bold",75);
  textFont(font);
  fill(255,0,0);
  text("TOWER DEFENSE",175,200);
  image(towerimg,100,110);
  image(towerimg,825,110);
  strokeWeight(5);
  stroke(0);
  fill(134, 250, 252);
  rect(250,300,500,200);
  fill(0);
  textSize(50);
  text("Click here to start",275,400);
  strokeWeight(10);
  textFont(createFont("Candara Bold",20));
  popStyle();
}
void displayPath() {
  tint(255,126);
  for (int i = 0;i<paths.size();i++) {
    noFill();
    stroke(0);
    rect(paths.get(i).getX(),paths.get(i).getY(),tileSize,tileSize);
    image(grass,paths.get(i).getX(),paths.get(i).getY());
  }
  tint(255);
}
void menu() {
  if (!towerMenu) {
    textSize(15);
    stroke(0);
    fill(146,152,255);
    rect(mapWidth + 1,0,mapWidth,mapHeight);
    for (int i = 0; i < 4; i++) {
      fill(144,10,255);
      rect(mapWidth + 21, 10 + (100 * i), 100 + 60, 100);
      fill(255,0,0);
      text("Price: " + prices.get(i), mapWidth + 23, 30 + (100 * i));
      text("AttackSpeed: " + selects.get(i).getAttack(), mapWidth + 23, 50 + (100 * i));
      text("Power: " + selects.get(i).getPower(), mapWidth + 23, 70 + (100 * i));
    }
    if (selectNum >= 0 && selectNum < 4) {
      stroke(200);
      fill(144,10,255);
      rect(mapWidth + 21, 10 + (100 * selectNum), 100 + 60, 100);
      fill(255,0,0);
      text("Price: " + prices.get(selectNum), mapWidth + 23, 30 + (100 * selectNum));
      text("AttackSpeed: " + selects.get(selectNum).getAttack(), mapWidth + 23, 50 + (100 * selectNum));
      text("Power: " + selects.get(selectNum).getPower(), mapWidth + 23, 70 + (100 * selectNum));
      stroke(0);
    }
    for (int i = 0; i < 2; i++) {
      fill(255,255,0);
      rect(mapWidth + 21, 450 + (75 * i), 80, 75);
      rect(mapWidth + 101, 450 + (75 * i), 80, 75);
      fill(255,0,0);
    }
    if (powerChosen > -1) {
      if (selectNum >= 4 && selectNum <= 7) {
        stroke(200);
        fill(255,255,0);
        //fix math for this part, might have to redo the selectNum order in powerup selections
        if (selectNum >= 6) {
          rect(mapWidth + 21 + (80 * (selectNum % 2)), 450 +75, 80, 75);
        }
        else {
          rect(mapWidth + 21 + (80 * (selectNum % 2)), 450 , 80, 75);
        }
        fill(255,0,0);
      }
    }
    if (powerTime > 0) {
      textSize(100);
      text(powerTime, mapWidth + 77, 550);
    }
    textSize(25);
    text("Towers: " + towers.size() + "/" + maxTowers, mapWidth + 21, mapHeight - 20);
    text("Mob count: " + mobs.size(), mapWidth + 21, mapHeight - 50);
    text("Balance: " + balance, mapWidth + 21, mapHeight - 80);
    text("Round Timer: " + round, mapWidth + 10, mapHeight - 140);
    text("Total Health: "+totalHealth, mapWidth+10,mapHeight-160);
    text("Score: " + score, mapWidth + 21, mapHeight - 110);
    textSize(15);
    strokeWeight(3);
    stroke(255,0,0);
  }else {
    stroke(0);
    fill(146,152,255);
    rect(mapWidth + 1,0,mapWidth,mapHeight);
    square(mapWidth + 21, 20, 160);
    fill(255);
    textSize(18);
    text("Total Damage Dealt: " + upTower.damage(), mapWidth + 4, 210);
    text("Attack Speed: " + upTower.getAttack(), mapWidth + 20, 235);
    text("Power: " + upTower.getPower(), mapWidth + 20, 260);
    text("Range: " + upTower.getRange(), mapWidth + 20, 285);
    fill(146,152,255);
    rect(821, 680, 160, 100);
    rect(821, 560, 160, 100);
    rect(821, 440, 160, 100);
    for (int i = 1; i < 5; i++) {
      if (i <= upTower.speedLevel()) {
        fill(255,155,0);
      }
      else {
        fill(145,152,255);
      }
       circle(840, 527 - (24 * (i - 1)), 18);
      if (i <= upTower.powerLevel()) {
        fill(255,155,0);
      }
      else {
        fill(145,152,255);
      }
       circle(840, 647 - (24 * (i - 1)), 18);
      if (i <= upTower.rangeLevel()) {
        fill(255,155,0);
      }
      else {
        fill(145,152,255);
      }
       circle(840, 767 - (24 * (i - 1)), 18);
    }
    image(towerimg, mapWidth + 21, 20, 160, 160);
    image(powerIcon, 900,570, 80, 80);
    image(speedIcon, 900, 450, 80, 80);
    image(rangeIcon, 900, 690, 80, 80);
    if (upTower.speedLevel() == 4) {
      fill(100,15,15);
      textSize(95);
      text("MAX", 817, 520);
    }
    
  }
  endZone = new Location(paths.get(paths.size()-1).getX()+tileSize,paths.get(paths.size()-1).getY());
  line(endZone.getX()+5,endZone.getY(),endZone.getX()+5,endZone.getY()+tileSize);
  
}
void levelScreen() {
  background(0);
  fill(255);
  textSize(75);
  text("Choose a difficulty",200,300);
  fill(99, 131, 219);
  rect(100,500,200,100);
  rect(400,500,200,100);
  rect(700,500,200,100);
  fill(255);
  textSize(50);
  text("Easy",150,560);
  text("Medium",410,560);
  text("Hard",750,560);
}
void mouseClicked() {
  if (titleScreen) { 
  //button in title screen to go to levelScreen is clicked
    if (mouseX>250 && mouseX<750 && mouseY>300 && mouseY<700) {
      titleScreen = false;
      levelScreen=true;
      levelScreen();
    }
  } else if (levelScreen) {
    //easy is clicked
    if (mouseX>100&&mouseX<300&&mouseY>500&&mouseY<600) {
      difficulty = "EASY";
      levelScreen = false;
      initialRandomMap();
    } else if (mouseX>400&&mouseX<600&&mouseY>500&&mouseY<600){ //medium is clicked
      difficulty = "MEDIUM";
      levelScreen = false;
      initialRandomMap();
    } else if (mouseX>700&&mouseX<900&&mouseY>500&&mouseY<600) {
    //hard is clicked
      difficulty = "HARD";
      levelScreen = false;
      initialRandomMap();
    }
    print("difficulty: "+difficulty);
  }else {
  if (!towerMenu) {
    if (powerChosen == 1) {
        circle(mouseX, mouseY, 100);
        fireball(new Location(mouseX, mouseY));
        powerChosen = -1;
        
      }
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
      if (powerTime == 0) {
        stroke(200);
        if (mouseX >= mapWidth + 21 && mouseX <= mapWidth + 21 + 80 && mouseY >= 450 && mouseY <= 525) {
          money();
          rect(mapWidth + 21, 450,80,75);
          selectNum = 4;
        }
        if (mouseX >= mapWidth + 21 && mouseX <= mapWidth + 21 + 80 && mouseY >= 526 && mouseY <= 590) {
          powerChosen = 1;
          rect(mapWidth + 21, 525, 80, 75);
          selectNum = 6;
        }
        if (mouseX >= mapWidth + 21 + 81 && mouseX <= mapWidth + 21 + 180 && mouseY >= 450 && mouseY <= 525) {
          speedTower();
          rect(mapWidth + 101, 450, 80, 75);
          selectNum = 5;
        }
        if (mouseX >= mapWidth + 21 + 81 && mouseX <= mapWidth + 21 + 180 && mouseY >= 526 && mouseY <= 590) {
          slowMob();
          rect(mapWidth + 101, 525, 80, 75);
          selectNum = 7;
        }
      }
      
      
    
  }
  for (int i = 0; i < towers.size(); i++) {
        if (towers.get(i).getLocation().isEqual(new Location(mouseX, mouseY))) {
          towerMenu = true;
          upTower = towers.get(i);
        }
      }
  if (mouseX <= mapWidth && selected && towers.size() < maxTowers) {
      placeTower(mouseX, mouseY);
      selected = false;
      menu();
    }
  }
  else {
    if (mouseX <= mapWidth) {
    towerMenu = false;
    for (int i = 0; i < towers.size(); i++) {
        if (towers.get(i).getLocation().isEqual(new Location(mouseX, mouseY))) {
          towerMenu = true;
          upTower = towers.get(i);
        }
      }
    }
    else {
      if (mouseX >= 821 && mouseX <= 981) {
        if (mouseY >= 440 && mouseY <= 540) {
          upTower.upgradeSpeed();
        }
        if (mouseY >= 560 && mouseY <= 660) {
          upTower.upgradePower();
        }
        if (mouseY >= 680 && mouseY <= 780) {
          upTower.upgradeRange();
        }
  }
    //finish later
    
  }
  }
 }
  //if click on tower
  //somehow see which tower in the arraylist is selected
  //tower.get(selected).upgrade();
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
void fireball(Location temp) { //1
//make so that in tick, for each tick of powerTime, it will change the color of the "crater"
  println("time:"+powerTime);
  if (powerTime == 0) {
    int blast = 100;
    int dmg = 15;
    for (int i = 0; i < mobs.size(); i++ ) {
      if (temp.distTo(mobs.get(i).getLocation()) <= blast) {
        println(dmg);
        println(temp.distTo(mobs.get(i).getLocation()));
        mobs.get(i).doDamage(dmg);
        mobs.get(i).display();
      }
    }
    powerTime = 5;
  }
  //make animation somehow
}
void speedTower() { //2
  effected = towers.size();
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
    effected = mobs.size();
    for (int i = 0; i < mobs.size(); i++) {
      println(mobs.get(i).getSpeed());
      mobs.get(i).setSpeed(mobs.get(i).getSpeed() / 2);
    }
    powerTime = 5;
    powerChosen = 3;
  }
  
}

void generateMap() {
  titleScreen = false;
  background(dirt);
  stroke(0);
  for (int i = 0;i<mapWidth;i+=tileSize) {
    strokeWeight(3);
    line(i,0,i,mapHeight);
  }
  for (int i = 0;i<mapHeight;i+=tileSize) {
    line(0,i,mapWidth,i);
  }
  displayPath();
  displayTowers();
  strokeWeight(5);
  stroke(255,87,51);
  menu();
}
void initialGenerateMap() {
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
        paths.add(new Location(i,j));
      } else if (i>=tileSize * 4 && j==0) {
        paths.add(new Location(i,j));
      }
    }
  }
  paths.add(4, new Location(tileSize * 3, 100));
  paths.add(5, new Location(tileSize * 3, 0));
  background(dirt);
  displayPath();
  strokeWeight(5);
  stroke(255,87,51);
  endZone = new Location(paths.get(paths.size()-1).getX()+tileSize,paths.get(paths.size()-1).getY());
  line(endZone.getX()+5,endZone.getY(),endZone.getX()+5,endZone.getY()+tileSize);
  menu();
}
boolean outOfBounds(int direction, int r, int c) {
  return (direction==1 && c==0) || (direction==2&&r==7) || (direction==3&&c==7);
}
boolean alreadyOnPath(int x, int y) {
  boolean ans = false;
  for (Location loc : paths) {
    if (x==loc.getX() && y==loc.getY()) ans = true;
  }
  return ans;
}
int randDir(int cannot) {
  int ans = (int)(Math.random()*4)+1;
  while (ans==cannot) {
    ans = (int)(Math.random()*4)+1;
  }
  return ans;
}
void initialRandomMap() {
  print("CAL:LL");
  stroke(0);
  //always start on 0th column and end on last column
  //random start row
  int startj = (int)(Math.random()*mapWidth/tileSize);
  //add in first
  paths.add(new Location(0,startj*tileSize));
  int i = 0; 
  int j = startj;
  while (i!=7) { //while hasnt reached last col
    int direction = randDir(4); //1 up,2 right,3 down, can't go left
    //check for in bounds
    while (outOfBounds(direction,i,j)) {
      direction=randDir(direction);
    }
    //if in bounds then extend map there
    if (direction==1) { //up
      if (!alreadyOnPath(i*tileSize,tileSize*(j-1))) {
        paths.add(new Location(i*tileSize,tileSize*(j-1))); //left
        j--;
      } else continue; //if already on path refind direction
    }
    else if (direction==2) { //right
      if (!alreadyOnPath((i+1)*tileSize,tileSize*j)) {
        paths.add(new Location((i+1)*tileSize,tileSize*j)); //right
        i++;
      } else continue;
    }
    else { //down
      if (!alreadyOnPath(tileSize*i,tileSize*(j+1))) {
        paths.add(new Location(tileSize*i,tileSize*(j+1))); //down
        j++;
      } else continue;
    }
  }
  
  for (int k = 0;k<mapWidth;k+=tileSize) {
    strokeWeight(3);
    line(i,0,i,mapHeight);
  }
  for (int k = 0;k<mapHeight;k+=tileSize) {
    line(0,i,mapWidth,i);
  }
  background(dirt);
  displayPath();
  strokeWeight(5);
  stroke(255,87,51);
  endZone = new Location(paths.get(paths.size()-1).getX()+tileSize,paths.get(paths.size()-1).getY());
  print(endZone);
  line(endZone.getX()+5,endZone.getY(),endZone.getX()+5,endZone.getY()+tileSize);
  menu();
  mobs.add(new Mob(paths.get(0).getX()+tileSize/2,paths.get(0).getY()+tileSize/2)); //first mob at time==0
}

void displayTowers() {
  tint(255); //opaque
  for (Tower tower : towers) {
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
  Location loc = new Location(x,y);
  boolean alreadyTower = false;
  for (Tower tower : towers) {
    if (tower.getLocation().isEqual(loc)) alreadyTower = true;
  }
  if (alreadyTower) {
    pushStyle();
    textSize(20);
    fill(255,255,255);
    text("Already a tower there",x,y);
    popStyle();
    return false;
  }
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
      square(x, y, tileSize);
      balance -= prices.get(selectNum);
      towers.add(new Tower(x, y, selectedTower.getAttack(), selectedTower.getPower(), selectedTower.getRange()));
      menu();
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
    if (powerTime > 0) {
      powerTime--;
      //make drawing of fire here or in draw, mby try to make smooth by putting into draw somehow
    }
  }
  if (time % 120 == 0) {
    if (powerChosen == 0) {
       changeBalance(20);
    }
    else {
      changeBalance(10);
    }
  }
  if (powerTime == 0 && powerChosen != 1) {
    //println("yes");
    if (powerChosen == 2) {//speedtower
      for (int i = 0; i < effected; i++) {
        towers.get(i).setAttack(towers.get(i).getAttack() / 2);
        //have to make sure that they acc revert back to the same thing
      }
    }
    else if (powerChosen == 3) {//slowMob
    //print(effected);
      for (int i = 0; i < effected; i++) {
        mobs.get(i).setSpeed(mobs.get(i).getSpeed() * 2);
        //have to make sure that they acc revert back to the same thing
      }
    }
    else if (powerChosen == 0) {
      reward = reward / 2;
    }
    powerChosen = -1;
  }
}
void draw() {
  if (!titleScreen && !levelScreen) {
  if (time % 240==0 && time>240) {//make a mob every few seconds
    mobs.add(new Mob(paths.get(0).getX()+tileSize/2,paths.get(0).getY()+tileSize/2));
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
      lose();
    }
    if (round <= 0) {
      win();
    }
  }
  for (Tower a : towers) {
    for (Mob b : mobs) {
      if (a.inRange(b.getLocation())) {
        a.laser(b);
        a.attack(b, time);
        break;
      }
    }
  }
  if (powerChosen == 1) {
    fill(255,125,0);
    circle(mouseX, mouseY, 100);
    for (int i = 0; i < mobs.size(); i++) {
      mobs.get(i).display();
    }
  }
  time++;
  tick();
  }
}
void win() {
  textSize(50);
  text("YOU WIN",300,300);
  text("Press any key to restart",250,500);
  if (keyPressed) restart();
}
void lose() {
  textSize(50);
  text("YOU LOSE",300,300);
  text("Press any key to restart",250,500);
  if (keyPressed) restart();
}
void restart() {
  init();
  //mobs.add(new Mob(paths.get(0).getX()+tileSize/2,paths.get(0).getY()+tileSize/2)); //first mob at time==0
}
