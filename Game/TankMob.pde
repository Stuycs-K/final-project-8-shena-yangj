public class TankMob extends Mob {
  private int armor;
  public TankMob () {
    super();
    armor = 10;
  }
  public TankMob(int speed, int health, int x, int y, int armor) {
    super(speed, health, x, y);
    this.armor = armor; 
  }
  public int getArmor() {
    return armor;
  }
  public int changeArmor(int change) {
    armor -= change;
    return armor;
  }
  public void setArmor(int armor) {
    this.armor = armor;
  }
}
