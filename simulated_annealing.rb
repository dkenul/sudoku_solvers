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

    until solved?
      board.semi_randomize!
      temp = 1.0
      iteration = 0

      # Set markov chain #
      chains = 100000

      chains.times do

        test_board = random_swap
        test_score = test_board.score
        delta = (board.score - test_score)

        # Set Probability Function with #
        if test_score <= board.score
          @board = test_board
        elsif exp(delta / temp) - rand() > 0
          @board = test_board
        end

        if test_score == -162
          break
        end

        # Set annealing schedule #
        temp -= (1.0 / (chains * 1.25))
        iteration += 1
        if iteration % 2000 == 0
          render
          puts "Score : #{board.score}"
          puts "Temperature : #{temp}"
          puts "Iteration : #{iteration}"
        end
      end

      puts "REHEAT SYSTEM"
    end

    puts "SOLVED!!!"
    render
    puts "Score : #{board.score}"
    puts "Temperature : #{temp}"
    puts "Iteration : #{iteration}"
  end

end
