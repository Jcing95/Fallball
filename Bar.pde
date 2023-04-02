class Bar{

  int lw;
  int weight;
  int gap;
  int y;

  int gc,bc;

  int id;

  int previous;

  Game game;

  boolean powerUpB;

  PowerUp powerUp;


  Bar(int id, int previous, Game game){
    this.id = id;
    this.previous = previous;
    this.game = game;
    //setBarType((int)random(maxWorlds));
    weight = getHPix(10);
    gen();
    gc = 120;
    bc = 10;

  }

  void paint(){
    if(y+game.yDelta < -100)
      gen();
    theme.paintBar(y+game.yDelta,lw,gap);
    if(powerUpB)
      powerUp.paint();
  }

  void gen(){
    if(game.bars[previous] == null)
      y = height+game.BARGAP;
    else
      y = game.bars[previous].y+game.BARGAP+(int)random(getHPix(15));
    lw = (int)random(width-game.ball.size*5);
    gap = (int)(random(getWPix(50))+game.ball.size*2.5);
    checkPowerUpGen();
  }

  void checkPowerUpGen(){
    if(random(100)>85){
      powerUpB = true;
      powerUp = new PowerUp(game,this);
    }else
    powerUpB = false;
  }


  void checkPowerUp(int x, int y){
    if(powerUpB){
      powerUp.contains(x,y);
    }
  }

  boolean contains(int x, int y){
    return (y >= this.y+game.yDelta &&
      y <= this.y+weight+game.yDelta) &&
      !(lw < x && lw+gap > x);
  }

}
