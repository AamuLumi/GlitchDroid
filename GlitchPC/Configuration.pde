void defineEffects() {
  effects = new Effect[8];

  Delay d = new Delay();
  d.setDelAmp(0.5);
  d.setDelTime(2.5);

  effects[0] = new Effect("Delay", d);
  effects[0].addParameter("Amp", 0, 1, 0.5, 0, "setDelAmp");
  effects[0].setActiveParameterX("Amp");
  effects[0].addParameter("Time", 0, 5, 2.5, 0, "setDelTime");
  effects[0].setActiveParameterY("Time");
  mp.addEffect(effects[0]);

  Pan p = new Pan(0);
  effects[1] = new Effect("Panning", p);
  effects[1].addParameter("Pan", -1, 1, 0, 0, "setPan");
  effects[1].setActiveParameterX("Pan");
  //mp.addEffect(effects[1]);

  Gain g = new Gain(0);
  effects[2] = new Effect("Gain", g);
  effects[2].addParameter("Gain", -50, 50, 0, 0, "setValue");
  effects[2].setActiveParameterX("Gain");
  mp.addEffect(effects[2]);
  
  Repeater r = new Repeater(1.0, 0);
  effects[3] = new Effect("Repeater", r);
  effects[3].addParameter("Time", 0, 1, 0.5, 0, "setRepeaterTime");
  effects[3].setActiveParameterX("Time");
  effects[3].addParameter("Mix", 0, 1, 0.5, 0, "setMixPercent");
  effects[3].setActiveParameterY("Mix");
  mp.addEffect(effects[3]);
  
  Gate gate = new Gate(1.0, 0);
  effects[4] = new Effect("Gate", gate);
  effects[4].addParameter("Time", 0, 1, 0.5, 0, "setTime");
  effects[4].setActiveParameterX("Time");
  effects[4].addParameter("Mix", 0, 1, 0.5, 0, "setMixPercent");
  effects[4].setActiveParameterY("Mix");
  mp.addEffect(effects[4]);

  for (int i = 5; i < 8; i++) {
    effects[i] = new Effect("None", null);
  }
}
