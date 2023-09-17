require "json"
require "../objects/tree"

struct Message::AddObject
  include JSON::Serializable

  property object
  @action : String = "addObject"

  def initialize(@object : Object::Tree)
  end
end
