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
end
