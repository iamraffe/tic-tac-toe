require_relative "board.rb"
require_relative "game.rb"
require_relative "player.rb"
require_relative "ai.rb"


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

def human_turn(current_game)
  time_to_make_a_move current_game
  gets.chomp.to_i
end

def ai_turn(current_game)
  while current_game.is_coordinate_ocuppied? current_game.current_player.make_move
  end
end

def start(current_game)
  while !current_game.game_over
    if current_game.current_player.is_human
      move = human_turn current_game
    else
      move = ai_turn current_game
    end
    if !current_game.handle_turn(move) 
      puts "\n------> Oh c'mon man, you know that ain't valid"
    elsif current_game.has_a_winner?
      congratulate_winner current_game
    elsif current_game.is_a_draw?
      puts "\n\tYou guys suck! This is a draw...\n "
    else
      current_game.switch_players
    end
  end
end

def select_game_mode
  # while (defined? second_player).nil?
  puts "\tDo you wanna play with yourself tonight?"
  puts "\t1. Yes"
  puts "\t2. No"
  game_mode = gets.chomp.to_i
  case game_mode
    when 1
      puts "\tYou have no idea what you've just unleashed"
      second_player = AI.new('O', 'HAL-9000 BUT MORE EVIL')
    when 2
      puts "\tNow, give me the name of the other player brotha"
      second_player_name = gets.chomp
      second_player = Player.new('O', second_player_name, true)
    else
      puts "\nYou're better than this....\n "
  end
  # end
  second_player
end

def greeting
  puts "\n\tWelcome to the most awesomest Tic-Tac-Toe game of all time homie!\n "
  puts "\tGive me the name of the first player, if you will my brother from another mother"
end

def init()
  greeting
  first_player_name = gets.chomp
  first_player = Player.new('X', first_player_name, true)
  second_player = select_game_mode  
  puts "\tNooice, #{second_player.name}. We got ourselves a game!"
  game = Game.new([first_player, second_player])
  puts "\n------> #{game.current_player.name} has been chosen randomly to start"
  start game 
end

init
