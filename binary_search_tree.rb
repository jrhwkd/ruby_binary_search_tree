# binary search tree

class Node
  attr_accessor :data, :left, :right
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_reader :data, :root
  def initialize(data)
    @data = data.sort.uniq
    @root = build_tree(@data)
  end

  def build_tree(array)
    return nil if array.empty?
    middle = array.size / 2
    root_node = Node.new(array[middle])
    root_node.left = build_tree(array[0...middle])
    root_node.right = build_tree(array[middle + 1..-1])
    return root_node
  end

  def insert(val)
    @data.push(val)
    @data = @data.sort.uniq
    @root = build_tree(@data)

    
  end
end

#Driver

# Build tree
a = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
bst = Tree.new(a)
p bst.data
p bst.root.data

# insert
bst.insert(10)
p bst.data
p bst.root.data