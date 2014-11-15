class Grid

	DIAGONAL_BOXES_INDICES = [
		[0, 1, 2, 9, 10, 11, 18, 19, 20], 
		[30, 31, 32, 39, 40, 41, 48, 49, 50], 
		[60, 61, 62, 69, 70, 71, 78, 79, 80]
	]

	attr_accessor :puzzle

	def initialize (puzzle = '0' * 81)
		upload puzzle
	end

	def upload puzzle
		@puzzle = puzzle.chars.map(&:to_i)
	end

	def get_value_at index
		puzzle[index]
	end

	def set_value_at index, value
		puzzle[index] = value
	end

	def puzzle_to_str
		@puzzle.join
	end

	def solved_at? index
		get_value_at(index) != 0
	end

	def puzzle_solved?
		square_values = puzzle_rows + puzzle_columns + puzzle_boxes
		square_values.map { |values| values.sort == (1..9).to_a }.all?
	end

	def puzzle_rows
		puzzle.each_slice(9).to_a
	end

	def puzzle_columns
		puzzle_rows.transpose
	end

	def puzzle_boxes
		(0..2).reduce([]) do |boxes, index|
			boxes + puzzle_rows.slice(3 * index, 3).transpose.each_slice(3).map(&:flatten)
		end
	end

	def peer_values_of index
		peers = puzzle_rows[index/9] + puzzle_columns[index%9] + puzzle_boxes[box_of(index)]
		peers.flatten.sort.uniq.reject { |value| value == (0 or value_of(index)) }
	end

	def box_of index
		grid_clone, grid_clone.puzzle = self.clone, (0..80).to_a
		grid_clone.puzzle_boxes.map { |boxes| boxes & [index] }.index([index])
	end

	def candidates_for index
		candidates = (1..9).to_a - peer_values_of(index)
		candidates.sort if !solved_at?(index)
	end

	def solve_at index
		solutions = candidates_for(index) || []
		set_value_at(index, solutions.first) if solutions.count == 1
	end

	def solve_puzzle
		first_attempt_to_solve
		second_attempt_to_solve unless puzzle_solved?
		puzzle_solved?
	end

	def first_attempt_to_solve
		current_puzzle_state, stop_looping = 81, false
		while !puzzle_solved? && !stop_looping
			new_puzzle_state = solve_all_squares
			stop_looping = true if current_puzzle_state == new_puzzle_state
			current_puzzle_state = new_puzzle_state
		end
	end

	def second_attempt_to_solve
		empty_index = find_first_unsolved_square
 		candidates_for(empty_index).each do |candidate|
			set_value_at empty_index, candidate
			grid = self.class.new(self.puzzle_to_str)
			upload grid.puzzle_to_str and return if grid.solve_puzzle
		end
	end

	def solve_all_squares
		puzzle.each_with_index { |square, index| solve_at(index) }
		puzzle.count { |square| square != 0 }
	end

	def find_first_unsolved_square
		puzzle.index(0)
	end

	def upload_new_puzzle (level = 3)
		upload_new_puzzle_seed
		solve_puzzle ? punch_puzzle(level * 10 + 21) : upload_new_puzzle(level)
	end

	def upload_new_puzzle_seed
		puzzle = Array.new(81, 0)
		for index in 0..2
			new_values = (1..9).to_a.shuffle
			DIAGONAL_BOXES_INDICES[index].map.with_index { |square, position| set_value_at(square, new_values[position]) }
		end
	end

	def punch_puzzle punches
		while punches > 0
			random_square = rand(0..80)
			set_value_at(random_square, 0) and punches -= 1 if solved_at?(random_square)
		end
	end

	def str_for_print
		separator = '-' * 21 + "\n"
		rows = puzzle_rows.each { |row| row.insert(3, '|').insert(7, '|').insert(11, "\n").join(' ') }
		rows.insert(3, separator).insert(7, separator).join(' ').prepend("\n ").concat("\n")
	end
end

