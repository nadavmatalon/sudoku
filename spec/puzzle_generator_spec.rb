class Puzzle_Generator < Puzzle; include PuzzleSolver, PuzzleGenerator; end

describe 'PuzzleGenerator' do

  let (:seed_boxes_indices) {
    [
      [0, 9, 18, 1, 10, 19, 2, 11, 20], 
      [30, 39, 48, 31, 40, 49, 32, 41, 50], 
      [60, 69, 78, 61, 70, 79, 62, 71, 80]
    ]
  }
  let (:empty_puzzle)    { Puzzle_Generator.new }
  let (:unsolved_puzzle) { Puzzle_Generator.new(UNSOLVED_PUZZLE) }
  let (:solved_puzzle)   { Puzzle_Generator.new(SOLVED_PUZZLE) }

  context 'Puzzle' do

    context 'Reset' do

      it 'can reset a puzzle' do
        unsolved_puzzle.reset_puzzle
        expect(unsolved_puzzle.current_state).to eq '0' * 81
      end
    end

    context 'Seed' do

      it 'knows the indices of the seed boxes' do
        expect(empty_puzzle.seed_indices).to eq seed_boxes_indices
      end

      it 'can create a new random seed' do
        empty_puzzle.create_seed
        expect(empty_puzzle.solved_squares_count).to eq 27
      end
    end

    context 'Punching' do

      it 'can randomly punch a fully solved puzzle' do
        solved_puzzle.punch_to(1)
        expect(solved_puzzle.solved_squares_count).to eq 50
      end
    end

    context 'Creation' do

      it 'can be done with the default difficulty level' do
        expect{ empty_puzzle.generate_puzzle }.not_to raise_error
      end

      it 'can be doen with a specified difficulty level' do
        expect{ empty_puzzle.generate_puzzle(1) }.not_to raise_error
      end

      it 'can only be done with a single difficulty level' do
        expect{ empty_puzzle.generate_puzzle(1, 2) }.to raise_error(ArgumentError)
      end

      it 'can only be done with a premitted difficulty level' do
        arg_err_msg = 'Argument must be Fixnum between 1-5'
        invalid_args = [ 0, 6, '1', :a, [1], {'a' => 1} ]
        invalid_args.each do |arg|
          expect{ empty_puzzle.generate_puzzle(arg) }.to raise_error(ArgumentError, arg_err_msg)
        end
      end

      context 'Setting Difficulty Level' do

        it 'can generate a very easy puzzle' do
          empty_puzzle.generate_puzzle(1)
          expect(empty_puzzle.solved_squares_count).to eq 50
        end

        it 'can generate an easy puzzle' do
          empty_puzzle.generate_puzzle(2)
          expect(empty_puzzle.solved_squares_count).to eq 40
        end

        it 'can generate a medium puzzle' do
          empty_puzzle.generate_puzzle(3)
          expect(empty_puzzle.solved_squares_count).to eq 30
        end

        it 'can generate a hard puzzle' do
          empty_puzzle.generate_puzzle(4)
          expect(empty_puzzle.solved_squares_count).to eq 20
        end

        it 'can generate a very hard puzzle' do
          empty_puzzle.generate_puzzle(5)
          expect(empty_puzzle.solved_squares_count).to eq 10
        end

        it 'generates a medium puzzle by default' do
          empty_puzzle.generate_puzzle
          expect(empty_puzzle.solved_squares_count).to eq 30
        end
      end
    end
  end
end
