# Node class
class Node
  include Comparable
  
  attr_accessor :right_child, :left_child, :data

  def initialize(data)
    @data = data
    @right_child = nil
    @left_child = nil
  end

end