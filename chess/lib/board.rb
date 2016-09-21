require_relative './pieces/nullpiece'
require_relative './pieces/piece'

class Board
  def initialize(piece_list = nil)
    @grid = empty_board
    #make sure the game class loads pieces
  end

  def empty_board
    Array.new(8) { Array.new(8){ NullPiece.instance }  }
  end

  def load_pieces(piece_list = nil)
    piece_list ||= Pieces.create_pieces(self)
    piece_list.each do |piece|
      self[piece.pos] = piece
    end
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
      raise "You cannot move there" unless self[start_pos].valid_move_check.include?(end_pos)
    rescue => e
      puts "#{e.message}"
      return false
    end

    update_move(start_pos, end_pos)
  end

  def update_move(start_pos, end_pos)
    piece = self[start_pos]
    self[start_pos] = NullPiece.instance

    self[end_pos] = piece
    piece.pos = end_pos
    piece.completed_move
    true
  end

  def in_bounds?(cursor_pos)
    cursor_pos.all? {|val| val.between?(0, 7)}
  end

  def in_check?(color)
    move_list = []

    king_location = find_king(color)
    opponent_color = self[king_location].opponent_color

    opponent_locations = search_board({:color => opponent_color })
    opponent_locations.each do |loc|
      move_list += self[loc].valid_moves
    end

    move_list.uniq.include?(king_location)
  end

  def checkmate?(color)
    search_board({color: color}).all? do |location|
      self[location].valid_move_check.empty?
    end
  end

  def dup
    piece_list = []
    dup_board = Board.new

    self.rows.each do |row|
      row.each do |piece|
        new_piece = piece.dup(dup_board)
        piece_list << new_piece unless new_piece.nil?
      end
    end

    dup_board.load_pieces(piece_list)
    return dup_board

  end


  private
  def find_king(color)
    search_board( {class: King, color: color} ).first
  end

  def search_board(options = {})
    list = []
    rows.each_index do |row_idx|
      rows[row_idx].each_index do |col_idx|
        list << [row_idx, col_idx] if options.all? { |k,v| self[[row_idx, col_idx]].send(k) == v }
      end
    end
    list
  end

end
