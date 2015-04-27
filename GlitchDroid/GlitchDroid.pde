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

TCPClient cl;

GlitchSpace[] spaces;
color[] colors = {
  #F0A303, #1BA1E2, #A4C400, #60A917, #647687, #FA6800, #F472D0, #FFFFFF
};

float xTouch[];
float yTouch[];

Point paysageToReal(int x, int y) {
  return new Point(width - y, x);
}

void findSpaces() {
  int indexSpace = 0;  
  for (int i = 0; i < divisions; i++, indexSpace++) {
    spaces[indexSpace] = new GlitchSpace( paysageToReal(height * i/divisions, 0), paysageToReal(height * (i+1)/divisions, width/2));
    spaces[indexSpace].setBackgroundColor(colors[indexSpace]);
    spaces[indexSpace].setNumGlitchSpace(indexSpace);
  }
  for (int i = 0; i < divisions; i++, indexSpace++) {
    spaces[indexSpace] = new GlitchSpace( paysageToReal(height * i/divisions, width/2), paysageToReal(height * (i+1)/divisions, width));  
    spaces[indexSpace].setBackgroundColor(colors[indexSpace]);
    spaces[indexSpace].setNumGlitchSpace(indexSpace);
  }
}

void addMainLines() {
  strokeWeight(3);
  stroke(255);
  for (int i = 1; i < divisions; i++) {
    line(0, height * i/divisions, width, height* i/divisions);
  }

  line(width/2, 0, width/2, height);
}

GlitchSpace getSpaceForCoordonates(int x, int y) {
  for (int i = 0; i < spaces.length; i++)
    if (spaces[i].hasCoord(x, y))
      return spaces[i];

  return null;
}

void setup() {
  setupConstants();
  initMultiTouch();
  programState = STATE_NORMAL;
  spaceInConfiguration = null;

  spaces = new GlitchSpace[8]; 

  orientation(PORTRAIT);

  xTouch = new float[10];
  yTouch = new float[10];

  findSpaces();

  cl = new TCPClient();
  new Thread(cl).start();
}

void drawNormal() {
  for (int i = 0; i < spaces.length; i++)
    if (spaces[i] != null)
      spaces[i].draw();

  addMainLines();
}

void drawConfiguration() {
  spaceInConfiguration.drawConfiguration();
}

void draw() {
  if (programState == STATE_NORMAL) {
    drawNormal();
  } else if (programState == STATE_CONFIGURATION) {
    drawConfiguration();
  }
}

