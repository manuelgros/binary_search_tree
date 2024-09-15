# main file for BST project
require './lib/node'
require './lib/tree'
require 'pry-byebug'

#------------ Test Code ---------------

# arr = [1, 7, 4, 23, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
# tree = Tree.new(arr)
# tree.pretty_print
# tree.insert(2)
# tree.pretty_print
# tree.delete(67)
# tree.pretty_print

arr = Array.new(15) { rand(1..100) }
tree = Tree.new(arr)
tree.pretty_print
puts ""
p tree.balanced?
puts ""
p tree.preorder
p tree.postorder
p tree.inorder
tree.insert(102)
tree.insert(130)
tree.insert(150)
tree.insert(172)
tree.pretty_print
puts ""
puts tree.balanced?
puts ""
tree.rebalance
tree.pretty_print
puts ""
p tree.balanced?
puts ""
p tree.preorder
p tree.postorder
p tree.inorder