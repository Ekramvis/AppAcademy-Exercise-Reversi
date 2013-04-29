require 'rspec'
require 'board'

describe Board do
  subject(:board) {Board.new}

  describe "#initialize" do
    it "creates an empty grid" do
      board.grid.should == Array.new(8) {Array.new(8) {nil}}
    end
  end

  describe "#add_piece(location, color)" do
    it "adds a piece to a new location" do
      board.add_piece([0,0], :black)
      board.grid[0][0].class.should == Piece
      board.grid[0][0].color.should == :black
    end
  end

  describe "#count(color)" do
    subject(:board) {Board.new}

    it "counts the number of black pieces" do
      board.add_piece([0,0], :black)
      board.add_piece([1,0], :black)
      board.add_piece([2,0], :black)
      board.count(:black).should == 3
    end
  end

  describe "#flip_piece(loc)" do
    it "flips the color of the piece at the location" do
      board.add_piece([0,0], :black)
      board.flip_piece([0,0])
      board.grid[0][0].color.should == :white
    end

    it "raises an error if passed an empty location" do
      expect {board.flip_piece([0,0])}.to raise_error("Can't flip an empty square")
    end
  end

  # describe "#detect_neighbors(loc)" do
  #   it "detects neighboring squares on the board" do
  #     board.detect_neighbors([0,0]).all? do |square|
  #       [[1,0],[0,1],[1,1]].include?(square)
  #     end
  #   end
  # end

  describe "#get_piece(loc)" do
    it "returns the grid value at a location" do
      board.add_piece([0,0], :black)
      board.get_piece([0,0]).should == board.grid[0][0]
    end
  end

  # describe "#detect_enemies(neighbors, color)" do
  #   it "detects enemies on neighboring squares" do
  #     board.add_piece([0,0], :black)
  #     board.add_piece([0,1], :black)
  #     board.add_piece([0,2], :white)
  #     x = board.detect_neighbors([0,1])
  #     board.detect_enemies(x, :black).should == [[0,2]]
  #   end
  # end

  describe "#look_straight(start, delta)" do
    it "takes a delta and iterates until it hits an empty spot" do
      board.add_piece([0,0], :black)
      board.add_piece([0,1], :white)

      board.look_straight([0,0],[0,1]).should == []
    end

    it "returns [] if friend is immediate neighbor" do
      board.add_piece([0,0], :black)
      board.add_piece([0,1], :black)
      board.add_piece([0,2], :white)
      board.look_straight([0,0],[0,1]).should == []
    end

    it "returns [] if end of the board reached" do
      board.add_piece([0,0], :white)
      board.add_piece([0,1], :white)
      board.add_piece([0,2], :black)
      board.look_straight([0,2],[0,-1]).should == []
    end

    it "returns locs of consecutive enemies if friend caps line" do
      # board.add_piece([0,0], :black)
      # board.add_piece([0,1], :white)
      # board.add_piece([0,2], :white)
      # board.add_piece([0,3], :black)
      board.add_piece([1,1], :black)
      board.add_piece([2,2], :white)
      board.add_piece([3,3], :white)
      board.add_piece([4,4], :black)
      board.look_straight([1,1],[1,1]).should == [[2,2],[3,3]]
    end
  end

end







