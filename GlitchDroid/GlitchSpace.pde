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

GlitchSpace getSpaceForCoordonates(int x, int y) {
  for (int i = 0; i < spaces.length; i++)
    if (spaces[i].hasCoord(x, y))
      return spaces[i];

  return null;
}

class GlitchSpace {

  int x1, y1, x2, y2;

  private Point pointer;

  private color bg;
  private boolean activated;

  private byte numberInputs;
  private int numGlitchSpace;

  private double minX, maxX, minY, maxY;

  public GlitchSpace(int x1, int y1, int x2, int y2) {
    if (x1 < x2) {
      this.x1 = x1;
      this.x2 = x2;
    } else {
      this.x1 = x2;
      this.x2 = x1;
    }

    if (y1 < y2) {
      this.y1 = y1;
      this.y2 = y2;
    } else {
      this.y1 = y2;
      this.y2 = y1;
    }

    this.pointer = new Point((x1+x2)/2, (y1+y2)/2);

    bg = #FFFFFF;
    activated = false;
    numberInputs = 0;
    numGlitchSpace = 0;
    minX = 0;
    maxX = 100;
    minY = 0;
    maxY = 100;
  }


  // Why X and Y are switched ?
  // Because value is calculated in initial phone geometrical plan
  public double getValueY() {
    return (pointer.getX() - x1)/(double)(x2 - x1) * (maxX - minX);
  }

  public double getValueX() {
    return (pointer.getY() - y1)/(double)(y2 - y1) * (maxY - minY);
  }

  public void setMinX(double min) {
    this.minX = min;
  }

  public void setMaxX(double max) {
    this.maxX = max;
  }

  public void setMinY(double min) {
    this.minY = min;
  }

  public void setMaxY(double max) {
    this.maxY = max;
  }

  public GlitchSpace(Point p1, Point p2) {
    this(p1.getX(), p1.getY(), p2.getX(), p2.getY());
  }

  public boolean hasCoord(int x, int y) {
    return (x > x1) && (x < x2) && (y > y1) && (y < y2);
  }

  public void setBackgroundColor(color c) {
    println(c);
    this.bg = c;
  }

  public int getNumGlitchSpace() {
    return this.numGlitchSpace;
  }

  public void setNumGlitchSpace(int i) {
    this.numGlitchSpace = i;
  }

  public Point getPointer() {
    return pointer;
  }

  public void setPointer(Point p) {
    if (p.getX() < x1)
      p.setX(x1);
    else if (p.getX() > x2)
      p.setX(x2);
    
    if (p.getY() < y1)
      p.setY(y1);
    else if (p.getY() > y2)
      p.setY(y2);
    this.pointer = p;
  }

  public void switchActivate() {
    this.activated = !this.activated;
  }

  public boolean isActivated() {
    return this.activated;
  }

  public void addInput() {
    this.numberInputs++;
  }

  public void removeInput() {
    this.numberInputs--;
  }

  public byte getNumberInputs() {
    return this.numberInputs;
  }

  public void showConfiguration() {
    spaceInConfiguration = this;
  }

  public boolean isOnPointer(int x, int y) {
    return (x > pointer.getX() - (PointerSize + PointerPrecision)) && 
      (x < pointer.getX() + (PointerSize + PointerPrecision)) &&
      (y > pointer.getY() - (PointerSize + PointerPrecision)) &&
      (y < pointer.getY() + (PointerSize + PointerPrecision));
  }

  public boolean isOnSaveRect(int x, int y) {
    return (x > beginningConfigurationSaveRectX) &&
      (x < endConfigurationSaveRectX) &&
      (y < beginningConfigurationSaveRectY) &&
      (y > endConfigurationSaveRectY);
  }

  public void draw() {
    noStroke();
    if (activated)
      fill(bg);
    else
      fill(#666666);
    rectMode(CORNERS);
    rect(x1, y1, x2, y2);

    strokeWeight(1);
    stroke(200);
    line(x1, (y1+y2)/2, x2, (y1+y2)/2);
    line((x1+x2)/2, y1, (x1+x2)/2, y2);

    fill(#FFFFFF);
    ellipse(pointer.getX(), pointer.getY(), PointerSize, PointerSize);
  }

  public void drawConfiguration() {
    fill(#FFFFFF);
    rectMode(CORNER);
    rect(0, 0, width, height);

    fill(bg);
    rectMode(CORNERS);
    Point beg = paysageToReal(beginningConfigurationSaveRectX, beginningConfigurationSaveRectY);
    Point end = paysageToReal(endConfigurationSaveRectX, endConfigurationSaveRectY);
    rect(beg.getX(), beg.getY(), end.getX(), end.getY());
  }
}

