class Pieces
  attr_reader :color, :pos

  def self.descendants
    #taken from stackoverflow
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def self.create_pieces
    list = []
    [:white, :black].each do |color|
      [Pawn, Knight, King, Queen, Rook, Bishop].each do |piece_class|
        piece_class::DEFAULT[color].each do |location|
          list << piece_class.new(color, location)
        end
      end
    end
    list
  end

  def initialize(color, pos)
    @color = color
    @pos = pos
  end

  def to_s()
  end

  def empty?()
    false
  end

  def symbol()
  end

  def valid_moves(board)
  end

  def opponent_color
    @color == :white ? :black : :white
  end

  private
  def move_into_check?
  end

end

module SlidingPiece

  DIR = {
    :vertical => [[1, 0], [-1, 0]],
    :horizontal => [[0, 1], [0, -1]],
    :diagonal => [[1, 1], [-1, -1], [-1, 1], [1, -1]]
  }
  def valid_moves(board)
    move_dir(board)
    super
  end

  def move_dir(board, directions)
    move_list = []

    directions.each do |direction|
      DIR[direction].each do |dir|

        row, col = @pos
        row_add, col_add = dir
        flag = true

        while flag && board.in_bounds?([row + row_add, col + col_add])
          updating_pos = [row + row_add, col + col_add]
          case board[updating_pos].color
          when self.color
            flag = false
          when self.opponent_color
            move_list << updating_pos
            flag = false
          else
            move_list << updating_pos
            row += row_add
            col += col_add
          end
        end
      end
    end
    move_list
  end


end

module SteppingPiece
  #feed directions in

  def valid_moves(board)
    move_diffs(board)
    super
  end

  def move_diffs(board, directions)
    move_list = []
    directions.each do |dir|
      row, col = @pos
      row_add, col_add = dir

      updating_pos = [row + row_add, col + col_add]

      if board.in_bounds?(updating_pos) && board[updating_pos].color != self.color
        move_list << updating_pos
      end
    end

    move_list
  end
end

class King < Pieces
  include SteppingPiece

  DEFAULT = { :black => [[0, 4]], :white => [[7, 4]] }

  DIRS = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [-1, 1], [1, -1]]
  def initialize(color, pos)
    super
  end

  def to_s
    @color == :black ? "/u2654" : "/u265A"
  end

  def move_diffs(board)
    super(board, DIRS)
  end
end

class Knight < Pieces
  include SteppingPiece

  DEFAULT = { :black => [[0, 1], [0, 6]], :white => [[7, 1], [7, 6]] }
  DIRS = [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]]

  def initialize(color, pos)
    super
  end

  def move_diffs(board)
    super(board, DIRS)
  end

  def to_s
    @color ==  :black ? "\u2658" : "\u265E"
  end
end


class Queen < Pieces
  include SlidingPiece

  DEFAULT = { :black => [[0, 3]], :white => [[7, 3]] }

  def intialize(color, pos)
    super
  end

  def move_dir(board)
    super(board, [:vertical, :horizontal, :diagonal])
  end

  def to_s
    @color == :black ? "\u2655" : "\u265B"
  end
end

class Rook < Pieces
  include SlidingPiece

  DEFAULT = { :black => [[0, 0], [0, 7]], :white => [[7, 0], [7, 7]] }

  def intialize(color, pos)
    super
  end

  def move_dir(board)
    super(boad, [:vertical, :horizontal])
  end

  def to_s
    @color == :black ? "\u2656" : "\u265C"
  end
end

class Bishop < Pieces
  include SlidingPiece

  DEFAULT = { :black => [[0, 2], [0, 5]], :white => [[7, 2], [7, 5]] }

  def intialize(color, pos)
    super
  end

  def move_dir(board)
    super(board, [:diagonal])
  end

  def to_s
    @color == :black ? "\u2657" : "\u265D"
  end
end

class Pawn < Pieces

  DEFAULT = {:black => (0..7).map {|pos| [1, pos]}, :white => (0..7).map {|pos| [6, pos]}}
  DIRS = [[2,0], [1,0], [1,1], [1,-1]]

  def initialize(color, pos)
    @first_move = true
    super
  end

  def valid_moves(board)
    forward_dir(board) + side_attacks(board)
    super
  end

  def forward_dir(board)
    move_list = []
    move_limit = (@first_move ? 2 :  1)
    row, col = @pos

    move_limit.times do
      updating_pos = [row + 1, col]

      if board.in_bounds?(updating_pos) && board[updating_pos].color == :none
        move_list << updating_pos
      else
        break
      end
      row, col = updating_pos
    end
    move_list
  end

  def side_attacks(board)
    move_list = []

    [[1,-1], [1,1]].each do |dir|
      row, col = @pos
      updating_pos = [row + dir.first, col + dir.last]
      if board[updating_pos].color == opponent_color
        move_list << updating_pos
      end
    end
    move_list
  end

  def to_s
    @color == :black ? "\u2659" : "\u265F"
  end

end
