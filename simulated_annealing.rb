require_relative 'solver'

class SimulatedAnnealing < Solver

  include Math

  def random_swap

    test_board = board.deep_dup
    test_square = rand(0..8)

    options = test_board.valid_square_indices(test_square).shuffle

    s1 = options.first
    s2 = options.last

    test_board[s1], test_board[s2] = test_board[s2], test_board[s1]

    test_board
  end

  def solve
    board.semi_randomize!
    temp = 0.5
    iteration = 0

    until solved?

      test_board = random_swap
      test_score = test_board.score
      delta = (board.score - test_score)

      if exp(delta / temp) - rand() > 0
        @board = test_board
      end

      if test_score == -162
        break
      end

      temp *= 0.99999
      iteration += 1
      if iteration % 1000 == 0

        render
        puts "Score : #{board.score}"
        puts "Temperature : #{temp}"
        puts "Iteration : #{iteration}"
      end
    end

    puts "SOLVED!!!"
    render

  end

end
