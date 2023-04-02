  import android.content.Context;
  import android.hardware.Sensor;
  import android.hardware.SensorManager;
  import android.hardware.SensorEvent;
  import android.hardware.SensorEventListener;

  Context context;
  SensorManager manager;
  Sensor sensor;
  GyroListener listener;

  int tilt; // 0 = left, 1 = no, 2 = right;

  Game game;
  Menu menu;
  SaveFile save;
  PFont font;
  color bg;
  int numPointers;

  int maxBalls, maxWorlds;
  Theme theme;

  boolean pressed;

  PImage coinIMG, ghostIMG;
  PShape coinShape, ghostShape;


  int powerUpSize;

  void setup(){
    print("initializing...");
    fullScreen(P2D);
    orientation(PORTRAIT);
    frameRate(60);
    print("fullscreen toggled...");
    save = new SaveFile();
    //save.highscore =0;
    maxBalls = Integer.parseInt(loadStrings("count.txt")[0]);
    maxWorlds = Integer.parseInt(loadStrings("count.txt")[1]);
    println("save loaded...");
    initGraphics();
    println("graphics initialized...");

    context = getActivity();
    manager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);
    sensor = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
    listener = new GyroListener();
    manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_GAME);
    println("Sensor initialized...");

    menu = new Menu();
    println("showing menu...");
  }

  void initGraphics(){
    font = createFont("Verdana-Bold",128);
    textFont(font);
    textureMode(NORMAL);
    textureWrap(REPEAT);
    hint(DISABLE_OPTIMIZED_STROKE);
    theme = new Theme();
    powerUpSize = getHPix(7.5);
    coinIMG = loadImage("gfx/coin.png");
    ghostIMG = loadImage("gfx/ghost.png");

    initShapes();
  }


  void initShapes(){
    coinShape = createShape();
    coinShape.beginShape();
    coinShape.noStroke();
    coinShape.texture(coinIMG);
    coinShape.vertex(-powerUpSize/2,-powerUpSize/2,0,0);
    coinShape.vertex(powerUpSize/2,-powerUpSize/2,1,0);
    coinShape.vertex(powerUpSize/2,powerUpSize/2,1,1);
    coinShape.vertex(-powerUpSize/2,powerUpSize/2,0,1);
    coinShape.endShape(CLOSE);

    ghostShape = createShape();
    ghostShape.beginShape();
    ghostShape.noStroke();
    ghostShape.texture(ghostIMG);
    ghostShape.vertex(-powerUpSize/2,-powerUpSize/2,0,0);
    ghostShape.vertex(powerUpSize/2,-powerUpSize/2,1,0);
    ghostShape.vertex(powerUpSize/2,powerUpSize/2,1,1);
    ghostShape.vertex(-powerUpSize/2,powerUpSize/2,0,1);
    ghostShape.endShape(CLOSE);
  }

  void draw(){
    if(menu.shown){
      menu.paint();
    }
    else{
      game.paint();
    }
    textSize(16);
  }

  public void onResume() {
    super.onResume();
    if (manager != null && game != null) {
      manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_GAME);
    }
  }

  public void onPause() {
    super.onPause();
    if (manager != null && game != null) {
      manager.unregisterListener(listener);
    }
  }

  void mousePressed(){
    pressed = true;
    if(game != null){
      game.pressed();
    }
  }

  void mouseReleased(){
    if(pressed){
      pressed = false;
      if(menu.shown)
        menu.pressed();
    }
  }

  void mouseMoved(){

  }



  int getWPix(float px){
    return (int)(width/100*px);
  }

  int getHPix(float px){
    return (int)(height/100*px);
  }
