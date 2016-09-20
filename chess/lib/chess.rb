require_relative 'display'
require_relative 'board'
require_relative 'player'
require 'byebug'

class Chess

  def initialize
    @board = Board.new
    @board.load_pieces

    player_creation

    @display = Display.new(@board)
  end

  def player_creation
    @players = [Player.new(:white), Player.new(:black)]
    @current_player = @players.first
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
    @display.clear_notifications
    start_pos
  end


  def switch_players!
    @current_player = (@current_player == @players.first ? @players.last : @players.first)
  end

  def play
    until @board.checkmate?(@current_player.color)
      @display.notifications("You are in check!") if @board.in_check?(@current_player.color)
      take_turn
      switch_players!
      @display.clear_notifications
    end
    
    display_winner
  end

  def display_winner
    system("clear")
    switch_players!
    puts @display.display_board
    puts "Checkmate Sonnnnn"
    puts "#{@current_player.color.to_s.capitalize} won!"
  end
end

if __FILE__ == $PROGRAM_NAME
  chess = Chess.new
  chess.play
end
