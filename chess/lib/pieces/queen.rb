require_relative 'piece'
require_relative 'slidingpiece'

class Queen < Pieces
  include SlidingPiece

  DEFAULT = { :black => [[0, 3]], :white => [[7, 3]] }

  def move_dir
    super([:vertical, :horizontal, :diagonal])
  end

  def to_s
    @color == :black ? " \u2655 " : " \u265B "
  end
end
