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
		until over?
			@interface.print_board(board)
			valid_moves = @board.valid_moves(turn)
			if valid_moves.empty?
				@interface.pass_turn(turn) 
			else
				move = @interface.get_move(turn, valid_moves)
				@board.make_move(move, turn)
			end
			turn = switch(turn)
		end
		@interface.prompt_winner(winner)
	end
	def over?
		@board.valid_moves(:black).empty? && @board.valid_moves(:white).empty?
	end
	def winner
		black = @board.pieces_of(:black).length
		white = @board.pieces_of(:white).length
		return :black if black > white
		return :white if white > black
		return :draw if black == white
	end
	def switch(turn)
		turn == :white ? :black : :white
	end
end

game = Reversi.new
game.play