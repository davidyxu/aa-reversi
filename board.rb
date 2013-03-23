class Board
	attr_reader :board
	def initialize
		@board = Array.new(8) { Array.new(8) }
		@vectors = [-1,0,1].product([-1,0,1])
		self[[3,4]] = :black
	end

	def [](position)
		@board[position[0]][position[1]]
	end

	def []=(position, color)
		@board[position[0]][position[1]] = color
	end

	def flip(new_piece, flanking_piece, vector, color)

	end

	def search_in_one_direction(new_piece, vector, color)
		position = new_piece
		until out_of_bounds?(position)
			position[0] += vector[0]
			position[1] += vector[1]
			return position if [position] == color
		end
		false
	end

	def out_of_bounds?(position)
		position[0] < 0 || position[0] > 7 || position[1] < 0 || position[1] > 7
	end
	def first_four_moves
		[3,4].product([4,3]).select { |position| self[position].nil? }# }
	end
	def valid_moves
		valid_moves = first_four_moves
		if valid_moves.empty?
			
			#stuff
		end
		valid_moves
		#return array of valid positions
	end

	def make_move(position, color)
		p position
		self[position] = color
		@vectors.each do |vector|
			flank = search_in_one_direction(position, vector, color)
			flip(position, flank, vector) if flank
		end
	end
end