require_relative 'display'
require_relative 'board'
require 'byebug'

class Chess

  def initialize
    @board = Board.new
    @board.load_pieces
    @display = Display.new(@board)
  end

  def take_turn
    begin
      start_pos = @display.test_render
      #need to check if it is player's piece
      end_pos = @display.test_render
      legal_move = @board.move(start_pos, end_pos)
      raise "This was an illegal move" unless legal_move
    rescue => e
      puts "#{e.message}"
      retry
    end

  end


end
