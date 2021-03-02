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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '|   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '|   '}", true) if node.left
  end

  def build_tree(array)
    return nil if array.empty?
    middle = array.size / 2
    root_node = Node.new(array[middle])
    root_node.left = build_tree(array[0...middle])
    root_node.right = build_tree(array[middle + 1..-1])
    return root_node
  end

  def insert(val, node = @root)
    @data.push(val) if !@data.include?(val)
    #@data = @data.sort.uniq
    #@root = build_tree(@data)

    if @root == nil
      @root = Node.new(val) 
    else
      if node.data == val
        return node
      elsif val < node.data
        node.left.nil? ? node.left = Node.new(val) : insert(val, node.left)
      else #val > root
        node.right.nil? ? node.right = Node.new(val) : insert(val, node.right)
      end
    end
  end

  def min_sub_value(node = @root)
    while node.left != nil
      node = node.left
    end
    return node
  end

  def delete(val, node = @root)
    @data.delete(val)
    return node if node == nil
    if val < node.data
      node.left = delete(val, node.left) # set equal because possibly changing left
    elsif val > node.data
      node.right = delete(val, node.right)
    else #value same as node.data, so this node to be deleted
      # node with one or no child
      if node.left == nil
        return node = node.right
      elsif node.right == nil
        return node = node.left
      else
        # node with two children
        #get inorder successor
        temp = min_sub_value(node.right)
        # copy successor to deleted node location
        node.data = temp.data
        # delete successor from previous location
        node.right = delete(temp.data, node.right)
      end
    end
    return node
  end

  def find(val, node = @root)
    return nil if node.nil?
    return node if node.data == val
    val < node.data ? find(val, node.left) : find(val, node.right)
  end

  def level_order(a = [], q = [], node = @root)
    a.push(node.data)
    q.push(node.left) unless node.left.nil?
    q.push(node.right) unless node.right.nil?
    return if q.empty?
    level_order(a, q, q.shift)
    return a
  end

  def inorder(node = @root, a = [])
    if node.nil?
      return
    else
      inorder(node.left, a)
      a.push(node.data)
      inorder(node.right, a)
    end
    return a
  end

  def preorder(node = @root, a = [])
    if node.nil?
      return
    else
      a.push(node.data)
      preorder(node.left, a)
      preorder(node.right, a)
    end
    return a
  end

  def postorder(node = @root, a = [])
    if node.nil?
      return
    else
      postorder(node.left, a)
      postorder(node.right, a)
      a.push(node.data)
    end
    return a
  end

  def height(node)
    # height is number of edges in longest path from node to leaf
    return -1 if node.nil?
    [height(node.left), height(node.right)].max + 1
  end

  def depth(node, current_node = @root)
    # path from node to tree's root
    return 0 if current_node == node || current_node.nil?
    [depth(node, current_node.left), depth(node, current_node.right)].min + 1
  end

  def balanced?
    height(@root.left) - height(root.right) < 2 && height(@root.left) - height(root.right) > -2 ? true : false
  end

  def rebalance
    @data = level_order.sort
    @root = build_tree(@data)
  end
end

# Driver 

puts "build tree"
a = Array.new
15.times { a.push(rand(1..100)) }
bst = Tree.new(a)
bst.pretty_print

puts "\nis balanced?"
p bst.balanced?

puts "\n preorder #{bst.preorder}"
puts "\n inorder #{bst.inorder}"
puts "\n postorder #{bst.postorder}"

puts "\ninsert 5 numbers"
5.times { bst.insert(rand(1..100)) }
bst.pretty_print
puts "\nbalanced? #{bst.balanced?}"

puts "\nrebalance"
bst.rebalance
p bst.balanced?
bst.pretty_print

puts "\n preorder #{bst.preorder}"
puts "\n inorder #{bst.inorder}"
puts "\n postorder #{bst.postorder}"


# Old Driver

# puts "\nbuild tree"
# a = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
# bst = Tree.new(a)
# p bst.data
# p bst.root.data
# bst.pretty_print

# puts "\ninsert"
# bst.insert(10)
# p bst.data
# bst.pretty_print

# puts "\ndelete"
# bst.delete(10)
# p bst.data
# bst.pretty_print

# puts "\nfind"
# p bst.find(5)

# puts "\nlevel_order"
# p bst.level_order

# puts "\ninorder"
# p bst.inorder

# puts "\npreorder"
# p bst.preorder

# puts "\npostorder"
# p bst.postorder

# puts "\nheight"
# p bst.height(bst.root)

# puts "\ndepth"
# p bst.depth(bst.root.right.left)

# puts "\nbalanced?"
# bst.insert(11)
# bst.insert(12)
# bst.insert(13)
# p bst.balanced?
# bst.pretty_print
# p bst.data

# puts "\nrebalance"
# bst.rebalance
# p bst.balanced?
# p bst.data
# bst.pretty_print