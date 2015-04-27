class SlideBar {
  
  private int x1, x2, y1, y2;
  private double min, max, value;
  
  public SlideBar(int x1, int y1, int x2, int y2, double min, double max){
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    this.min = min;
    this.max = max;
    this.value = min;
  }
  
  public SlideBar(Point p1, Point p2, double min, double max){
    this(p1.getX(), p1.getY(), p2.getX(), p2.getY(), min, max);
  }
  
  public void setValue(double v){
    if (v < this.min)
      this.value = this.min;
    else if (v > this.max)
      this.value = this.max;
    else
      this.value = v;
  }
  
  public void setValueInPercent(double p){
      if (p < 0)
        this.value = this.min;
      else if (p > 100)
        this.value = this.max;
      else
        this.value = (this.max - this.min) * p;
  }
  
  public double getValue(){
    return this.value;
  }
  
  public double getValueInPercent(){
    return 100 * (this.value * this.min / this.max);
  }
  
}
