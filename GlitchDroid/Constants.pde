final String SERVER_IP = "192.168.0.20";
final int SERVER_PORT = 34195;

int PointerSize = 35;
int PointerPrecision = 15;
int divisions = 4;

GlitchSpace spaceInConfiguration;

byte programState;

final byte STATE_NORMAL = 0;
final byte STATE_CONFIGURATION = 1;

final int widthConfigurationSaveRect = 400;
final int heightConfigurationSaveRect = 150;
final int paddingConfigurationSaveRect = 50;

int beginningConfigurationSaveRectX;
int beginningConfigurationSaveRectY;
int endConfigurationSaveRectX;
int endConfigurationSaveRectY;

void setupConstants() {
  beginningConfigurationSaveRectX = height - paddingConfigurationSaveRect - widthConfigurationSaveRect;
  beginningConfigurationSaveRectY = paddingConfigurationSaveRect;
  endConfigurationSaveRectX = height - paddingConfigurationSaveRect;
  endConfigurationSaveRectY = paddingConfigurationSaveRect + heightConfigurationSaveRect;
}

