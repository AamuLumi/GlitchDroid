import ddf.minim.ugens.FilePlayer;
import ddf.minim.Minim;

class MusicPlayer{
  
  private String currentFile;
  private FilePlayer player;
  private boolean isPlaying;
  private Minim minim;
  private Vector<Effect> effects;
  
  public MusicPlayer(String currentFile, Minim minim){
    this.currentFile = currentFile;
    this.player = null;
    this.isPlaying = false;
    this.minim = minim;
    this.effects = new Vector<Effect>();
  }
  
  public MusicPlayer(Minim minim){
    this(null, minim);
  }
  
  public void loadFile(String path){
    if (isPlaying)
      player.close();
    this.currentFile = path;
    ddf.minim.spi.AudioRecordingStream iFileStream = minim.loadFileStream(currentFile, 256, false);
    player = new FilePlayer(iFileStream);
    player.pause();
    player.cue(0);
    println("Sound loaded");
    UGen tmp = player;
    for (Effect e : this.effects)
      tmp = tmp.patch(e.getUGenEffect());
      
    tmp.patch(minim.getLineOut());
  }
  
  public void play(){
    println("Sound started");
    
    player.play();
    isPlaying = true;
  }
  
  public void pause(){
    player.pause();
    isPlaying = false;
  }
  
  public void addEffect(Effect e){
    this.effects.add(e);
  }
  
}
