class SaveFile {

  int highscore;
  int theme;
  int ball;
  int coins;
  boolean tiltMode;

  public SaveFile(){
    try{
    String[] saveData = loadStrings("saveFile");
    if(saveData == null){
      highscore = 0;
      theme = 0;
      ball = 0;
    }else{
      switch(saveData.length){
        case 5:coins = Integer.parseInt(saveData[4]);
        case 4:tiltMode = Boolean.parseBoolean(saveData[3]);
        case 3:ball = Integer.parseInt(saveData[2]);
        case 2:theme = Integer.parseInt(saveData[1]);
        case 1:highscore = Integer.parseInt(saveData[0]);
      }
    }
    }catch(NullPointerException e){
      highscore = 0;
    }


  }

  public void save(){
    String[] saveData = new String[5]; // !IMPORTANT! CHANGE !IMPORTANT!
    saveData[0] = ""+highscore;
    saveData[1] = ""+theme;
    saveData[2] = ""+ball;
    saveData[3] = ""+tiltMode;
    saveData[4] = ""+coins;
    saveStrings("saveFile",saveData);

  }


}
