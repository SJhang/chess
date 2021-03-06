require 'colorize'
require_relative 'cursor'

class Display
  def initialize(board)
    @board = board
    @cursor_pos = Cursor.new([0,0], board)
    @notifications = ""
  end

  def notifications(message)
    @notifications += "#{message}\n"
  end

  def clear_notifications
    @notifications = ""
  end


  def render(message = "")
    val = nil
    until val == @cursor_pos.cursor_pos
      system("clear")
      puts "#{@notifications}" unless @notifications.empty?
      puts "#{message}"
      puts display_board
      val = @cursor_pos.get_input
    end

    val
  end

  def display_board
    # instead of doing checkboard through nullpiece class, we just do odds and evens here as a background color
    @board.rows.each_index.inject([]) do |board, row_idx|
      board << @board.rows[row_idx].each_index.inject("") do |str, col_idx|
        white_space = row_idx.even? && col_idx.odd? || row_idx.odd? && col_idx.even?
        x = @board[[row_idx, col_idx]].to_s.colorize( :background => (white_space ? :red : :black))
        x = x.colorize(background: :blue) if @cursor_pos.cursor_pos == [row_idx, col_idx]
       str << x
      end
    end.join("\n")
  end

end
