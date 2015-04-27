import android.view.MotionEvent;
import android.util.SparseArray;

int TouchEvents;
int currentPointerId = 0;
SparseArray<GlitchSpace> spaceForPointer;

public void initMultiTouch() {
  spaceForPointer = new SparseArray<GlitchSpace>();
}

public int getNumberPointersOn(GlitchSpace g) {
  int res = 0;
  for (int i = 0; i < spaceForPointer.size () && spaceForPointer.get(i) != null; i++)
    if (spaceForPointer.get(i).equals(g))
      res++;

  return res;
}

public void inputNormal(MotionEvent event) {

  // Number of places on the screen being touched:
  TouchEvents = event.getPointerCount();

  int pointerIndex = event.getActionIndex();
  int pointerId = event.getPointerId(pointerIndex);

  switch(event.getActionMasked()) {

    // ACTION_DOWN 
  case MotionEvent.ACTION_POINTER_DOWN:
  case MotionEvent.ACTION_DOWN: 
    { 
      GlitchSpace space = getSpaceForCoordonates((int)event.getX(pointerIndex), (int)event.getY(pointerIndex));
      spaceForPointer.put(pointerId, space);
      if (space != null) {
        if (getNumberPointersOn(space) == 2) {
          space.switchActivate();
          cl.sendActive(space.getNumGlitchSpace(), space.isActivated());
        }

        if (getNumberPointersOn(space) == 3) {
          space.showConfiguration();
          programState = STATE_CONFIGURATION;
        }
      }
      break;
    } 

    // ACTION_uP
  case MotionEvent.ACTION_CANCEL:
  case MotionEvent.ACTION_POINTER_UP:
  case MotionEvent.ACTION_UP: 
    {
      spaceForPointer.remove(pointerId);
      break;
    }

    // ACTION_MOVE
  case MotionEvent.ACTION_MOVE: 
    {
      for (int i = 0; i < TouchEvents; i++) {
        GlitchSpace spaceTmp = spaceForPointer.get(event.getPointerId(i));
        if ( spaceTmp != null) 
        {
          if (spaceTmp.isOnPointer((int)event.getX(i), (int)event.getY(i))) {
            spaceTmp.setPointer(new Point((int)event.getX(i), (int)event.getY(i)));
            cl.sendSetValue(spaceTmp.getNumGlitchSpace(), spaceTmp.getValueX(), spaceTmp.getValueY());
          }
        }
      }
      break;
    }
  }
}

public void inputConfiguration(MotionEvent event) {
  if (spaceInConfiguration.isOnSaveRect((int)event.getX(0), (int)event.getY(0))) {
    spaceInConfiguration = null;
    programState = STATE_NORMAL;
  }
}

public boolean surfaceTouchEvent(MotionEvent event) {
  if (programState == STATE_NORMAL) {
    inputNormal(event);
  } else if (programState == STATE_CONFIGURATION) {
    inputConfiguration(event);
  }

  // If you want the variables for motionX/motionY, mouseX/mouseY etc.
  // to work properly, you'll need to call super.surfaceTouchEvent().
  return super.surfaceTouchEvent(event);
}

