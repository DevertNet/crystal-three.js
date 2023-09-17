import WebGL from "./WebGl.js";

export default class SocketMoped {
  /**
   *
   * @param {WebGL} webGl
   */
  constructor(webGl) {
    this.webGl = webGl;

    this.connect();
    this.output = document.getElementById("output");

    console.log("NEW ORLD!!");

    document.getElementById("send").addEventListener("click", (event) => {
      event.preventDefault();

      const messageInput = document.getElementById("messageInput");
      const message = messageInput.value;

      console.log(this.socket);
      this.socket.send(message);

      console.log(`Sent: ${message}`);
      this.output.innerHTML += `Sent: ${message}<br>`;
      messageInput.value = "";
    });
  }

  connect() {
    const socket = new WebSocket("ws://127.0.0.1:8080/websocket");

    socket.addEventListener("open", (event) => {
      console.log("Connected to server");
      this.output.innerHTML += "Connected to server<br>";
    });

    socket.addEventListener("message", (event) => {
      console.log(`Received: ${event.data}`);
      this.webGl.addBlock(event.data, 0, 0);
      this.output.innerHTML += `Received: ${event.data}<br>`;
    });

    socket.addEventListener("close", (event) => {
      if (event.wasClean) {
        console.log(
          `Connection closed cleanly, code=${event.code}, reason=${event.reason}`
        );
        this.output.innerHTML += `Connection closed cleanly, code=${event.code}, reason=${event.reason}<br>`;
      } else {
        console.error("Connection abruptly closed");
        this.output.innerHTML += "Connection abruptly closed<br>";

        window.setTimeout(() => {
          this.socket = this.connect();
        }, 3000);
      }
    });

    this.socket = socket;
  }
}
