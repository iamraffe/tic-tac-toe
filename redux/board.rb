class Board
  attr_reader :grid

  def initialize()
    @grid = Array.new(9)
    8.downto(0){ |index| @grid[index] = (index + 1) }
  end
end