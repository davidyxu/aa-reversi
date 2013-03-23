require './player'

class ReversiInterface
	def initialize(board, white = :human, black = :human)
		@white = create_player(white, :white)
		@black = create_player(black, :black)
	end

	def get_move(turn, valid_moves)
		case turn
		when :white then @white.get_move(valid_moves)
		when :black then @black.get_move(valid_moves)
		end
	end

	def pass_turn(turn)
		print "#{turn.capitalize} player has no valid moves."
	end

	def create_player(type, color)
		case type
		when :human then HumanPlayer.new(color)
		end
	end

	def prompt_winner(winner)
		case winner
		when :draw then puts "Draw!"
		else
			puts "#{winner.capitalize} player is the winner."
		end
	end

	def print_border_letters
		print " "
		('a'..'h').each { |letter| print " #{letter} " }
		puts
	end

	def print_board(board)
		print_border_letters
		board.each_with_index do |row, index|
			print "#{index+1}"
			row.each do |square|
				case square
				when nil then print "   "
				when :black then print " X "
				when :white then print " O "
				end
			end
			puts
		end
	end
end