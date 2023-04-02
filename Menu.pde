class Menu{

  boolean shown;
  boolean scored=false;
  int lastScore;
  color menubg;

  Button playButton;
  Button optionsButton;
  Button themesButton;
  PImage menuback;

  boolean themeScreenShown, optionScreenShown;
  ThemeScreen themeScreen;
  OptionScreen optionScreen;

  public Menu(){
    shown = true;
    menubg = #42a1f4;
    menuback = loadImage("gfx/menuback.png");
    themeScreenShown = false;
    optionScreenShown = false;
    themeScreen  = new ThemeScreen(this);
    optionScreen = new OptionScreen(this);
    playButton = new Button(getWPix(10),getHPix(40),getWPix(80),getHPix(10),"PLAY");
    themesButton = new Button(getWPix(10),getHPix(65),getWPix(80),getHPix(10), "THEMES");
    optionsButton = new Button(getWPix(10),getHPix(80),getWPix(80),getHPix(10), "OPTIONS");
  }

  void paint(){
    beginShape();
    texture(menuback);
    vertex(0,0,0,0);
    vertex(width,0,1,0);
    vertex(width,height,1,1);
    vertex(0,height,0,1);
    endShape(CLOSE);

    if(themeScreenShown){
      themeScreen.paint();
    }
    else if(optionScreenShown){
      optionScreen.paint();
    }
    else{
      fill(10);
      textSize(getHPix(10));
      text("HISCORE:", getWPix(10), getHPix(10));
      text(save.highscore,getWPix(10), getHPix(20));
      //textSize(64);
      //text("Press anywhere to play" , width/10, height/2);
      if(scored){
        textSize(getHPix(7.5));
        text("You scored:" ,getWPix(10), getHPix(30));
        text(lastScore, getWPix(10), getHPix(37.5));
      }
      playButton.paint();
      textSize(getHPix(7.5));
      text(save.coins, getWPix(85)-powerUpSize-textWidth(""+save.coins), getHPix(60));
      shape(coinShape,getWPix(90)-powerUpSize/2,getHPix(57.5));

      themesButton.paint();
      optionsButton.paint();
    }
  }


  void gameOver(int score){
    scored = true;
    lastScore = score;
    shown = true;
  }

  void pressed(){
    if(!themeScreenShown && !optionScreenShown){
      if(playButton.contains(mouseX,mouseY)){
      game = new Game();
      shown = false;
      return;
      }
      if(themesButton.contains(mouseX, mouseY)){
        themeScreenShown = true;
      }
      if(optionsButton.contains(mouseX, mouseY)){
        optionScreenShown = true;
      }
    }
    else{
      if(themeScreenShown){
        themeScreen.pressed();
      }
      if(optionScreenShown){
        optionScreen.pressed();
      }
    }
  }


}
