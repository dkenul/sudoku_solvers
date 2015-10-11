require_relative 'solver'

class SemiRandom < Solver

  def solve

    iteration = 0

    until solved?

      test_board = board.deep_dup
      until test_board.score < board.score
        test_board.semi_randomize!
      end

      @board = test_board

      iteration += 1
      render
      puts "Score : #{board.score}"
      puts "Iteration : #{iteration}"
    end

    puts "SOLVED!!!"
    render
  end

end
