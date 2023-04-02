class Ball {

  Game game;
  Bar collided;

  int gravity;
  int x,y;
  int size;

  boolean move;
  boolean bottomed;

  float rotDeg;
  float rotSpeed = 10;

  int rLSpeed = getWPix(5);

  PImage ballImg;
  PShape ballShape;

  Ball(Game game){
    this.game = game;
    setBallType(save.ball);
    gravity = game.gravity;
    x = getWPix(50);
    y = 200;
    size = getHPix(5);
    ballShape = createShape();
    ballShape.beginShape();
    ballShape.noStroke();
    ballShape.texture(ballImg);
    ballShape.vertex(-size/2,-size/2,0,0);
    ballShape.vertex(size/2,-size/2,1,0);
    ballShape.vertex(size/2,size/2,1,1);
    ballShape.vertex(-size/2,size/2,0,1);
    ballShape.endShape(CLOSE);
  }

  void setBallType(int type){
    ballImg = loadImage("gfx/balls/ball_"+type+".png");
  }

  void move(){
      for(int i=0; i < gravity; i++){
        if(canMove(x,y + gravity - i + size/2)){
           y += gravity - i;
           break;
        }
      }
    if(!move){
      y = collided.y + game.yDelta - size/2;
    }
  }

  boolean canMove(int x,int y){
    if(game.ghostB){
      move = true;
      return true;
    }
    boolean can = true;
    for(Bar b: game.getBars()){
      if(b.contains(x+size/2,y) || b.contains(x-size/2,y)){
        can = false;
        collided = b;
        break;
      }
    }
    move = can;
    return can;
  }

  int check(int movement){
    if(game.ghostB){
      return 0;
    }
    for(Bar b : game.getBars()){
      b.checkPowerUp(x,y);
      for(int i = 0; i< movement;i++){
        if(b.contains(x, y+i)){
          y = b.y + game.yDelta - size/2;
          return 0;
        }
      }
    }
    return 1;
  }

  void tick(){
      if(tilt == 2 && save.tiltMode || !save.tiltMode && mousePressed && mouseX > width/2){
        if(x+rLSpeed <= width && canMove(x+rLSpeed,y))
          x += rLSpeed;
        rotDeg += rotSpeed;
      }else if(tilt == 0 && save.tiltMode || !save.tiltMode && mousePressed && mouseX < width/2){
        if(x - rLSpeed >= 0 && canMove(x-rLSpeed,y))
          x -= rLSpeed;
        rotDeg -= rotSpeed;
      }

    move();

    if(y < 0){
      game.loose();
      return;
    }

    if(y > height*0.75){
      y = (int)(height*0.75);
      bottomed = true;
    } else {
      bottomed = false;
    }
  }

  void paint(){
    translate(x,y);
    rotate(radians(rotDeg));
    shape(ballShape);
    rotate(-radians(rotDeg));
    translate(-(x),-(y));

  }

}
