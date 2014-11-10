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

end
