class Player
	attr_reader :color
	def initialize(color)
		@color = color
	end

	def get_move
	end
end

class HumanPlayer < Player
	def initialize(color)
		super(color)
    @letter_to_number = {}
    ('a'..'h').each_with_index do |letter, number|
      @letter_to_number[letter] = number
    end
	end

	def coordinate_to_input(position)
		converted = @letter_to_number.key(position[1])
		converted += (position[0]+1).to_s
		converted
	end

	def prompt_valid_moves(valid_moves)
		move_coordinates = []
		valid_moves.each do |move|
			move_coordinates << coordinate_to_input(move)
		end
		puts "Valid positions to place are: #{move_coordinates}"
	end
	def get_move(valid_moves)
		puts "#{@color.capitalize} player's turn:"
		prompt_valid_moves(valid_moves)
		move = input_to_coordinate(gets.chomp)
		get_move(valid_moves) unless valid_moves.include?(move)
		move
	end

	def input_to_coordinate(position)
		return false if position.length != 2
		converted = []
		converted[1] = @letter_to_number[position[0]]
		converted[0] = position[1].to_i-1
		converted
	end
end
