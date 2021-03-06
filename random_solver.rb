require_relative 'solver'

class RandomSolver < Solver

  # Worst Possible Scenario - should be used for testing only #

  def solve
    iteration = 0

    until solved?
      board.randomize!
      iteration += 1
      render
      puts "Score : #{board.score}"
      puts "Iteration : #{iteration}"
    end

    puts "SOLVED!!!"
    render
  end

end
