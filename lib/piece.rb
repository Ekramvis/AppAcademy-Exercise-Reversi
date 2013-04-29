class Piece
  attr_accessor :color, :position

  def initialize(position, color)
    @position = position
    @color = color
  end

  def display
    @color == :white ? "_W_|" : "_B_|"
  end

end