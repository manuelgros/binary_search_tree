# Binary Search Tree class
require './lib/node'
require 'pry-byebug'

class Tree 
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.uniq.sort)

  end

  def build_tree(array)
    return nil if array.class != Array || array.empty?

    mid = array.length / 2
    root = Node.new(array[mid])
    if array.length >= 2
      root.left_child = build_tree(array[..mid-1])
      root.right_child = build_tree(array[mid+1..])
    end
    root
  end

  def insert(value, node = @root)
    new_node = Node.new(value)

    if new_node.data > node.data
      node.right_child.nil? ? node.right_child = new_node : insert(new_node.data, node.right_child)
    else
      node.left_child.nil? ? node.left_child = new_node : insert(new_node.data, node.left_child)
    end
  end

  def delete(value, node = @root)
    return node if node.nil?

    if node.data > value
      node.left_child = delete(value, node.left_child)
    elsif node.data < value
      node.right_child = delete(value, node.right_child)
    else
      return node.right_child if node.left_child.nil?

      return node.left_child if node.right_child.nil?

      succ = get_successor(node)
      node.data = succ.data
      node.right_child = delete(succ.data, node.right_child)
    end
    node
  end

  def get_successor(node)
    node = node.right_child
    while !node.nil? && !node.left_child.nil?
      node = node.left_child
    end
    node
  end

  def find(value, node = @root)
    return nil if node.nil?

    return node if node.data == value

    node.data > value ? find(value, node.left_child) : find(value, node.right_child)
  end

  def inorder(node = @root, arr = [], &block)
    return nil if node.nil?

    if block_given?
      inorder(node.left_child, values_arr, &block)
      block.call node
      inorder(node.right_child, values_arr, &block)
    else
      values_arr = arr
      inorder(node.left_child, values_arr, &block)
      values_arr << node.data
      inorder(node.right_child, values_arr, &block)
      values_arr
    end
  end


  def level_order(node = @root)
    return nil if node.nil?

    queue_arr = [node]
    values_arr = []
    until queue_arr.empty?
      current = queue_arr.first
      if block_given?
        yield current
      else
        values_arr.push(current.data)
      end
      queue_arr.push(current.left_child) unless current.left_child.nil?
      queue_arr.push(current.right_child) unless current.right_child.nil?
      queue_arr.shift
    end
    return values_arr unless block_given?
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

end