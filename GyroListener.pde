class GyroListener implements SensorEventListener {

  public void onSensorChanged(SensorEvent event) {
      float ax = event.values[0];
      if(abs(ax) > 0.25){
        if(ax > 0.25)
          tilt = 0;
        else
          tilt = 2;
      }else{
        tilt = 1;
      }
    }

    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }

}
