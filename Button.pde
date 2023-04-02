class Button{

  int x, y;

  int w,h;

  String label;

  color back,highlight, text, stroke;
  float scale;
  int size;

  PImage BUTTON_BACK = loadImage("gfx/buttonback.png");

  public Button(int x, int y, int w, int h, String label){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    scale = 1;
    size = (int)(h * 0.6);
    back = color(#ededff,125);
    highlight = color(255,50);
    text = color(0);
    stroke = color(104, 216, 166,200);
  }


  void paint(){

    if(contains(mouseX,mouseY))
    fill(highlight);
    else
    noFill();
    textSize(size);
    translate(x,y);
    scale(scale);
    stroke(stroke);
    beginShape();
    texture(BUTTON_BACK);
    vertex(0,0,0,0);
    vertex(w,0,1,0);
    vertex(w,h,1,1);
    vertex(0,h,0,1);
    endShape(CLOSE);
    rect(0,0,w,h);
    fill(text);
    text(label,(w-textWidth(label))/2,h-(h-0.6*(textAscent()+textDescent()))/2);
    scale(1/scale);
    translate(-x,-y);

  }

  boolean contains(int x, int y){
    return (this.y < y && this.y+h*scale > y && this.x < x && this.x+w*scale > x);
  }

}
