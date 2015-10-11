require_relative 'board'

class Solver
  attr_reader :board

  # Basic Board Methods #

  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end

  def solved?
    @board.solved?
  end


  def render
    board.render
  end

end
