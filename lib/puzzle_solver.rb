module PuzzleSolver

  attr_reader :solution_arr

  def solve
    first_attempt
    second_attempt unless solved?
    solved? ? (set_solution and return true) : false
  end

  def first_attempt
    current_puzzle_state, stop_looping = 81, false
    until solved? || stop_looping
      solve_all_squares
      stop_looping = true if current_puzzle_state == solved_squares_count
      current_puzzle_state = solved_squares_count
    end
  end

  def second_attempt
    unsolved_index = first_unsolved_square
    candidates_for(unsolved_index).each do |candidate|
      puzzle_arr[unsolved_index] = candidate
      puzzle_clone = self.class.new
      puzzle_clone.upload(current_state)
      self.upload(puzzle_clone.current_state) and return if puzzle_clone.solve
    end
  end

  def solve_all_squares
    puzzle_arr.each_index { |index| solve_at(index) }
  end

  def solve_at(index)
    solutions = candidates_for(index) || []
    puzzle_arr[index] = solutions.first if solutions.count == 1
  end

  def solved_squares_count
    puzzle_arr.count { |square| square != 0 }
  end

  def first_unsolved_square
    puzzle_arr.index(0)
  end

  def candidates_for(index)
    candidates = (1..9).to_a - peers_of(index)
    candidates.sort unless solved_at?(index)
  end

  def solved_at?(index)
    puzzle_arr[index] != 0
  end

  def solved?
    (rows + columns + boxes).map { |values| values.sort == (1..9).to_a }.all?
  end
 
  def set_solution
    @solution_arr = puzzle_arr.join.chars.map(&:to_i)
  end

  def solution_str
    solution_arr ? solution_arr.join : ''
  end
end
