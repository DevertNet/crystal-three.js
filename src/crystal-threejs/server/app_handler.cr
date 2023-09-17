require "http/server/handler"

class Server::AppHandler
  include HTTP::Handler

  def initialize
    # allow @routes to save Proc as its value
    @routes = {} of String => (-> String)

    get "/" do
      content = File.read("http/index.html")
      content
    end
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
