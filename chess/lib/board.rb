require_relative 'nullpiece'
require_relative 'piece'

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8){ NullPiece.instance }  }
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end

  def rows
    @grid
  end

  def move(start_pos, end_pos)
    begin
      raise "You must select a piece" if self[start_pos].is_a?(NullPiece)
      raise "You cannot move there" unless self[start_pos].move_dirs.include?(end_pos)
    rescue => e
      puts "#{e.message}"
      retry
    end
  end

  def in_bounds?(cursor_pos)
    cursor_pos.all? {|val| val.between?(0, 7)}
  end

end
