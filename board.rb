require_relative "tile"

class Board

  attr_accessor :grid

  def self.empty_grid
    Array.new(9) do
      Array.new(9) { Tile.new(0) }
    end
  end

  def self.from_file(filename)
    rows = File.readlines(filename).map(&:chomp)
    tiles = rows.map do |row|
      nums = row.split("").map { |char| Integer(char) }
      nums.map { |num| Tile.new(num) }
    end

    self.new(tiles)
  end

  def initialize(grid = Board.empty_grid)
    @grid = grid
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    tile = grid[x][y]
    tile.value = value
  end

  def columns
    rows.transpose
  end

  def render
    system("clear")
    var = @grid.map do |row|
      row.map do |column|
        column.given? ? column.value.to_s.colorize(:red) : column.value.to_s
      end
    end
    for i in 0..@grid.length-1
      var[i].insert(3, "|")
      var[i].insert(7, "|")
    end
    var.insert(3, Array.new(11) {"-"})
    var.insert(7, Array.new(11) {"-"})

    puts var.map {|row| row.join(' ') + "\n"}
  end

  def rows
    grid
  end

  def size
    grid.size
  end

  def solved?
    rows.all? { |row| solved_set?(row) } &&
      columns.all? { |col| solved_set?(col) } &&
      squares.all? { |square| solved_set?(square) }
  end

  def solved_set?(tiles)
    nums = tiles.map(&:value)
    nums.sort == (1..9).to_a
  end

  def square(idx)
    tiles = []
    x = (idx / 3) * 3
    y = (idx % 3) * 3

    (x...x + 3).each do |i|
      (y...y + 3).each do |j|
        tiles << self[[i, j]]
      end
    end

    tiles
  end

  def squares
    (0..8).to_a.map { |i| square(i) }
  end

  def deep_dup
    copied_board = Board.new
    (0..8).each do |i|
      (0..8).each do |j|
        tile = grid[i][j]
        copied_board.grid[i][j] = tile.class.new(tile.value)
        copied_board.grid[i][j].given = tile.given?
      end
    end
    copied_board
  end

  def valid_moves
    result = []
    rows.each.with_index do |row, i|
      row.each.with_index do |tile, j|
        result << [i, j] unless tile.given?
      end
    end
    result
  end

end
