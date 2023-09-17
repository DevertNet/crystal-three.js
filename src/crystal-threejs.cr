require "json"
require "http"
require "http/server"
require "http/server/handler"

class CustomHandler
  include HTTP::Handler

  def initialize
    # allow @routes to save Proc as its value
    @routes = {} of String => (-> String)
  end

  def call(context)
    if @routes.has_key?(context.request.path.to_s)
      # add call method to proc when returned
      context.response.content_type = "text/html"
      context.response.print @routes[context.request.path.to_s].call
    else
      call_next(context)
      # context.response.content_type = "text/plain"
      # context.response.print "404 - not found lol"
      # context.response.status = HTTP::Status.new(HTTP::Status::NOT_FOUND)
    end
  end

  # add method to dynamically add routes
  def get(route, &block : (-> String))
    @routes[route.to_s] = block
  end
end

module BasicHttp
  class Base
    def run
      handler = CustomHandler.new

      handler.get "/" do
        content = File.read("http/index.html")
        content
      end

      ws_handler = HTTP::WebSocketHandler.new do |ws, ctx|
        ws.send "Hey Client :)"

        ws.on_ping { ws.pong ctx.request.path }
        ws.on_message do |message|
          puts "Received message: #{message}"
          ws.send "5"
        end
      end

      file_handler = HTTP::StaticFileHandler.new("http")

      server = HTTP::Server.new([handler, ws_handler, file_handler])

      address = server.bind_tcp 8080
      puts "Listening on http://#{address}"
      server.listen
    end
  end
end

app = BasicHttp::Base.new
app.run
