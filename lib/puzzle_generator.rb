require './lib/grid.rb'

class PuzzleGenerator

	def self.generate_puzzle (level = 3)
		grid = Grid.new
		[1, 5, 9].map { |box_number| grid.map_random_values_to box_number }
		grid.solve == 'SOLVED IT!' ? new_puzzle = punch(grid.current_state, (level * 10 + 21)) : (self.create_puzzle level)
		(Grid.new new_puzzle).solve == 'SOLVED IT!' ? new_puzzle : (self.create_puzzle level)
	end

	def self.punch puzzle, punches
		while punches != 0
			random_index_pick = rand(0..80)
		 	if puzzle[random_index_pick] != '0' 
		 		puzzle[random_index_pick] = '0'
		 		punches -= 1
		 	end
		 end
		 puzzle
	end 

	def self.generate_box 
		(1..9).sort_by { rand }
	end

	def self.solve grid
		start_time, current_state, stop_looping = time_now, Grid::NUMBER_OF_SQUARES, false
		while !grid.fully_solved? && !stop_looping
			grid.squares.each { |square| grid.solve_square_in square.index }
			new_state = grid.squares.count(&:solved?)
			stop_looping = true if current_state == new_state || grid.too_much_time_since(start_time, 0.75)
			current_state = new_state
		end
		grid.try_again unless grid.fully_solved? || grid.too_much_time_since(start_time, 1.50)
		grid.fully_solved?
	end

	def self.time_now
		Time.now
	end

end
