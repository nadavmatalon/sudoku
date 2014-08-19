require './lib/square.rb'

class Grid

	NUMBER_OF_COLUMNS = 9
	NUMBER_OF_ROWS = 9
	NUMBER_OF_BOXES = 9
	NUMBER_OF_SQUARES = 81

	EASY_PUZZLE = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'
	MEDIUM_PUZZLE = '000200001060075000057004060900000608000080000005630040500003000002000930708000014'
	HARD_PUZZLE = '800000000003600000070090200050007000000045700000100030001000068008500010090000400'

	attr_reader :squares

	def initialize (puzzle = nil)
		@squares = generate_squares
		upload puzzle unless puzzle.nil?
	end
 
	def generate_squares
 		squares, row, column, box, value = [], 1, 1, 1, 0
		for index in 1..NUMBER_OF_SQUARES do
			squares << Square.new(index - 1, row, column, box, value)
			column < 9 ? column += 1 : (column = 1 ; row += 1)
			box += 1 if ((column - 1) % 3) == 0
			box = 1 if index % 9 == 0 && row <= 3
			box = 4 if index % 9 == 0 && row >= 4 && row <= 6
			box = 7 if index % 9 == 0 && row >= 7
		end 
		squares		
 	end

  	def upload puzzle
		squares.each_with_index { |sq, i| sq.value = puzzle.chars[i].to_i }
  	end	

	def peers_for index
		selected = squares[index]
		row, column, box = selected.row, selected.column, selected.box
		peers = squares.select { |sq| sq if sq.row == row || sq.column == column || sq.box == box }
 	 	peers - [selected]
	end

	def values_of peers
		peers.map { |peer| peer.value unless peer.value == 0 }.compact.uniq.sort
	end

	def candidates_for index
		candidates = (1..9).to_a - values_of(peers_for index)
		unsolved?(index) ? candidates.sort : []
	end

	def unsolved? index
		squares[index].value == 0
	end

  	def fully_solved?
  		squares.count(&:unsolved?) == 0
  	end

	def solve 
		start_time, current_state, stop_looping = Time.now, NUMBER_OF_SQUARES, false
		while !fully_solved? && !stop_looping
			squares.each { |square| solve_square_in square.index }
			new_state = squares.count(&:solved?)
			stop_looping = true if current_state == new_state || Time.now - start_time > 0.75
			current_state = new_state
		end
		try_again unless fully_solved? || Time.now - start_time > 1.50
		fully_solved? ? "SOLVED IT!" : "COULDN'T SOLVE IT!"
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
			grid = duplicate
			grid.solve
			upload_solution_to grid and return if grid.fully_solved?
		end
	end

	def duplicate
		self.class.new(self.current_state)
	end

  	def current_state 
  		squares.map {|square| square.value}.join
  	end

	def upload_solution_to grid
		upload grid.current_state
	end

	def print_in_terminal
 		puts ""
		squares.select  do |square|
			index = square.index + 1
			print square.value.to_s + " "
			print "| " if index % 3 == 0 && index % 9 != 0
			puts "" if index % 9 == 0
			puts "-" * 21 if index % 27 == 0 && index != NUMBER_OF_SQUARES
		end
		puts ""
	end	
end

