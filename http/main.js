import WebGl from "./src/WebGl.js";
import SocketMoped from "./src/SocketMoped.js";
import ObjectManager from "./src/ObjectManager.js";

class App {
  constructor() {
    this.objectManager = new ObjectManager();
    this.webGl = new WebGl(this.objectManager);
    this.socketMoped = new SocketMoped(this.webGl);
  }
}

new App();
