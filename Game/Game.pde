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
boolean gameOver;
Location endZone;
ArrayList<Integer> prices;
Tower selectedTower;
boolean selected;
ArrayList<Tower> selects;
ArrayList<Tower> towers;
ArrayList<Mob> mobs;
ArrayList<Location> paths;
void setup() {
  size(1000, 800);
  tileSize=100;
  mapWidth = width-200;
  mapHeight = height;
  background(148, 114, 70);
  time=0;
  round = 100;
  gameOver = false;
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
  }
  if (mouseX <= mapWidth && selected && towers.size() < maxTowers) {
    placeTower(mouseX, mouseY);
    selected = false;
    menu();
  }
    
}
void generateMap() {
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
      //} else if (i==tileSize*3 && (j>=tileSize*3 && j<=tileSize*5)) {
      //  square(i,j,tileSize);
      //} else if (i>=tileSize*4 && j==tileSize*5) {
      //  square(i,j,tileSize);
      //}
    }
  }
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
      } else if (i==tileSize * 3 ) {
        for (int w = 200; w >= 0;w -= tileSize) {
          square(i,w,tileSize);
          paths.add(new Location(i, w));
        }
      } else if (i>=tileSize * 4 && j==0) {
        square(i,j,tileSize);
        paths.add(new Location(i,j));
      }
      //} else if (i==tileSize*3 && (j>=tileSize*3 && j<=tileSize*5)) {
      //  square(i,j,tileSize);
      //  paths.add(new Location(i,j));
      //} else if (i>=tileSize*4 && j==tileSize*5) {
      //  square(i,j,tileSize);
      //  paths.add(new Location(i,j));
      //}
    }
  }
}


void changeBalance(int amount) {
  balance += amount;
}

boolean placeTower(int x, int y) {
  if (x >= 0 && x < mapWidth && y >= 0 && y < mapHeight) {
    if (balance >= prices.get(selectNum)) {
      x = (x / tileSize) * tileSize;
      y = (y / tileSize) * tileSize;
      fill(255,0,0);
      square(x, y, tileSize);
      balance -= prices.get(selectNum);
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
  if (time % 60 == 0) {
    round--;
  }
  if (time % 120 == 0) {
    changeBalance(10);
  }
}
void draw() {
  menu();
  //if (time % 240==0) {//make a mob every few seconds
  if (time==0) {
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
  if ((time % 30)== 2) {
    generateMap();
    for (int i = 0;i<mobs.size();i++) {
      if (mobs.get(i).getLocation().getX()>= endZone.getX()) {
        mobs.remove(i);
        if (i < mobs.size()) {
          mobs.get(i).move(paths,mapWidth,mapHeight,tileSize, paths.size());
          mobs.get(i).display();
        }
        //+ mobs.get(i).getRadius()
        totalHealth-=mobs.get(i).getAttackPower();
        println("totalHealth: "+totalHealth);
        continue; //continue w/ next mob since otherwise will run rest of method too
      }
      if (totalHealth<=0) {
        gameOver = true;
        break;
      }
      mobs.get(i).move(paths,mapWidth,mapHeight,tileSize, paths.size());
      mobs.get(i).display();
    }
    if (gameOver) {
      print("YOU LOSE");
      delay(2000);
      exit();
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
