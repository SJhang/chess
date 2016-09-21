module SteppingPiece
  #feed directions in

  def valid_moves
    move_diffs
  end

  def move_diffs(directions)
    move_list = []
    directions.each do |dir|
      row, col = @pos
      row_add, col_add = dir

      updating_pos = [row + row_add, col + col_add]

      if @board.in_bounds?(updating_pos) && @board[updating_pos].color != self.color
        move_list << updating_pos
      end
    end

    move_list
  end
end
