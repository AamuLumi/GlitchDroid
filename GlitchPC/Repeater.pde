import ddf.minim.AudioEffect;
import ddf.minim.UGen;
import java.util.Arrays;

public class Repeater extends UGen
{
  public final UGenInput audio;
  public final UGenInput timeBeforeRepetition;
  public final UGenInput mixWithInput;

  /** The a coefficients. */
  protected float[] a;
  /** The b coefficients. */
  protected float[] b;

  private float mixPercent;
  private float maxTimeRepeatBuffer;
  private double[] repeatBuffer;
  private int nbRepeatBufferFrames;
  private int iBufferOut;
  private boolean inRepetition;
  private int nbRepeatedFrames;
  private int currentRepeatedFrames;

  public Repeater(float maxTimeBeforeRepetition, float mixPercent)
  {
    super();

    audio = addAudio();

    inRepetition = false;

    this.maxTimeRepeatBuffer = maxTimeBeforeRepetition;
    this.timeBeforeRepetition = addControl(maxTimeBeforeRepetition);

    this.mixPercent = mixPercent;
    this.mixWithInput = addControl(this.mixPercent);

    iBufferOut = 0;
    nbRepeatedFrames = 0;
    currentRepeatedFrames = 0;
  }

  protected void sampleRateChanged()
  {  
    allocateRepeatBuffer();
  }

  protected void channelCountChanged()
  {
    allocateRepeatBuffer();
  }

  void allocateRepeatBuffer()
  {
    nbRepeatBufferFrames = (int)( maxTimeRepeatBuffer*sampleRate() );
    repeatBuffer = new double [ nbRepeatBufferFrames*audio.channelCount() ];
  }

  public void setRepeaterTime(float t) {
    timeBeforeRepetition.setLastValue(t);
  }

  public void setMixPercent(float m) {
    mixWithInput.setLastValue(m);
  }

  public final synchronized void uGenerate(float[] channels)
  {
    if (repeatBuffer == null || repeatBuffer.length == 0) {
      Arrays.fill(channels, 0);
      return;
    }

    // how many samples do we delay the input
    int nbRepeatFrames = (int)(timeBeforeRepetition.getLastValue()*sampleRate());
    int channelCount = channelCount();
    for ( int i = 0; i < channelCount; ++i )
    {
      float in  = audio.getLastValues()[i];

      float out = 0;

      if (mixWithInput.getLastValue() > 0) {
        int inFrame  = currentRepeatedFrames%nbRepeatFrames;
        int inSample = ( inFrame*channelCount + i);
        
        if (currentRepeatedFrames < nbRepeatBufferFrames*2){
          int nextFrame = (currentRepeatedFrames%nbRepeatBufferFrames)*channelCount + i;
          repeatBuffer[nextFrame] = in;
        }

        out = mixWithInput.getLastValue()*(float)repeatBuffer[ inSample ];
        if (i == 0) currentRepeatedFrames++;
      } else {
        currentRepeatedFrames = 0;
      }
      
      out += in*(1-mixWithInput.getLastValue());

      channels[i] = out;
    }
  }
}
