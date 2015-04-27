import java.text.DecimalFormat;
import java.text.NumberFormat;

NetworkServer ns;
PFont robotoThin, robotoRegular;

NumberFormat doubleFormatter;

Effect[] effects;

void setup() {
  println("Starting");
  size(640, 480);  

  robotoThin = loadFont("Roboto-Thin.vlw");
  robotoRegular = loadFont("Roboto-Regular.vlw");
  
  doubleFormatter = new DecimalFormat("#0.00");     

  ns = new NetworkServer();
  ns.waitController();

  effects = new Effect[8];
  for (int i = 0; i < 8; i++) {
    effects[i] = new Effect("MyEffect");
    effects[i].addParameter("p1", 0, 100, 50);
    effects[i].setActiveParameterX("p1");
    effects[i].addParameter("p2", 0, 100, 50);
    effects[i].setActiveParameterY("p2");
  }
}

void draw() {
  noStroke();
  fill(#FFFFFF);
  rect(0, 0, width, height);
  
  drawButtonPause();
  drawButtonPlay();
  drawButtonLoad();

  drawEffects();
}

