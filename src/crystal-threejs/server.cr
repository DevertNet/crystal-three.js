require "json"
require "http"
require "http/server"
require "./server/app_handler"
require "tasker"
require "./objects/tree"
require "./messages/*"

class Server::Base
  def run
    server = HTTP::Server.new(get_handlers)

    address = server.bind_tcp 8080
    puts "Listening on http://#{address}"
    server.listen
  end

  def get_handlers
    app_handler = Server::AppHandler.new

    websocket_handler = HTTP::WebSocketHandler.new do |ws, ctx|
      ws.send "Hey Client :)"

      ws.on_ping { ws.pong ctx.request.path }
      ws.on_message do |message|
        puts "Received message: #{message}"
        ws.send "5"
      end

      Tasker.every(2.seconds) {
        object = Object::Tree.new(Random.rand(4), Random.rand(4), Random.rand(4))
        ws.send Message::AddObject.new(object).to_json

        Tasker.in(3.seconds) {
          ws.send Message::RemoveObject.new(object).to_json
        }
      }
    end

    file_handler = HTTP::StaticFileHandler.new("http")

    [app_handler, websocket_handler, file_handler]
  end
end
