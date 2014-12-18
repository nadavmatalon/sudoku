require_relative 'puzzle_generator'
require_relative 'puzzle_solver'

class Puzzle

  include PuzzleGenerator, PuzzleSolver

  attr_reader :puzzle, :solution

  def initialize
    @puzzle = Array.new(81, 0)
    @solution = Array.new(81, 0)
  end

  def upload(puzzle_str)
    @puzzle = puzzle_str.chars.map(&:to_i)
  end

  def rows
    puzzle.each_slice(9).to_a
  end

  def columns
    rows.transpose
  end

  def boxes(values = rows)
    (0..2).inject([]) do |boxes, index|
      boxes + values.slice(3 * index, 3).transpose.each_slice(3).map(&:flatten)
    end
  end

  def peers_of(index)
    peers = rows[index/9] + columns[index%9] + boxes[box_of(index)]
    peers.flatten.sort.uniq.reject { |value| value == (0 or value_of(index)) }
  end

  def box_of(index)
    boxes(indexed).map { |boxes| boxes & [index] }.index([index])
  end

  def indexed
    puzzle.map.with_index { |_, index| index }.each_slice(9).to_a
  end

  def to_str
    puzzle.join
  end

  def str_for_print
    separator = '-' * 21 + "\n"
    squares = rows.each { |row| row.insert(3, '|').insert(7, '|').insert(11, "\n").join(' ') }
    squares.insert(3, separator).insert(7, separator).join(' ').prepend("\n ").concat("\n")
  end

 private

  def valid?(level)
    type_err_msg = 'Argument must be Fixnum between 1-5'
    fail(TypeError, type_err_msg) unless (1..5).include?(level)
  end
end
