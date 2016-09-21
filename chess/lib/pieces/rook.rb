require_relative 'piece'
require_relative 'slidingpiece'

class Rook < Pieces
  include SlidingPiece

  DEFAULT = { :black => [[0, 0], [0, 7]], :white => [[7, 0], [7, 7]] }

  def move_dir
    super([:vertical, :horizontal])
  end

  def to_s
    @color == :black ? " \u2656 " : " \u265C "
  end
end
