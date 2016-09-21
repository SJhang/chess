class Pieces
  attr_reader :color
  attr_accessor :pos

  def self.create_pieces(board)
    list = []
    [:white, :black].each do |color|
      [Pawn, Knight, King, Queen, Rook, Bishop].each do |piece_class|
        piece_class::DEFAULT[color].each do |location|
          list << piece_class.new(color, location, board)
        end
      end
    end
    list
  end

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

  def dup(board)
    self.class.new(@color, @pos, board)
  end

  def completed_move
  end

  def to_s()
  end

  def empty?()
    false
  end

  def symbol()
  end

  def valid_move_check

    self.valid_moves.reject do |move_pos|
      dup_board = @board.dup
      start_pos = @pos
      dup_board.update_move(start_pos, move_pos)
      dup_board.in_check?(@color)
    end

  end

  def opponent_color
    @color == :white ? :black : :white
  end

  private
  def move_into_check?
  end

end

%w(bishop king knight pawn queen rook).each { |file| require_relative file }
