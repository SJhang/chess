module SlidingPiece

  DIR = {
    :vertical => [[1, 0], [-1, 0]],
    :horizontal => [[0, 1], [0, -1]],
    :diagonal => [[1, 1], [-1, -1], [-1, 1], [1, -1]]
  }
  def valid_moves
    move_dir
  end

  def move_dir(directions)
    move_list = []

    directions.each do |direction|
      DIR[direction].each do |dir|

        row, col = @pos
        row_add, col_add = dir
        flag = true

        while flag && @board.in_bounds?([row + row_add, col + col_add])
          updating_pos = [row + row_add, col + col_add]
          case @board[updating_pos].color
          when self.color
            flag = false
          when self.opponent_color
            move_list << updating_pos
            flag = false
          else
            move_list << updating_pos
            row += row_add
            col += col_add
          end
        end
      end
    end
    move_list
  end
end
