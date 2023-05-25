public class AOETower extends Tower {
  private int effectedArea;
  //size length of the square of its effectedarea
  public AOETower(int x, int y){
    super(x, y);
    effectedArea = 3;
  }
  public AOETower(int x, int y, int attackSpeed, int power, int range, int effectedArea) {
    super(x, y, attackSpeed, power, range);
    this.effectedArea = effectedArea;
  }
  public int breakArmor(TankMob a, int damage) {
     a.changeArmor(damage);
  }
}
