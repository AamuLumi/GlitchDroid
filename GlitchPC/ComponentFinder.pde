boolean isOnButtonPlay(int x, int y) {
  return x >= buttonPlayX && x <= (buttonPlayX + buttonPlayDX) && y >= buttonPlayY && y <= (buttonPlayY + buttonPlayDY);
}

boolean isOnButtonPause(int x, int y) {
  return x >= buttonPauseX && x <= (buttonPauseX + buttonPauseDX) && y >= buttonPauseY && y <= (buttonPauseY + buttonPauseDY);
}

boolean isOnButtonLoad(int x, int y) {
  return x >= buttonLoadX && x <= (buttonLoadX + buttonLoadDX) && y >= buttonLoadY && y <= (buttonLoadY + buttonLoadDY);
}

