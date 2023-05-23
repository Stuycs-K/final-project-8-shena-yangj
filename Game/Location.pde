//import java.util.*;
public class Location {
  private int xCoordinate;
  private int yCoordinate;
  
  public Location(int x, int y) {
    xCoordinate = ((x / tileSize) * tileSize);
    yCoordinate = ((y / tileSize) * tileSize);
  }
  public int distTo(Location x) {
    int xdist = Math.abs(x.getX() - xCoordinate);
    int ydist = Math.abs(x.getY() - yCoordinate);
    return xdist + ydist;
  }
  public boolean changeLocation(int x, int y) {
    xCoordinate += x;
    yCoordinate += y;
    return true;
  }
  public int getX() {
    return xCoordinate;
  }
  public int getY() {
    return yCoordinate;
  }
  
}
