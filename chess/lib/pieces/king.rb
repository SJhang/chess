require_relative 'piece'
require_relative 'steppingpiece'

class King < Pieces
  include SteppingPiece

  DEFAULT = { :black => [[0, 4]], :white => [[7, 4]] }
  DIRS = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [-1, 1], [1, -1]]

  def to_s
    @color == :black ? " \u2654 " : " \u265A "
  end

  def move_diffs
    super(DIRS)
  end
end
