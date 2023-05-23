import java.util.*;
private int time;
private int round;
private int health;
private int maxTowers;
private int currentTowers;
private int balance;
private int mapWidth;
private int mapHeight;
private int tileSize;
private ArrayList<Tower> towers;
private ArrayList<Mob> mobs;

void setup() {
  mapWidth = 800;
  mapHeight = 800;
  size(800, 800);
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
  //fill(0,0,0);
  //square(0,0,tileSize);
}
