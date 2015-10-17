class Game
  attr_reader :players, :board, :current_player, :other_player, :game_over

  WINNING_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

  def initialize(players)
    @board = Board.new
    @current_player, @other_player = players.shuffle
    @game_over = false
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def print_board
    puts "\t\t #{ @board.grid[6] } | #{ @board.grid[7] } | #{ @board.grid[8] }"
    puts "\t\t---+---+---"
    puts "\t\t #{ @board.grid[3] } | #{ @board.grid[4] } | #{ @board.grid[5] }"
    puts "\t\t---+---+---"
    puts "\t\t #{ @board.grid[0] } | #{ @board.grid[1] } | #{ @board.grid[2] }"
    puts "\n=====================================================================\n "
  end

  def handle_turn(move)
    #If the user selects index outside 1..9 || The selection is alrady ocupied
    if !@board.grid.index(move).nil? && coordinate_is_ocuppied?(move)
      @board.grid[move-1] = @current_player.symbol
      true
    else
      false
    end
  end

  def is_coordinate_ocuppied?(move)
    @board.grid[move-1] != move
  end


  def has_a_winner?
    @game_over = WINNING_COMBINATIONS.any? do |combination| 
      combination.all? { |index| @board.grid[index] == @current_player.symbol } 
    end
  end

  def is_a_draw?
    @game_over =!@board.grid.any? { |index| (1..9).cover?(index.to_i) }
  end
end