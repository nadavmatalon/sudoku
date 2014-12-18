module PuzzleGenerator

  def generate_puzzle(level)
    reset_puzzle
    create_seed
    solve ? set_solution && punch_to(level) : generate_puzzle(level)
  end

  def reset_puzzle
    @puzzle = Array.new(81, 0)
  end

  def create_seed
    for sead_box in seed_indices
      seed_values = (1..9).to_a.shuffle
      sead_box.each_with_index { |seed, index| @puzzle[seed] = seed_values[index] }
    end
  end

  def seed_indices
    boxes(indexed).select.with_index { |box, index| box if [0, 4, 8].include?(index) }
  end

  def set_solution
    @solution = puzzle.join.chars.map(&:to_i)
  end

  def punch_to(level)
    num_of_punches = level * 10 + 21
    while num_of_punches > 0
      random_square = rand(0..80)
      (puzzle[random_square] = 0 and num_of_punches -= 1) if solved_at?(random_square)
    end
  end
end
