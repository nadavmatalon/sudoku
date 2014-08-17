require './lib/grid.rb'

class PuzzleGenerator

	def self.generate_puzzle (level = 3)
		seed = [0] * 81
		box1, box2, box3 = generate_box, generate_box, generate_box
    	seed[0..2], seed[9..11], seed[18..20] = box1[0..2], box1[3..5], box1[6..8]
    	seed[30..32], seed[39..41], seed[48..50] = box2[0..2], box2[3..5], box2[6..8]
		seed[60..62], seed[69..71], seed[78..80] = box3[0..2], box3[3..5], box3[6..8]
		grid = Grid.new seed.join
		if grid.solve == "COULDN'T SOLVE IT!"
			self.generate_puzzle level
		else
			completed_puzzle = grid.current_state
			punched_puzzle = punch completed_puzzle, (level * 10 + 21)
		end
		grid = Grid.new punched_puzzle
		grid.solve == "SOLVED IT!" ? punched_puzzle : self.generate_puzzle(level)
	end

	def self.punch puzzle, punches
		while punches != 0
			random_index = rand(0..80)
		 	if puzzle[random_index] != "0" 
		 		puzzle[random_index] = "0"
		 		punches -= 1
		 	end
		 end
		 puzzle
	end 

	def self.generate_box 
		(1..9).sort_by{rand}
	end
end
