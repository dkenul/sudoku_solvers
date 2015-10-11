
class RandomSolver < Solver

  def solve

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
