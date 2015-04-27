import java.util.Vector;

class Effect {

  private String type;
  private Vector<Parameter> parameters;
  private Parameter[] activeParameters;
  private boolean active;

  public Effect(String type) {
    this.type = type;
    this.parameters = new Vector<Parameter>();
    this.activeParameters = new Parameter[2];
    this.active = false;
  }  

  public void addParameter(String type, double min, double max, double value) {
    this.parameters.add(new Parameter(type, min, max, value));
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
  
  public void removeParameter(Parameter p){
    parameters.remove(p);
  }
  
  public Vector<Parameter> getParameters(){
    return parameters;
  }
  
  public String getType(){
    return type;
  }
  
  public Parameter getActiveParameterX(){
    return activeParameters[0];
  }
  
  public void setActiveParameterX(String type){
    for (Parameter p : parameters)
      if (p.getType().equals(type)){
        activeParameters[0] = p;
        break;
      }
  }
  
  public void setActiveParameterX(Parameter p){
    for (Parameter pi : parameters)
      if (pi.equals(p)){
        activeParameters[0] = pi;
        break;
      }
  }
  
  public Parameter getActiveParameterY(){
    return activeParameters[1];
  }
  
  public void setActiveParameterY(String type){
    for (Parameter p : parameters)
      if (p.getType().equals(type)){
        activeParameters[1] = p;
        break;
      }
  }
  
  public void setActiveParameterY(Parameter p){
    for (Parameter pi : parameters)
      if (pi.equals(p)){
        activeParameters[1] = pi;
        break;
      }
  }
  
  public boolean isActive(){
    return active;
  }
  
  public void setActive(boolean a){
    this.active = a;
  }
  
}

class Parameter {

  private String type;
  private double min, max, value;

  public Parameter(String type, double min, double max, double value) {
    this.type = type;
    this.min = min;
    this.max = max;
    this.value = value;
  }

  public void setValue(double value) {
    this.value = value;
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
}

