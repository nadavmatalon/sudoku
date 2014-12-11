module PuzzleSolver

  def candidates_for(index)
    candidates = (1..9).to_a - peers_of(index)
    candidates.sort unless solved_at?(index)
  end

  def solved_at?(index)
    puzzle[index] != 0
  end

  def solve_at(index)
    solutions = candidates_for(index) || []
    puzzle[index] = solutions.first if solutions.count == 1
  end

  def solved?
    (rows + columns + boxes).map { |values| values.sort == (1..9).to_a }.all?
  end

  def solve
    first_attempt
    second_attempt unless solved?
    solved?
  end

  def first_attempt
    current_puzzle_state, stop_looping = 81, false
    until solved? || stop_looping
      solve_all_squares
      new_puzzle_state = solved_squares_count
      stop_looping = true if current_puzzle_state == new_puzzle_state
      current_puzzle_state = new_puzzle_state
    end
  end

  def second_attempt
    unsolved_index = first_unsolved_square
    candidates_for(unsolved_index).each do |candidate|
      puzzle[unsolved_index] = candidate
      puzzle_clone = self.class.new(self.to_str)
      upload(puzzle_clone.to_str) and return if puzzle_clone.solve
    end
  end

  def solve_all_squares
    puzzle.each_index { |index| solve_at(index) }
  end

  def solved_squares_count
    puzzle.count { |square| square != 0 }
  end

  def first_unsolved_square
    puzzle.index(0)
  end
end
