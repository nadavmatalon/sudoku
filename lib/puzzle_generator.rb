module PuzzleGenerator

  def upload_new_puzzle(level = 3)
    reset_puzzle if valid?(level)
    create_seed
    solve ? punch(level * 10 + 21) : upload_new_puzzle(level)
  end

  def create_seed
    for sead_box in seed_indices
      seed_values = (1..9).to_a.shuffle
      sead_box.each_with_index { |seed, index| @puzzle[seed] = seed_values[index] }
    end
  end

  def reset_puzzle
    @puzzle = Array.new(81, 0)
  end

  def seed_indices
    boxes(indexed).select.with_index { |box, index| box if [0, 4, 8].include?(index) }
  end

  def punch(num_of_punches)
    while num_of_punches > 0
      random_square = rand(0..80)
      (puzzle[random_square] = 0 and num_of_punches -= 1) if solved_at?(random_square)
    end
  end

  private

  def valid?(level)
    type_err_msg = 'Argument must be Fixnum between 1-5'
    fail(TypeError, type_err_msg) unless (1..5).include?(level)
  end
end
