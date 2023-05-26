import java.util.*; 
int time;
int round;
int totalHealth;
int maxTowers;
int balance;
int tileSize;
int mapWidth;
int mapHeight;
int towerPrice;
int selectNum;
//arraylist of towerPrices?
Tower selectedTower;
boolean selected;
ArrayList<Tower> towers;
ArrayList<Mob> mobs;
ArrayList<Location> paths;
void setup() {
  size(1000, 800);
  tileSize=100;
  mapWidth = width-200;
  mapHeight = height;
  background(148, 114, 70);
  towerPrice = 50;
  time=0;
  mobs = new ArrayList<Mob>();
  towers = new ArrayList<Tower>();
  //path = new ArrayList<Location>();
  generateMap();
  balance = 50;
  selected = false;
  totalHealth = 100;
  maxTowers = 10;
  towers = new ArrayList<Tower>();
  mobs = new ArrayList<Mob>();
  //
  menu();
  mobs.add(new Mob());
  selectNum = -1;
}
void menu() {
  textSize(25);
  stroke(0);
  fill(146,152,255);
  rect(mapWidth + 1,0,mapWidth,mapHeight);
  for (int i = 0; i < 4; i++) {
    fill(144,10,255);
    rect(mapWidth + 21, 10 + (100 * i), 100 + 60, 100);
    fill(255,0,0);
    text(towerPrice, mapWidth + 23, 30 + (100 * i));
  }
  if (selectNum >= 0) {
    stroke(200);
    fill(144,10,255);
    rect(mapWidth + 21, 10 + (100 * selectNum), 100 + 60, 100);
    fill(255,0,0);
    text(towerPrice, mapWidth + 23, 30 + (100 * selectNum));
    stroke(0);
  }
  text("Towers: " + towers.size() + "/" + maxTowers, mapWidth + 21, mapHeight - 20);
  text("Mob count: " + mobs.size(), mapWidth + 21, mapHeight - 50);
  text("Balance: " + balance, mapWidth + 21, mapHeight - 80);
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
        text(towerPrice, mapWidth + 23, 30 + (100 * i));
        selectedTower = new Tower(0, 0);
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
void generateMap() {
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
      } else if (i==tileSize*3 && (j>=tileSize*3 && j<=tileSize*5)) {
        square(i,j,tileSize);
        paths.add(new Location(i,j));
      } else if (i>=tileSize*4 && j==tileSize*5) {
        square(i,j,tileSize);
        paths.add(new Location(i,j));
      }
    }
  }
}


void changeBalance(int amount) {
  balance += amount;
}

boolean placeTower(int x, int y) {
  if (x >= 0 && x < mapWidth && y >= 0 && y < mapHeight) {
    if (balance >= towerPrice) {
      x = (x / tileSize) * tileSize;
      y = (y / tileSize) * tileSize;
      fill(255,0,0);
      square(x, y, tileSize);
      balance -= towerPrice;
      selectedTower.setPosition(x, y);
      towers.add(selectedTower);
      menu();
      //check for path somehow
      //draw somewhere a error msg like "not enough money"
      selectNum = -1;
      return true;
    }
    else {
      String display = "Not Enough Money";
      fill(255,0,0);
      text(display, mapWidth + 23, mapHeight - 100);
      menu();
      //figure out a way to make text not stay forever
      selectNum = -1;
    }
  }
  return false;
  //return true if (x,y) are valid and tower is placed
  //also check if have enough money
  //else false
}

void tick() {
  menu();
  if (time % 120 == 0) {
    changeBalance(10);
  }
}
void draw() {
  if (time % 240==0) {//make a mob every few seconds
    mobs.add(new Mob(50,250));
  }
  if ((time % 30)== 2) {
    generateMap();
    for (int i = 0;i<mobs.size();i++) {
      if (mobs.get(i).getLocation().getX() >= mapWidth || mobs.get(i).getLocation().getY()>=mapHeight) {
        print("YOU LOSE");
        delay(2000);
        exit(); //change this to give option to restart
      }
      println("mobs size: "+mobs.size());
      print("i: "+i);
      mobs.get(i).move(paths,mapWidth,mapHeight,tileSize, paths.size()-1);
      mobs.get(i).display();
    }
  }
  time++;
  tick();
}
