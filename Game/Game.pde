import java.util.*; 
int time;
int round;
int totalHealth;
int maxTowers;
int currentTowers;
int balance;
int tileSize;
int mapWidth;
int mapHeight;
int towerPrice;
boolean selected;

ArrayList<Tower> towers;
ArrayList<Mob> mobs;
void setup() {
  size(1000, 800);
  tileSize=100;
  mapWidth = width-tileSize*2;
  mapHeight = height;
  background(148, 114, 70);
  towerPrice = 50;
  generateMap();
  balance = 50;
  menu();
}
void menu() {
  stroke(0);
  fill(146,152,255);
  rect(mapWidth,0,mapWidth,mapHeight);
  fill(144,10,255);
  rect(mapWidth + 20, 10, tileSize + 60, tileSize);
  if (mouseX >= mapWidth + 20 && mouseX <= (mapWidth + tileSize + 80) && mouseY >= 10 && mouseY <= 10 + tileSize) {
    stroke(200);
    rect(mapWidth + 20, 10, tileSize + 60, tileSize);
  }
}
void mouseClicked() {
  fill(144,10,255);
  if (mouseX >= mapWidth + 20 && mouseX <= (mapWidth + tileSize + 80) && mouseY >= 10 && mouseY <= 10 + tileSize) {
    stroke(200);
    fill(100,20,200);
    rect(mapWidth + 20, 10, tileSize + 60, tileSize);
    selected = true;
  }
    
}
void generateMap() {
  for (int i = 0;i<mapWidth;i+=100) {
    strokeWeight(3);
    line(i,0,i,mapHeight);
  }
  for (int i = 0;i<mapHeight;i+=100) {
    line(0,i,mapWidth,i);
  }
  fill(60, 201, 70);
  for (int i = 0;i<mapWidth;i+=tileSize) {
    for (int j = 0;j<mapHeight;j+=tileSize) {
      if (j==tileSize*2 && i<mapHeight/2) {
        square(i,j,tileSize);
      } else if (i==tileSize*3 && (j>=tileSize*3 && j<=tileSize*5)) {
        square(i,j,tileSize);
      } else if (i>=tileSize*4 && j==tileSize*5) {
        square(i,j,tileSize);
      }
    }
  }
}


void changeBalance(int amount) {
  balance += amount;
}

//testing placeTower
void mousePressed() {
  if (mouseX <= mapWidth && selected) {
    placeTower(mouseX, mouseY);
    selected = false;
    menu();
  }
}
boolean placeTower(int x, int y) {
  if (x >= 0 && x < mapWidth && y >= 0 && y < mapHeight) {
    if (balance >= towerPrice) {
      x = (x / tileSize) * tileSize;
      y = (y / tileSize) * tileSize;
      fill(255,0,0);
      square(x, y, tileSize);
      balance -= towerPrice;
      //check for path somehow
      //draw somewhere a error msg like "not enough money"
      return true;
    }
    else {
      String display = "Not Enough Money";
      text(display, 40, 100);
      //figure out a way to make text not stay forever
    }
  }
  return false;
  //return true if (x,y) are valid and tower is placed
  //also check if have enough money
  //else false
}

void tick() {
  changeBalance(10);
}
void draw() {
}
