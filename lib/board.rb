require 'piece'

class Board
  attr_accessor :grid

  DELTAS = [
    [1,1],[1,-1],[-1,1],[-1,-1],
    [0,1],[0,-1],[1,0],[-1,0]
  ]

  def initialize
    @grid = Array.new(8) {Array.new(8) {nil}}
  end

  def add_piece(location, color)
    x, y = location
    @grid[y][x] = Piece.new(location, color)
  end

  def count(color)
    @grid.flatten.compact.select do |square|
      square.color == color
    end.size
  end

  def flip_piece(loc) # => takes [x,y]
    x, y = loc
    raise "Can't flip an empty square" if @grid[y][x].nil?
    if @grid[y][x].color == :black
      @grid[y][x].color = :white
    else
      @grid[y][x].color = :black
    end
  end

  def detect_neighbors(loc)
    x, y = loc

    new_squares = DELTAS.map do |delta|
      [delta[0] + x, delta[1] + y]
    end

    new_squares.select! do |square|
      square[0].between?(0,7) && square[1].between?(0,7)
    end
  end

  def get_piece(loc)
    x,y = loc
    @grid[y][x]
  end

  def detect_enemies(squares, color)
    #takes array from detect neighbors
    squares.select do |square|
      next if get_piece(square).nil?
      get_piece(square).color != color
    end
  end

end













