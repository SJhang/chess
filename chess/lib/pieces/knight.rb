require_relative 'piece'
require_relative 'steppingpiece'

class Knight < Pieces
  include SteppingPiece

  DEFAULT = { :black => [[0, 1], [0, 6]], :white => [[7, 1], [7, 6]] }
  DIRS = [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]]

  def move_diffs
    super(DIRS)
  end

  def to_s
    @color ==  :black ? " \u2658 " : " \u265E "
  end
end
