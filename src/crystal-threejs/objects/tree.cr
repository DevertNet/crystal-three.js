require "json"
require "uuid"

struct Object::Tree
  include JSON::Serializable

  property x, y, z
  @name : String = "tree"
  @type : String = "object"

  def initialize(@x : Int32, @y : Int32, @z : Int32)
    @name = "#{@name}-#{UUID.random.to_s}"
  end
end
