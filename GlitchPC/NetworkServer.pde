import java.net.*;

class NetworkServer {

  private ServerSocket ss;
  private GlitchController controller;

  public NetworkServer() {
    try {
      ss = new ServerSocket();
      ss.bind(new InetSocketAddress("0.0.0.0", SERVER_PORT));
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  public void waitController() {
    try {
      println("Waiting");
      Socket client = ss.accept();
      println("New client !");
      controller = new GlitchController(client);
      new Thread(controller).start();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  public void stop() {
    controller.stop();
  }
}
