class Theme{

PShape left, right;
PShape[] mid;
PImage[] barImg;
PImage barImgR,barImgL,backTex;

int w;

public Theme(){
  w = getHPix(10);
  setBarType(save.theme);
}

void paintBar(int y, int lw, int gap){
  randomSeed(lw+gap);
  shape(right,lw-w,y,w,w);
  for(int i= lw-w; i > 0; i-=w){
    shape(mid[randPart()],i-w,y,w,w);
  }
  shape(left,lw+gap,y,w,w);
  for(int i= lw+gap; i < width; i+=w){
    shape(mid[randPart()],i+w,y,w,w);
  }
}

int randPart(){
  if(mid.length > 1 && random(100) > 25){
    return 1+ (int)random(mid.length-1);
  }
  return 0;
}

void loadSettings(int type){
  String[] set;
  try{
     set = loadStrings("gfx/themes/"+type+"/set.txt");
     if(set != null && set.length > 0){
       String[] mode = set[0].split(" ");
       if(mode[0].equals("MULTI")){
         loadBarMid(true,type,Integer.parseInt(mode[1]));
       }else
         loadBarMid(false,type,0);
     } else
       loadBarMid(false,type,0);
  }catch(NullPointerException e){
    loadBarMid(false,type,0);
  }
}

  void loadBarMid(boolean multi, int type, int num){
    if(multi){
      barImg = new PImage[num];
      for(int i=0; i<num;i++){
        barImg[i] = loadImage("gfx/themes/"+type+"/mid/bar_mid"+i+".png");
      }
    }else{
      barImg = new PImage[1];
      barImg[0] = loadImage("gfx/themes/"+type+"/bar_mid.png");
    }
  }

  void setBarType(int type){
    loadSettings(type);
    backTex = loadImage("gfx/themes/"+type+"/bg.png");
    barImgL = loadImage("gfx/themes/"+type+"/bar_left.png");
    barImgR = loadImage("gfx/themes/"+type+"/bar_right.png");
    initBars();
  }

  void initBars(){
    mid = new PShape[barImg.length];
    for(int i=0; i<barImg.length; i++){
      mid[i] = createShape();
      mid[i].beginShape();
      mid[i].noStroke();
      mid[i].texture(barImg[i]);
      mid[i].vertex(0,0,0,0);
      mid[i].vertex(w,0,1,0);
      mid[i].vertex(w,w,1,1);
      mid[i].vertex(0,w,0,1);
      mid[i].endShape();
    }
    left = createShape();
    left.beginShape();
    left.noStroke();
    left.texture(barImgL);
    left.vertex(0,0,0,0);
    left.vertex(w,0,1,0);
    left.vertex(w,w,1,1);
    left.vertex(0,w,0,1);
    left.endShape();
    right = createShape();
    right.beginShape();
    right.noStroke();
    right.texture(barImgR);
    right.vertex(0,0,0,0);
    right.vertex(w,0,1,0);
    right.vertex(w,w,1,1);
    right.vertex(0,w,0,1);
    right.endShape();
  }

}
