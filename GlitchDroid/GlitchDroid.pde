/*
*      -----------------------------------
 *      |                                 |
 *      |                                 |
 *      |                                 |   width
 *      |                                 |
 *      -----------------------------------
 *                  height
 */
 
import android.content.res.*;

GlitchSpace[] spaces;
PFont robotoRegular;

TCPClient cl;

Point paysageToReal(int x, int y) {
  return new Point(width - y, x);
}

void setup() {
  setupConstants();
  initMultiTouch();
  programState = STATE_NORMAL;
  spaceInConfiguration = null;
  
  robotoRegular = loadFont("Roboto-Regular.vlw");

  spaces = new GlitchSpace[8]; 

  orientation(PORTRAIT);

  findSpaces();

  cl = new TCPClient();
  new Thread(cl).start();
}

void draw() {
  if (programState == STATE_NORMAL) {
    drawNormal();
  } else if (programState == STATE_CONFIGURATION) {
    drawConfiguration();
  }
}

