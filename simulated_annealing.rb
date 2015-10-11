require_relative 'solver'

class SimulatedAnnealing < Solver

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

  end

end
