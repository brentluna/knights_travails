require_relative 'poly_tree_node'

class KnightPathFinder

  DELTAS = [[-2, 1], [-2, -1], [-1, 2], [-1, -2], [2, 1], [2, -1], [1, -2], [1, 2]]

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [@start_pos]
    @tree = build_move_tree
  end

  def self.valid_moves(pos)
    valid_moves = []
    DELTAS.each do |delta|
      row, col = pos.first + delta.first, pos.last + delta.last
      valid_moves << [row, col] if [row, col].all? { |pos| pos.between?(0, 7) }
    end
    valid_moves
  end

  def build_move_tree
    root = PolyTreeNode.new(@start_pos)
    queue = [root]
    until queue.empty?
      curr_node = queue.shift
      moves = new_move_positions(curr_node.value)
      moves.each do |move|
        node = PolyTreeNode.new(move)
        node.parent = curr_node
        queue << node
      end
    end
    root
  end

  def find_path(end_pos)
    return trace_path_back(@tree) if @tree.value == end_pos
    @tree.children.each do |child|
      result = child.dfs(end_pos)
      return trace_path_back(result) unless result.nil?
    end
    nil
  end

  def trace_path_back(node)
    path = [node]
    until path.last.parent.nil?
      path << path.last.parent
    end
    path = path.map { |node| node.value }
    @visited_positions = [@start_pos]
    path.reverse
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos)
    moves = moves.reject { |move| @visited_positions.include?(move) }
    @visited_positions.push(*moves)
    moves
  end

end
