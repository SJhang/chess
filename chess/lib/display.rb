require 'colorize'
require_relative 'cursor'

class Display
  def initialize(board)
    @board = board
    @cursor_pos = Cursor.new([0,0], board)
  end


  def render
    @board[@cursor_pos.cursor_pos].colorize(:background => :red)
    #@cursor_pos.get_input
  end

  def display_board
    # instead of doing checkboard through nullpiece class, we just do odds and evens here as a background color
    @board.rows.each_index.inject([]) do |board, row_idx|
      board << @board.rows[row_idx].each_index.inject("") do |str, col_idx|
        x = @board[[row_idx, col_idx]].to_s #.colorize( idx % 2 == 0 :white : :black)
        x = x.colorize(:background => :red) if @cursor_pos.cursor_pos == [row_idx, col_idx]
       str << x
      end
    end.join("\n")
  end

  def test_render
    val = nil
    until val == @cursor_pos.cursor_pos
      puts display_board
      val = @cursor_pos.get_input
      puts "#{val}"
      #render
    end
  end
end
