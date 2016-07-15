class PolyTreeNode

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = node

    unless node.nil? || node.children.include?(self)
      node.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "node is not a child of this node" unless @children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target)
    return self if @value == target
    @children.each do |child|
      return_value = child.dfs(target)
      return return_value unless return_value.nil?
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      curr_node = queue.shift
      return curr_node if curr_node.value == target
      curr_node.children.each do |child|
        queue << child
      end
      nil
    end
  end

end
