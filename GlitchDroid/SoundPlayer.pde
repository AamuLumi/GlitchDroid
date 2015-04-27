class SoundPlayer {

  private android.media.MediaPlayer mp;

  public SoundPlayer() {
    mp = new android.media.MediaPlayer();

    try {
      AssetFileDescriptor fd = getAssets().openFd("test.mp3");
      mp.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
      mp.prepare();
    } 
    catch(IOException e) {
      e.printStackTrace();
    }
  }
  
  public void play(){
    mp.start();
  }
  
  public void pause(){
    mp.pause();
  }
  
  public void stop(){
    mp.stop();
  }
}

