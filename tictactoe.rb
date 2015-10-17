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
    if !@board.grid.index(move).nil? && @board.grid[move-1] == move
      @board.grid[move-1] = @current_player.symbol
      true
    else
      false
    end
  end


  def winner?
    @game_over = WINNING_COMBINATIONS.any? do |combination| 
      combination.all? { |index| @board.grid[index] == @current_player.symbol } 
    end
  end

  def draw?
    @game_over =!@board.grid.any? { |index| (1..9).cover?(index.to_i) }
  end
end

class Board
  attr_reader :grid

  def initialize()
    @grid = Array.new(9)
    8.downto(0){ |index| @grid[index] = (index + 1) }
  end
end

class Player
  attr_reader :symbol, :name

  def initialize(symbol, name)
    @symbol = symbol
    @name = name
  end
end

def time_to_make_a_move(current_game)
  puts "\n=====================================================================\n "
  puts "\tIt is your turn, #{current_game.current_player.name}"
  puts "\tWhat will your movement be?"
  puts "\n=====================================================================\n "
  current_game.print_board
end

def congratulate_winner(current_game)
    puts "\n=====================================================================\n "
    puts "**************** You are the champion, #{current_game.current_player.name}! ****************"
    puts "\n=====================================================================\n "
    current_game.print_board
end

def start(current_game)
  while !current_game.game_over
    time_to_make_a_move current_game
    move = gets.chomp.to_i
    if !current_game.handle_turn(move) 
      puts "\n------> Oh c'mon man, you know that ain't valid"
    elsif current_game.winner?
      congratulate_winner current_game
    elsif current_game.draw?
      puts "\n\tYou guys suck! This is a draw...\n "
    else
      current_game.switch_players
    end
  end
end

def init()
  puts "\n\tWelcome to the most awesomest Tic-Tac-Toe game of all time homie!\n "
  puts "\tGive me the name of the first player, if you will my brother from another mother"
  first_player_name = gets.chomp
  first_player = Player.new('X', first_player_name)
  puts "\tThank you, #{first_player_name}. Now, give me the name of the other player brotha"
  second_player_name = gets.chomp
  second_player = Player.new('O', second_player_name)
  puts "\tNooice, #{second_player_name}. We got ourselves a game!"
  game = Game.new([first_player, second_player])
  puts "\n------> #{game.current_player.name} has been chosen randomly to start"
  start game 
end

init
