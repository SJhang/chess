require 'singleton'

class NullPiece
  include Singleton
  attr_reader :color

  def initialize
    @color = :none
  end

  def dup(board)
  end

  def to_s
    "     "
  end

  def empty?
    true
  end

  def moves()
  end
end
