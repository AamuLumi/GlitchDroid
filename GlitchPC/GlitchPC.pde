import java.text.DecimalFormat;
import java.text.NumberFormat;
import javax.swing.JFileChooser;
import ddf.minim.*;
import ddf.minim.ugens.*;

NetworkServer ns;
PFont robotoThin, robotoRegular;
final JFileChooser fc = new JFileChooser();

Minim minim;
MusicPlayer mp;

NumberFormat doubleFormatter;

Effect[] effects;

void setup() {
  println("Starting");
  size(640, 480);  

  robotoThin = loadFont("Roboto-Thin.vlw");
  robotoRegular = loadFont("Roboto-Regular.vlw");

  doubleFormatter = new DecimalFormat("#0.00");     

  minim = new Minim(this);
  mp = new MusicPlayer(minim);

  ns = new NetworkServer();
  ns.waitController();
  
  defineEffects();
}

void draw() {
  noStroke();
  fill(#FFFFFF);
  rect(0, 0, width, height);

  drawCommandBar();

  drawEffects();
}

void mouseClicked() {
  if (isOnButtonPlay(mouseX, mouseY)) {
    mp.play();
  } else if (isOnButtonPause(mouseX, mouseY)) {
    mp.pause();
  } else if (isOnButtonLoad(mouseX, mouseY)) {
    int returnVal = fc.showOpenDialog(this);
    if (returnVal == JFileChooser.APPROVE_OPTION) {
      mp.loadFile(fc.getSelectedFile().getAbsolutePath());
    }
  }
}
