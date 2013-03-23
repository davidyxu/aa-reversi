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
		position = new_piece.dup
		until position == flanking_piece
			position[0] += vector[0]
			position[1] += vector[1]
			@board[position[0]][position[1]] = color
		end
	end

	def search_in_one_direction(new_piece, vector, color = :empty)
		position = new_piece.dup
		position[0] += vector[0]
		position[1] += vector[1]
		until out_of_bounds?(position)
			return position if color == :empty && self[position].nil?
			return position if self[position] == color
			position[0] += vector[0]
			position[1] += vector[1]
		end
		false
	end

	def out_of_bounds?(position)
		position[0] < 0 || position[0] > 7 || position[1] < 0 || position[1] > 7
	end

	def first_four_moves
		[3,4].product([4,3]).select { |position| self[position].nil? }
	end

	def valid_moves(color)
		valid_moves = first_four_moves
		if valid_moves.empty?
			pieces_of(color).each do |piece|
				vectors_of_interest = search_adjacent_of(piece, opposite_color(color))
				vectors_of_interest.each do |vector|
					possible_flank = search_in_one_direction(piece, vector)
					valid_moves << possible_flank if possible_flank
				end
			end
		end
		valid_moves.uniq
	end

	def opposite_color(color)
		color == :white ? :black : :white
	end

	def search_adjacent_of(piece, color)
		vectors_of_interest = []
		@vectors.each do |vector|
			position = [piece[0]+vector[0], piece[1]+vector[1]]
			vectors_of_interest << vector if self[position] == color
		end
		vectors_of_interest
	end

	def pieces_of(color)
		pieces = []
		@board.each_with_index do |row, row_index|
			row.each_with_index do |square, col_index|
				pieces << [row_index, col_index] if square == color
			end
		end
		pieces
	end

	def make_move(position, color)
		@board[position[0]][position[1]] = color
		@vectors.each do |vector|
			flank = search_in_one_direction(position, vector, color)
			flip(position, flank, vector, color) if flank
		end
	end
end