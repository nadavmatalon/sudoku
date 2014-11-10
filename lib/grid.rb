require './lib/square.rb'

class Grid

	NUMBER_OF_SQUARES = 81

	def initialize (puzzle = nil)
		generate_squares
		upload puzzle if puzzle
	end
 
	def squares 
		@squares ||= []
	end

	def generate_squares
		row, column, box, value = 1, 1, 1, 0
		for index in 1..NUMBER_OF_SQUARES do
			squares << Square.new(index - 1, row, column, box, value)
			column < 9 ? column += 1 : (column = 1 ; row += 1)
			box = set_box_value(index, row, column, box)
		end
	end 

 	def set_box_value index, row, column, box
		box += 1 if ((column - 1) % 3) == 0
		box = 1 if index % 9 == 0 && row <= 3
		box = 4 if index % 9 == 0 && row >= 4 && row <= 6
		box = 7 if index % 9 == 0 && row >= 7
		box
	end

  	def upload puzzle
		squares.each_with_index { |square, index| square.value = puzzle.chars[index].to_i }
  	end	

	def peers_for selected_square
		row, column, box = selected_square.row, selected_square.column, selected_square.box
		peers = squares.select { |square| square if square.row == row || square.column == column || square.box == box }
 	 	peers - [selected_square]
	end

	def values_of peers
		peers.map { |peer| peer.value unless peer.value == 0 }.compact.uniq.sort
	end

	def candidates_for index
		candidates = (1..9).to_a - values_of(peers_for squares[index])
		unsolved?(index) ? candidates.sort : []
	end

	def unsolved? index
		squares[index].value == 0
	end

  	def fully_solved?
  		squares.count(&:unsolved?) == 0
  	end

	def solve
		start_time = Time.now
		first_attempt start_time
		try_again unless fully_solved? || too_much_time_since(start_time, 1.50)
		fully_solved? ? 'SOLVED IT!' : 'COULDN\'T SOLVE IT!'
	end

	def first_attempt start_time
		current_state, stop_looping = NUMBER_OF_SQUARES, false
		while !fully_solved? && !stop_looping
			squares.each { |square| solve_square_in square.index }
			new_state = squares.count(&:solved?)
			stop_looping = true if current_state == new_state || too_much_time_since(start_time, 0.75)
			current_state = new_state
		end
	end

	def too_much_time_since start_time, interval_in_seconds
		Time.now - start_time > interval_in_seconds
	end

  	def solve_square_in index
  		if unsolved? index
  			candidates = candidates_for index
  			squares[index].value = candidates.first if candidates.count == 1
  		end
	end

	def legit_solution? index, value
		candidates = candidates_for index
		candidates.include? value
	end

	def try_again
		empty_square = squares.reject(&:solved?).first
		candidates = candidates_for empty_square.index
		candidates.each do |candidate|
			empty_square.set candidate
			grid = self.class.new(self.current_state)
			grid.solve
			upload grid.current_state and return if grid.fully_solved?
		end
	end

  	def current_state 
  		squares.map {|square| square.value}.join
  	end

	def print_in_terminal
 		puts grid_str_for_print
	end	

	def grid_str_for_print
	 	rows = current_state.chars.each_slice(9).map do |row|
	 		row.insert(3, '|').insert(7, '|').insert(11, "\n").join(' ')
	 	end
		separator = '-' * 21 + "\n"
		rows.insert(3, separator).insert(7, separator).join(' ').insert(0, ' ')
	end

	def map_random_values_to box_number
		random_values = (1..9).sort_by { rand }
		selected_squares = find_square_indexes_of box_number
		selected_squares.each_with_index { |square, index| squares[square].value = random_values[index] }
	end

	def find_square_indexes_of box_number
		squares.map { |square | square.index if square.box == box_number }.compact
	end

end

