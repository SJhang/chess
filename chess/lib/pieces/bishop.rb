require_relative 'piece'
require_relative 'slidingpiece'

class Bishop < Pieces
  include SlidingPiece

  DEFAULT = { :black => [[0, 2], [0, 5]], :white => [[7, 2], [7, 5]] }

  def move_dir
    super([:diagonal])
  end

  def to_s
    @color == :black ? " \u2657 " : " \u265D "
  end
end
