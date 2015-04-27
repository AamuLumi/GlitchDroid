import java.net.*;
import java.io.*;

class TCPClient implements Runnable {

  private Socket s;
  private PrintWriter out;

  public void run() {
    try {
      InetAddress serverAddr = InetAddress.getByName(SERVER_IP);
      s = new Socket(serverAddr, SERVER_PORT);
      println("Start socket");
      out = new PrintWriter(new BufferedWriter( new OutputStreamWriter(s.getOutputStream())), true);
      out.println("Coucou");
      out.flush();
    } 
    catch (UnknownHostException e1) {
      e1.printStackTrace();
    } 
    catch (IOException e1) {
      e1.printStackTrace();
    }
  }

  public void send(String str) {
    out.println(str);
    out.flush();
  }
  
  public void stop() throws IOException{
    s.close();
  }
  
  public void sendSetValue(int numEffect, double valueX, double valueY){
    out.println("setValue!" + numEffect + "!" + valueX + "!" + valueY + "!");
    out.flush();
  }
  
  public void sendActive(int numEffect, boolean bActive){
    out.println("active!" + numEffect + "!" + bActive + "!");
    out.flush();
  }
}

