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
  public int doDamage(int change) {
    double percent = armor / 100.0;
    if (super.health > 0) {
      if (change * percent > super.health) {
        int ret = super.health;
        super.health = 0;
      }
      else {
        super.health -= (change * percent);
      }
    }
  }
    //shld do armor mob to test
}
