require_relative 'piece'

class Pawn < Pieces

  DEFAULT = {:black => (0..7).map {|pos| [1, pos]}, :white => (0..7).map {|pos| [6, pos]}}
  FORWARD = {black: 1, white: -1 }
  SIDE = { black: [[1,1], [1,-1]], white: [[-1,1], [-1,-1]] }

  def initialize(color, pos, board)
    @first_move = true
    super
  end

  def completed_move
    @first_move = false
  end

  def valid_moves
    forward_dir + side_attacks
  end

  def forward_dir
    move_list = []
    move_limit = (@first_move ? 2 :  1)
    row, col = @pos

    move_limit.times do
      updating_pos = [row + FORWARD[@color], col]

      if @board.in_bounds?(updating_pos) && @board[updating_pos].color == :none
        move_list << updating_pos
      else
        break
      end
      row, col = updating_pos
    end
    move_list
  end

  def side_attacks
    move_list = []

    SIDE[@color].each do |dir|
      row, col = @pos
      updating_pos = [row + dir.first, col + dir.last]
      if @board.in_bounds?(updating_pos) && @board[updating_pos].color == opponent_color
        move_list << updating_pos
      end
    end
    move_list
  end

  def to_s
    @color == :black ? " \u2659 " : " \u265F "
  end

end
