final String SERVER_IP = "192.168.0.11";
final int SERVER_PORT = 34198;

final color[] colors = {
  #F0A303, #1BA1E2, #A4C400, #60A917, #647687, #FA6800, #F472D0, #FFFFFF
};

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

