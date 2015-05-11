void drawNormal() {
  for (int i = 0; i < spaces.length; i++)
    if (spaces[i] != null)
      spaces[i].draw();

  addMainLines();
}

void drawConfiguration() {
  spaceInConfiguration.drawConfiguration();
}

void addMainLines() {
  strokeWeight(3);
  stroke(255);
  for (int i = 1; i < divisions; i++) {
    line(0, height * i/divisions, width, height* i/divisions);
  }

  line(width/2, 0, width/2, height);
}
