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
ArrayList<Tower> towers;
ArrayList<Mob> mobs;
void setup() {
  size(800, 800);
  mapWidth = width;
  mapHeight = height;
  background(148, 114, 70);
  tileSize=100;
  towerPrice = 50;
  generateMap();
  balance = 50;
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
 
boolean placeTower(int x, int y) {
  return true;
}

void tick() {
  changeBalance(10);
}
void draw() {
}
