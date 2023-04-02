class Coin{


  Game game;
  int x;
  Bar chosen;
  boolean active;


  public Coin(Game game, Bar b){
    this.game = game;
    chosen = b;
    x = 50+(int)random(width-100);
    active = true;

  }


  void paint(){
    if(active){
      shape(coinShape,x,chosen.y+game.yDelta-powerUpSize/2);
    }
  }

  boolean contains(int x, int y){
    if(active && new PVector(this.x - x, chosen.y+game.yDelta-powerUpSize/2-y).mag() < powerUpSize){
      active = false;
      save.coins++;
      game.score += 1000;
      save.save();
      return true;
    }
    return false;
  }


}
