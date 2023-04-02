
class Game {

  float YSPEED;
  int BARGAP;

  Timer timer;
  Bar[] bars;
  Ball ball;

  int yDelta;
  int gravity = getHPix(2);

  int score;
  int speedUpCounter;

  int ghostStartTime;
  boolean ghostB;
  int ghostLastSpeed;
  int ghostCounter;
  int GHOSTTIME = 3500;


  Game(){
    YSPEED = getHPix(0.125);
    BARGAP = (int)(height/3.2);

    ball = new Ball(this);
    bars = new Bar[5];
    bars[0] = new Bar(1, bars.length-1,this);
    for(int i=0; i<bars.length-1;i++){
      bars[i+1] = new Bar(i+2, i,this);
    }

    timer = new Timer(this);
    timer.start();
    if (manager != null) {
      manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_GAME);
    }
  }

  void paint(){
    beginShape();
    texture(theme.backTex);
    vertex(0,0,0,0);
    vertex(width,0,width/theme.backTex.width,0);
    vertex(width,height,width/theme.backTex.width,height/theme.backTex.height);
    vertex(0,height,0,height/theme.backTex.height);
    endShape(CLOSE);
    for(Bar b: bars){
      b.paint();
    }

    fill(0,0,0,100);
    noStroke();
    rect(0,0,width,getHPix(10));
    fill(225);
    textSize(getHPix(5));
    text(score, width-textWidth(""+score) - getWPix(2.5), getHPix(7));
    text(save.coins, getWPix(2.5), getHPix(7));
    shape(coinShape, getWPix(2.5) + textWidth(" "+save.coins) + getHPix(2.5),getHPix(5),getHPix(5),getHPix(5));
    textSize(26);
    fill(255,255,0);
    text(frameRate, getWPix(2.5),50);
    if(ghostB){
      fill(129, 201, 249, 100);
      rect(0,0,width,height);
      textSize(getHPix(10));
      text(""+ghostCounter, getWPix(10) + (getWPix(40)-textWidth(""+ghostCounter)/2), getHPix(50));
    }
    ball.paint();
  }

  void tick(){
    ball.tick();
    score += speedUpCounter;


    if(ball.bottomed || ghostB){
      ball.check(gravity);
      yDelta -= gravity;
      score += speedUpCounter/2;
    } else {
      ball.check((int)YSPEED);
      yDelta -= YSPEED;
    }

    speedUpCounter++;
    if(speedUpCounter > 100){
      speedUpCounter = 0;
      speedUp();
    }

    if(ghostB){
      score+= ghostCounter;
      if(millis() - ghostStartTime > GHOSTTIME){
        endGhostMode();
      }
    }
  }

  void pressed(){
    if(ghostB){
      ghostCounter++;
      gravity *= 1.1;
    }
  }

  void triggerGhostMode(){
    ghostStartTime = millis();
    ghostB = true;
    ghostLastSpeed = gravity;

  }

  void endGhostMode(){
    ghostB = false;
    gravity = ghostLastSpeed;
    ghostCounter = 0;
  }

  void speedUp(){
    if(!ghostB){
     YSPEED+=0.5;
     BARGAP+= height/750;
    }
  }

  void loose(){
    println("lost!");
    if(score > save.highscore){
      println("new highscore: " + score);
      save.highscore = score;
      save.save();
    }
    print("score: " + score);
    menu.gameOver(score);
    end();
  }

  void end(){
    timer.running = false;
    if (manager != null && game != null) {
      manager.unregisterListener(listener);
    }
    try{
      timer.join();
    } catch(InterruptedException e){
        e.printStackTrace();
    }
    timer = null;
    bars = null;
    ball = null;
  }

  Bar[] getBars(){
    return bars;
  }

}
