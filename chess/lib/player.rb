

class Player

  attr_reader :color
  
  def initialize(color)
    @color = color
  end

  def select_piece(display)
    display.render("Please choose a piece")
  end

  def select_destination(start_pos, display)
    display.render("You have selected the piece at #{start_pos}.\nPlease choose a destination")
  end
end
