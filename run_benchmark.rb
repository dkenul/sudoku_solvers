require_relative 'simulated_annealing'

if __FILE__ == $PROGRAM_NAME
  20.times do
    testrun = SimulatedAnnealing.from_file('puzzles/sudoku3.txt')
    testrun.solve
  end

  result = File.readlines('output/sudoku3_SA_custom_out.txt').map { |line|
    line.chomp.to_i
  }

  puts "#{result.inject(:+).to_f / result.length} seconds on average."
  puts "This includes data from #{result.length} runs."
end
