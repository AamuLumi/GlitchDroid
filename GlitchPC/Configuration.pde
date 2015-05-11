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

  for (int i = 3; i < 8; i++) {
    effects[i] = new Effect("None", null);
  }
}
