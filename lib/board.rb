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


  def get_piece(loc)
    x,y = loc
    @grid[y][x]
  end

  def reversi(enemy_positions)
    enemy_positions.each do |enemy_pos|
      flip_piece(enemy_pos)
    end
  end

  def color(loc)
    get_piece(loc).color unless get_piece(loc).nil?
  end

  def look_straight(start, delta)
    x,y = start
    dx,dy = delta
    start_color = color(start)
    res = []

    return [] if get_piece([x+dx,y+dy]) && color([x+dx,y+dy]) == start_color

    until get_piece([x + dx, y + dy]).nil?
      return res if color([x+dx,y+dy]) == start_color
      x += dx
      y += dy

      res << [x,y]
    end

    []
  end

  def scan_directions(start)
    res = []
    DELTAS.each do |delta|
      res += look_straight(start,delta)
    end
    res.sort!
  end
end













