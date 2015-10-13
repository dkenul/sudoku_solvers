require_relative 'solver'

class SemiRandom < Solver

  def solve

    iteration = 0

    until solved?

      test_board = board.deep_dup
      test_board.semi_randomize!


      @board = test_board

      iteration += 1
      if iteration % 2000 == 0
        render
        puts "Score : #{board.score}"
        puts "Iteration : #{iteration}"
      end
    end

    puts "SOLVED!!!"
    render
  end

end
