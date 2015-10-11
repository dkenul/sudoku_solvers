require_relative 'board'

class SimulatedAnnealingSolver
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

  # Randomize and score the board #

  def randomize
    @board.rows.flatten.each do |tile|
      tile.value = rand(1..9) if tile.value.zero?
    end
  end

  def randomize!
    @board.rows.flatten.each do |tile|
      tile.value = rand(1..9) unless tile.given?
    end
  end

  def score
    score = 0
    board.rows.each do |row|
      row_values = row.map { |el| el.value}
      row_values.each do |el_value|
        score -= 1 if row_values.count(el_value) == 1
      end
    end

    board.columns.each do |col|
      col_values = col.map { |el| el.value}
      col_values.each do |el_value|
        score -= 1 if col_values.count(el_value) == 1
      end
    end

    score
  end




  ##For comparison purposes only##
  def rand_solve
    iteration = 0
    until solved?
      randomize!
      iteration += 1
      @board.render
      puts "Score : #{score}"
      puts "Iteration : #{iteration}"
    end
    puts "SOLVED!!!"
    @board.render
  end






end
