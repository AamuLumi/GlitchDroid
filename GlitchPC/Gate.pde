import ddf.minim.AudioEffect;
import ddf.minim.UGen;
import java.util.Arrays;

public class Gate extends UGen
{
  public final UGenInput audio;
  public final UGenInput time;
  public final UGenInput mixWithInput;

  private float mixPercent;
  private float timeSwitch;
  private float currentFrame;

  public Gate(float maxTime, float mixPercent)
  {
    super();

    audio = addAudio();

    this.timeSwitch = maxTime;
    this.time = addControl(timeSwitch);

    this.mixPercent = mixPercent;
    this.mixWithInput = addControl(this.mixPercent);
    
    this.currentFrame = 0;
  }

  public void setTime(float t) {
    time.setLastValue(t);
  }

  public void setMixPercent(float m) {
    mixWithInput.setLastValue(m);
  }

  public final synchronized void uGenerate(float[] channels)
  {
    int switchFrame = (int)(time.getLastValue() * sampleRate());
    int channelCount = channelCount();
    for ( int i = 0; i < channelCount; ++i )
    {
      float in  = audio.getLastValues()[i];
      float out = 0;

      if (mixWithInput.getLastValue() > 0) {
        out += in * (1-mixWithInput.getLastValue());
        if ((int)(currentFrame / switchFrame)%2 == 0)
          out += in * mixWithInput.getLastValue();
        if (i == (channelCount -1)) currentFrame++;
      } else {
        out = in;
        currentFrame = 0;
      }
      
      channels[i] = out;
    }
  }
}
