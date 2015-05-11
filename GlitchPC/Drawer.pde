void drawCommandBarBackground() {
  fill(commandBarBackground);
  rect(0, 0, width, commandBarY*2 + buttonPlayDY);
  
  fill(#000000);
  rect(0, commandBarY*2 + buttonPlayDY, width, 3);
}

void drawButtonPause() {
  noStroke();
  fill(mainColor);
  rectMode(CORNER);
  rect(buttonPauseX, buttonPauseY, buttonPauseDX/2 - 4, buttonPauseDY);
  rect(buttonPauseX + buttonPauseDX/2 + 4, buttonPauseY, buttonPauseDX/2 - 4, buttonPauseDY);
}

void drawButtonPlay() {
  noStroke();
  fill(mainColor);
  triangle(buttonPlayX, buttonPlayY, buttonPlayX+buttonPlayDX, buttonPlayY+buttonPlayDY/2, buttonPlayX, buttonPlayY + buttonPlayDY);
}

void drawButtonLoad() {
  noStroke();
  fill(commandBarBackground);
  rectMode(CORNER);
  rect(buttonLoadX, buttonLoadY, buttonLoadDX, buttonLoadDY);

  fill(mainColor);
  textFont(robotoThin);
  text("Load", buttonLoadX, buttonLoadY+buttonLoadDY - buttonLoadPaddingFont);
}

void drawCommandBar(){
  drawCommandBarBackground();
  drawButtonPause();
  drawButtonPlay();
  drawButtonLoad();
}

void drawEffects() {
  noStroke();
  textFont(robotoRegular);
  rectMode(CORNER);
  for (int i = 0; i < effects.length; i++) {
    String typeActiveParameterX = "null";
    String typeActiveParameterY = "null";
    String valueActiveParameterX = "No";
    String valueActiveParameterY = "No";
    int yPadding = i*(effectPanelSizeElementY + paddingEffectPanelY);

    fill(#FFFFFF);
    rect(textEffectNameX, textEffectNameY + yPadding, textEffectNameDX, textEffectNameDY);
    fill(mainColor);
    text(effects[i].getType(), textEffectNameX, textEffectNameY+textEffectNameDY+ yPadding);

    if (effects[i].isActive()) {
      if (effects[i].getActiveParameterX() != null) {
        typeActiveParameterX = effects[i].getActiveParameterX().getType();
        valueActiveParameterX = doubleFormatter.format(effects[i].getActiveParameterX().getValue());
      }

      if (effects[i].getActiveParameterY() != null) {
        typeActiveParameterY = effects[i].getActiveParameterY().getType();
        valueActiveParameterY = doubleFormatter.format(effects[i].getActiveParameterY().getValue());
      }

      fill(#FFFFFF);
      rect(textEffectP1TypeX, textEffectP1TypeY + yPadding, textEffectP1TypeDX, textEffectP1TypeDY);
      fill(mainColor);
      text(typeActiveParameterX, textEffectP1TypeX, textEffectP1TypeY+textEffectP1TypeDY+ yPadding);

      fill(#FFFFFF);
      rect(textEffectP1ValueX, textEffectP1ValueY + yPadding, textEffectP1ValueDX, textEffectP1ValueDY);
      fill(mainColor);
      text(valueActiveParameterX, textEffectP1ValueX, textEffectP1ValueY+textEffectP1ValueDY+ yPadding);

      fill(#FFFFFF);
      rect(textEffectP2TypeX, textEffectP2TypeY + yPadding, textEffectP2TypeDX, textEffectP2TypeDY);
      fill(mainColor);
      text(typeActiveParameterY, textEffectP2TypeX, textEffectP2TypeY+textEffectP2TypeDY+ yPadding);

      fill(#FFFFFF);
      rect(textEffectP2ValueX, textEffectP1ValueY + yPadding, textEffectP2ValueDX, textEffectP2ValueDY);
      fill(mainColor);
      text(valueActiveParameterY, textEffectP2ValueX, textEffectP2ValueY+textEffectP2ValueDY+ yPadding);
    }
  }
}
