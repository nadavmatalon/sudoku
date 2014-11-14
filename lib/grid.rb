class Grid

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

	def fully_solved?
		return true unless puzzle.include? 0
	end

	def puzzle_rows
		puzzle.each_slice(9).to_a
	end

	def puzzle_columns
		puzzle_rows.transpose
	end

	def puzzle_boxes
		(0..2).reduce([]) do |boxes, index|
			selected_rows = puzzle_rows.slice(3 * index, 3)
			boxes + selected_rows.transpose.each_slice(3).map(&:flatten)
		end
	end

	def peer_values_of index
		peers = puzzle_rows[index/9] + puzzle_columns[index%9] + puzzle_boxes[find_box_of(index)]
		peers.flatten.sort.uniq.reject { |value| value == (0 or value_of(index)) }
	end

	def find_box_of index
		new_grid, new_grid.puzzle = self.clone, Array.new(81) { |index| index }
		new_grid.puzzle_boxes.map { |boxes| boxes & [index] }.map.with_index { |box ,index| index unless box.empty? }.compact[0]
	end

	def candidates_for index
		candidates = (1..9).to_a - peer_values_of(index)
		candidates.sort if !solved_at?(index)
	end

	def solve_at index
		solutions = candidates_for(index) || []
		set_value_at(index, solutions.first) if solutions.count == 1
	end

	def solve
		first_attempt_to_solve
		second_attempt_to_solve unless fully_solved?
		fully_solved?
	end

	def first_attempt_to_solve
		current_puzzle_state, stop_looping = 81, false
		while !fully_solved? && !stop_looping
			new_puzzle_state = solve_all_squares
			stop_looping = true if current_puzzle_state == new_puzzle_state
			current_puzzle_state = new_puzzle_state
		end
	end

	def second_attempt_to_solve
		empty_index = find_first_empty_index
 		candidates_for(empty_index).each do |candidate|
			set_value_at empty_index, candidate
			grid = self.class.new(self.puzzle_to_str)
			upload grid.puzzle_to_str and return if grid.solve
		end
	end

	def solve_all_squares
		puzzle.each_with_index { |square, index| solve_at(index) }
		puzzle.count { |value| value != 0 }
	end

	def find_first_empty_index
		puzzle.map.with_index { |value, index| index if value == 0 }.compact.first
	end

	def str_for_print
		separator = '-' * 21 + "\n"
		rows = puzzle_rows.each { |row| row.insert(3, '|').insert(7, '|').insert(11, "\n").join(' ') }
		rows.insert(3, separator).insert(7, separator).join(' ').prepend("\n ").concat("\n")
	end
end

