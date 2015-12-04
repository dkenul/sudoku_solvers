require_relative 'solver'
require 'byebug'

class Backtrack < Solver

  def solve(current_row = 0, current_col = 0)
    return true if solved?

    current_square = (current_col / 3) + 3*(current_row / 3)
    next_row = current_row + 1
    next_col = current_col
    if next_row > 8
      next_row = 0
      next_col += 1
    end

    if board[[current_row, current_col]].given?
      return true if solve(next_row, next_col)
    else
      num = 1
      while num <= 9
        unless self.board.rows[current_row].map(&:value).include?(num) || self.board.columns[current_col].map(&:value).include?(num) || self.board.square(current_square).map(&:value).include?(num)

          self.board[[current_row, current_col]].value = num

          return true if solve(next_row, next_col)

          self.board[[current_row, current_col]].value = 0
        end

        num += 1
      end
    end

    false
  end

end
