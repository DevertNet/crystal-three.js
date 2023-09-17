require "json"
require "../objects/tree"

struct Message::RemoveObject
  include JSON::Serializable

  property object
  @action : String = "removeObject"

  def initialize(@object : Object::Tree)
  end
end
