class ThemeScreen {

  Button ret;
  Button ballB;
  Menu menu;

  PImage ballImg;
  int w, lX, gap;
  int[] barGap, lw;
  int size;


  public ThemeScreen(Menu menu){
    this.menu = menu;
    ret = new Button(getWPix(10),getHPix(80),getWPix(80),getHPix(15), "RETURN");
    ballB = new Button(getWPix(10), getHPix(60), getWPix(80), getHPix(15), "BALL   ");
    w = getHPix(10);
    lX = -10;
    gap = getHPix(100/3.2);
    barGap = new int[5];
    lw = new int[5];
    gen();
    size = getHPix(5);
    setBallType(save.ball);
  }

  void gen(){
    for(int i=0;i<5;i++){
      lw[i] = (int)random(width-size*5);
      barGap[i] = (int)(random(getWPix(50))+size*2.5);
    }
  }

  void setBallType(int type){
    ballImg = loadImage("gfx/balls/ball_"+type+".png");
  }

  void paint(){
    beginShape();
    noStroke();
    texture(theme.backTex);
    vertex(0,0,0,0);
    vertex(width,0,width/theme.backTex.width,0);
    vertex(width,height,width/theme.backTex.width,height/theme.backTex.height);
    vertex(0,height,0,height/theme.backTex.height);
    endShape(CLOSE);

    for(int i= 0; i< 5; i++){
      theme.paintBar(i*gap, lw[i], barGap[i]);
    }

    ballB.paint();
    translate(getWPix(75),getHPix(67.5));
    beginShape();
    noStroke();
    texture(ballImg);
    vertex(-size/2,-size/2,0,0);
    vertex(size/2,-size/2,1,0);
    vertex(size/2,size/2,1,1);
    vertex(-size/2,size/2,0,1);
    endShape(CLOSE);

    translate(-getWPix(75),-getHPix(67.5));
    ret.paint();
    textSize(getHPix(7.5));
    noStroke();
    fill(255,100);
    rect(0,getHPix(15),width,getHPix(10));
    fill(0);
    text("Tap to change!" ,getWPix(10), getHPix(22.5));
  }

  void pressed(){
    if(ret.contains(mouseX, mouseY)){
      menu.themeScreenShown = false;
    }else if(ballB.contains(mouseX,mouseY)){
      save.ball ++;
      if(save.ball >= maxBalls){
        save.ball = 0;
      }
      setBallType(save.ball);
      save.save();
    }else{
      save.theme++;
      if(save.theme >= maxWorlds){
        save.theme = 0;
      }
      theme.setBarType(save.theme);
      save.save();
      gen();
    }
  }


}
