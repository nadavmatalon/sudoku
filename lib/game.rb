require_relative 'puzzle'

class Game

  attr_reader :puzzle

  def initialize(level = 3)
    new_puzzle(level)
  end

  def new_puzzle(level = 3)
    @puzzle = Puzzle.new
    puzzle.upload_new_puzzle(level)
  end

  def puzzle_str
    puzzle.to_str
  end

  def solve_puzzle
    puzzle.solve
  end

  def puzzle_solved?
    puzzle.solved?
  end

  def print_puzzle
    puts(puzzle.str_for_print)
  end
end


