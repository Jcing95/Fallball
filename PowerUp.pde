public class PowerUp{

  Game game;
  int x;
  Bar chosen;
  boolean active;

  int type;
  int MAXTYPES = 2;

  public PowerUp(Game game, Bar b){
    this.game = game;
    chosen = b;
    x = 50+(int)random(width-100);
    type = (int)random(MAXTYPES);
    active = true;

  }


void decideType(){
  if (random(100)>75){
    type = 1;
  }
  else type = 0;
}

  void paint(){
    if(active){
      switch(type){
      case 0: shape(coinShape,x,chosen.y+game.yDelta-powerUpSize/2);
      break;
      case 1: shape(ghostShape,x,chosen.y+game.yDelta-powerUpSize/2);
      break;
      }
    }
  }

  boolean contains(int x, int y){
    if(active && new PVector(this.x - x, chosen.y+game.yDelta-powerUpSize/2-y).mag() < powerUpSize){
      active = false;
      trigger();
      return true;
    }
    return false;
  }

  void trigger(){

    switch(type){
    case 0:
    save.coins++;
    game.score += 1000;
    save.save();
    break;
    case 1:
    game.triggerGhostMode();
    break;
    }
  }


}
