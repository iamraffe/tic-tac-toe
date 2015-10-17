class Game
	attr_reader(:game_over, :turn, :players)
	def initialize(players)
		@moves = self.update_board()
		@players = players
		@game_over = false
		@turn = rand 2
	end

	def set_coordinates(x = nil, y = nil)
		coordinates = [
			['NW ', ' N ', ' NE',],
			[' W ', ' C ', ' E '],
			['SW ', ' S ', ' SE']
		]
		if !@moves.nil?
			@moves.times do |move|
				
			end
		end
	end

	def update_board(x = nil, y = nil)
		coordinates = set_coordinates(x,y)
		if @moves.nil?
			@moves = Array.new(3) { Array.new(3) }
		end
		print "\n"
		3.times do |vertical|
			print "       "
			3.times do |horizontal|
				print @moves[horizontal][vertical].nil? ? coordinates[vertical][horizontal] : moves[horizontal][vertical]
				print " | " unless horizontal == 2
			end
			print "\n"
			print "    --------------------\n" unless vertical == 2
		end
		print "\n"

	end

	def handle_move(move)
		case move.downcase
			when 'nw'
				update_board(0,2)
			when 'sw'
				update_board(0,0)
			when 'w'
				update_board(0,1)
			when 'n'
				update_board(1,3)
			when 's'
				update_board(1,0)
			when 'ne'
				update_board(2,2)
			when 'c'
				update_board(1,1)
			when 'e'
				update_board(2,1)
			when 'se'
				update_board(2,0)
		end
	end

	def print_board(moves)
 
	puts"""
	\t NW | N | NE  
	\t-------------
	\t  W | C | E
	\t-------------
	\t SW | S | SE

	"""

	end
end

def print_interaction(current_game)
	puts "\n=====================================================================\n "
	puts "It is your turn, #{current_game.players[current_game.turn.to_i][:name]}"
	puts "What will your movement be?"
end

def game_action(current_game)
	while !current_game.game_over
		print_interaction(current_game)
		move = gets.chomp
		current_game.handle_move(move)
	end
end

def game_init()
	players = []
	puts "Welcome to the most awesome Tic-Tac-Toe game of all time homie"
	puts "Give me the name of the first player, if you will"
	first_player_name = gets.chomp
	first_player = {id:0, name: first_player_name}
	players.push(first_player)
	puts "Thank you, #{first_player_name}. Now give me the name of the other player bro"
	second_player_name = gets.chomp
	second_player = {id:1,name:second_player_name}
	players.push(second_player)
	puts "Nooice, #{second_player_name}. We got ourselves a game!"
	current_game = Game.new(players)
	game_action(current_game)
end

game_init()