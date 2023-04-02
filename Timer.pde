class Timer extends Thread{

  boolean running=true;
  int lastTime;


  int TPS = 60;
  Game game;

  public Timer(Game game){
    this.game = game;
    lastTime = millis();
  }

  void run(){
    while(running){
      if(millis()-lastTime >= 1000/TPS){
        lastTime = millis();
        game.tick();
      }
    }
  }


}
