/** Protocol
 * setValue!1!30!60 = setValue!numEffect!X!Y
 * config!1!type!myType = config!numEffect!type!newTypeName
 * config!1!newParam!myParam!0!100!50 = config!numEffect!newParam!nameParam!min!max!value
 * config!1!switchParamX!myParam = config!numEffect!switchParamX!paramNameToSwitch
 */

import java.io.*;

class GlitchController implements Runnable {

  private Socket s;
  private BufferedReader in;
  private boolean isRunning;
  private String message;

  public GlitchController(Socket s) {
    this.s = s;
    message = "";
    try {
      in = new BufferedReader(new InputStreamReader(s.getInputStream()));
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  public void run() {
    isRunning = true;


    while (isRunning) {
      try {
        message = in.readLine();
        println(message);
        
        if (message == null)
          isRunning = false;
        else
          parsePacket(message);
      } 
      catch (IOException e) {
        e.printStackTrace();
      }
    }
  }

  public void stop() {
    isRunning = false;
  }

  public void parsePacket(String packet) {
    String[] parsedPacket = packet.split("!");
    if (parsedPacket[0].equals("setValue")){
      Parameter x = effects[Integer.parseInt(parsedPacket[1])].getActiveParameterX();
      if (x != null) x.setValue(Double.parseDouble(parsedPacket[2]));
      Parameter y = effects[Integer.parseInt(parsedPacket[1])].getActiveParameterY();
      if (y != null) y.setValue(Double.parseDouble(parsedPacket[3]));
    }
    else if (parsedPacket[0].equals("active")){
      effects[Integer.parseInt(parsedPacket[1])].setActive(Boolean.parseBoolean(parsedPacket[2]));
    }
  }
}
