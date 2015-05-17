import java.util.Vector;
import java.lang.reflect.InvocationTargetException;

class Effect {

  private String type;
  private Vector<Parameter> parameters;
  private Parameter[] activeParameters;
  private boolean active;
  private UGen ugenEffect;

  public Effect(String type, UGen effect) {
    this.type = type;
    this.parameters = new Vector<Parameter>();
    this.activeParameters = new Parameter[2];
    this.active = false;
    this.ugenEffect = effect;
  }  

  public void addParameter(String type, double min, double max, double value, double zeroValue, String method) {
    this.parameters.add(new Parameter(type, min, max, value, zeroValue, ugenEffect, method));
  }

  public void addParameter(Parameter p) {
    this.parameters.add(p);
  }

  public void removeParameter(String type) {
    for (Parameter p : parameters)
      if (p.getType().equals(type)) {
        parameters.remove(p);
        break;
      }
  }

  public void removeParameter(Parameter p) {
    parameters.remove(p);
  }

  public Vector<Parameter> getParameters() {
    return parameters;
  }

  public String getType() {
    return type;
  }

  public Parameter getActiveParameterX() {
    return activeParameters[0];
  }

  public void setActiveParameterX(String type) {
    for (Parameter p : parameters)
      if (p.getType().equals(type)) {
        activeParameters[0] = p;
        break;
      }
  }

  public void setActiveParameterX(Parameter p) {
    for (Parameter pi : parameters)
      if (pi.equals(p)) {
        activeParameters[0] = pi;
        break;
      }
  }

  public Parameter getActiveParameterY() {
    return activeParameters[1];
  }

  public void setActiveParameterY(String type) {
    for (Parameter p : parameters)
      if (p.getType().equals(type)) {
        activeParameters[1] = p;
        break;
      }
  }

  public void setActiveParameterY(Parameter p) {
    for (Parameter pi : parameters)
      if (pi.equals(p)) {
        activeParameters[1] = pi;
        break;
      }
  }

  public boolean isActive() {
    return active;
  }

  public void setActive(boolean a) {
    this.active = a;
    if (activeParameters[0] != null)
      activeParameters[0].switchActivate();
    if (activeParameters[1] != null)
      activeParameters[1].switchActivate();
  }

  public UGen getUGenEffect() {
    return this.ugenEffect;
  }
}

class Parameter {

  private String type;
  private double min, max, value, alternativeValue;
  private UGen u;
  private java.lang.reflect.Method method;
  private boolean isActivated;

  public Parameter(String type, double min, double max, double value, double zeroValue, UGen u, String method) {
    this.type = type;
    this.min = min;
    this.max = max;
    this.value = zeroValue;
    this.alternativeValue = value;
    this.u = u;
    this.isActivated = false;
    this.method = null;

    try {
      this.method = u.getClass().getMethod(method, float.class);
    } 
    catch (SecurityException e) {
      e.printStackTrace();
    } 
    catch (NoSuchMethodException e) {
      e.printStackTrace();
    }
    
    setUGenValue((float)this.value);
  }

  public synchronized void setValue(double value) {
    float trueValue = (float)((value / (100/(max-min))) + min);
    if (isActivated) {
      this.value = trueValue;
      setUGenValue((float)this.value);
    } else
      this.alternativeValue = trueValue;
  }
  
  public void setUGenValue(float value){
    try {
        method.invoke(u, value);
      } 
      catch (InvocationTargetException x) {
        x.printStackTrace();
      }
      catch (IllegalAccessException x) {
        x.printStackTrace();
      }
  }

  public double getValue() {
    return this.value;
  }

  public double getMin() {
    return this.min;
  }

  public double getMax() {
    return this.max;
  }

  public String getType() {
    return this.type;
  }

  public synchronized void switchActivate() {
    double tmp = alternativeValue;
    alternativeValue = value;
    value = tmp;
    
    isActivated = !isActivated;
    
    setUGenValue((float)value);
  }
}
