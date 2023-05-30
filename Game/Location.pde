//import java.util.*;
public class Location {
  private float xCoordinate;
  private float yCoordinate;
  
  public Location(float x, float y) {
    xCoordinate = (((int)x / tileSize) * tileSize);
    yCoordinate = (((int)y / tileSize) * tileSize);
  }
  public Location(float x, float y, boolean isMob) {
    if (isMob) {
      xCoordinate = x;
      yCoordinate = y;
    } else {
      xCoordinate = (((int)x / tileSize) * tileSize);
      yCoordinate = (((int)y / tileSize) * tileSize);
    }
  }
  public float distTo(Location x) {
    float xdist = Math.abs(x.getX() - xCoordinate);
    float ydist = Math.abs(x.getY() - yCoordinate);
    return (float)Math.sqrt(Math.pow(xdist, 2) +  Math.pow(ydist,2));
  }
  public boolean changeLocation(float x, float y) {
    xCoordinate += x;
    yCoordinate += y;
    return true;
  }
  public float getX() {
    return xCoordinate;
  }
  public float getY() {
    return yCoordinate;
  }
  public String toString() {
    return "("+xCoordinate+","+yCoordinate+")";
  }
  public boolean isEqual(Location other) {
    return (other.getX() == xCoordinate && other.getY() == yCoordinate);
  }
  
}
