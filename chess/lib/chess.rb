require_relative 'display'
require_relative 'board'
require_relative 'player'
require 'byebug'

class Chess

  def initialize
    @board = Board.new
    @players = [Player.new(:white), Player.new(:black)]
    @current_player = @players.first
    @board.load_pieces
    @display = Display.new(@board)
  end

  def take_turn
    begin
      start_pos = get_piece
      @display.clear_notifications

      end_pos = @current_player.select_destination(start_pos, @display)
      legal_move = @board.move(start_pos, end_pos)
      raise "This was an illegal move" unless legal_move
    rescue => e
      @display.notifications("#{e.message}")
      retry
    end

  end

  def get_piece
    begin
      start_pos = @current_player.select_piece(@display)
      if @board[start_pos].color != @current_player.color
        raise "You cannot select this piece"
      end
    rescue => e
      @display.notifications("#{e.message}")
      retry
    end

    start_pos
  end


  def switch_players!
    @current_player = (@current_player == @players.first ? @players.last : @players.first)
  end

  def play
    until @board.checkmate?(@current_player.color)
      #byebug
      take_turn
      switch_players!
    end
    switch_players!
    puts "CHECKMATE"
    puts "#{@current_player.color} WON!"
  end
end
