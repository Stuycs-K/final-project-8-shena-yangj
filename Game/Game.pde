int time;
int round;
int totalHealth;
int maxTowers;
int currentTowers;
int balance;
int tileSize;
int mapWidth;
int mapHeight;
ArrayList<Tower> towers;
ArrayList<Mob> mobs;
void setup() {
  size(800, 800);
  mapWidth = width;
  mapHeight = height;
  background(148, 114, 70);
  tileSize=100;
  generateMap();
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
import java.util.*; 


void changeBalance(int amount) {
}

boolean placeTower(int x, int y) {
  return true;
  //return true if (x,y) are valid and tower is placed
  //else false
}

void tick() {
}
void draw() {
}
