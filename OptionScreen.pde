class OptionScreen {

  Button ret;
  Button mode;
  Menu menu;
    public OptionScreen (Menu menu){
      this.menu = menu;

      ret = new Button(getWPix(10),getHPix(80),getWPix(80),getHPix(15), "RETURN");
      mode = new Button(getWPix(10),getHPix(10), getWPix(80), getHPix(15), getMode());
    }

    String getMode(){
      if(save.tiltMode)
        return "TILT";
      return "TOUCH";
    }

    void paint(){
      ret.paint();
      mode.paint();
    }


    void pressed(){
      if(ret.contains(mouseX, mouseY)){
        menu.optionScreenShown = false;
      }
      if(mode.contains(mouseX, mouseY)){
        save.tiltMode = !save.tiltMode;
        save.save();
        mode.label = getMode();
      }
    }



}