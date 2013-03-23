require './board'
require './interface'

class Reversi
	def initialize
		@interface = ReversiInterface.new(self)
		@board = Board.new
	end
	def board
		@board.board
	end
	def play
		turn = :white
		until win?
			@interface.print_board(board)
			valid_moves = @board.valid_moves
			if valid_moves.empty?
				@interface.pass_turn(turn) 
			else
				move = @interface.get_move(turn, valid_moves)
			end
			@board.make_move(move, turn)
			turn = switch(turn)
		end
		#play loop
	end
	def win?
		false
	end
	def switch(turn)
		turn == :white ? :black : :white
	end
end

game = Reversi.new
game.play