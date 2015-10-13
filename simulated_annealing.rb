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
    benchmark = Time.now

    until solved?
      board.semi_randomize!

      # Set initial conditions #
      convergence_weight = 1.25
      t_0 = 1.0
      dt = t_0
      x = 0

      # Set max iterations #
      runtime = 100000

      runtime.times do

        test_board = random_swap
        test_score = test_board.score
        delta = (board.score - test_score)

        # Set annealing schedule #

        # Discreet #
        #dt -= (t_0 / (runtime.to_f * convergence_weight))
        # Exponential #
        #dt = t_0 * ((1.0 - (1.0 / runtime)) ** x)
        # Linear #
        dt = t_0 - (x / (runtime.to_f * convergence_weight))
        # Inverse Square Log # This is sub-optimal, for comparison #
        #dt = 1 / sqrt(log(x + 1))

        # Set probability function #
        if test_score <= board.score
          @board = test_board
        elsif exp(delta / dt) - rand() > 0
          @board = test_board
        end

        if test_score == -162
          break
        end

        x += 1
        if x % 2000 == 0
          render
          puts "Score : #{board.score}"
          puts "Temperature : #{dt}"
          puts "Iteration : #{x}"
        end
      end

      puts "REHEAT SYSTEM" if x == runtime
    end

    puts "SOLVED!!!"
    render
    puts "Score : #{board.score}"
    puts "Temperature : #{dt}"
    puts "Iteration : #{x}"
    puts "Time to Solve: #{Time.now - benchmark} seconds"
  end

end
