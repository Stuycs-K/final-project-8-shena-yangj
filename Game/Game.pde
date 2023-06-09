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
PImage towerimg;
boolean gameOver;
PImage dirt;
Location endZone;
ArrayList<Integer> prices;
Tower selectedTower;
PImage grass;
boolean selected;
ArrayList<Tower> selects;
ArrayList<Tower> towers;
ArrayList<Mob> mobs;
ArrayList<Location> paths;
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
  if (selectNum >= 0) {
    stroke(200);
    fill(144,10,255);
    rect(mapWidth + 21, 10 + (100 * selectNum), 100 + 60, 100);
    fill(255,0,0);
    text("Price: " + prices.get(selectNum), mapWidth + 23, 30 + (100 * selectNum));
    text("AttackSpeed: " + selects.get(selectNum).getAttack(), mapWidth + 23, 50 + (100 * selectNum));
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
  strokeWeight(3);
  stroke(255,0,0);
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
  fill(144,10,255);
  if (mouseX >= mapWidth + 20 && mouseX <= (mapWidth + 100 + 80)) {
    for (int i = 0; i < 4; i++) {
      if (mouseY >= 10 + (100 * i) && mouseY <= 110 + (100 * i)) {
        stroke(200);
        fill(144,10,255);
        rect(mapWidth + 21, 10 + (100 * i), 100 + 60, 100);
        fill(255,0,0);
        text("Price: " + prices.get(i), mapWidth + 23, 30 + (100 * i));
        text("AttackSpeed: " + selects.get(i).getAttack(), mapWidth + 23, 50 + (100 * i));
        text("Power: " + selects.get(i).getPower(), mapWidth + 23, 70 + (100 * i));
        selectedTower = selects.get(i);
        selected = true;
        selectNum = i;
      }
    }
  }
  if (mouseX <= mapWidth && selected && towers.size() < maxTowers) {
    placeTower(mouseX, mouseY);
    selected = false;
    menu();
  }
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
  }
  if (time % 120 == 0) {
    changeBalance(10);
  }
}
void draw() {
  if (!titleScreen && !levelScreen) {
  if (time % 240==0) {//make a mob every few seconds
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
      lose();
    }
    if (round <= 0) {
      win();
    }
  }
  for (Tower a : towers) {
    for (Mob b : mobs) {
      a.attack(b, time);
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
  mobs.add(new Mob(50,250)); //first mob at time==0
}
