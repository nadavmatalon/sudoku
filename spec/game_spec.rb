describe Game do

  let (:game) { Game.new }

  context 'During Initialization' do

    it 'can be done with the default difficulty level' do
      expect{ game }.not_to raise_error
    end

    it 'can be doen with a specified difficulty level' do
      expect{ Game.new(1) }.not_to raise_error
    end

    it 'can only be done with a single difficulty level' do
      expect{ Game.new(1, 2) }.to raise_error ArgumentError
    end

    it 'can only be done with a premitted difficulty level' do
      type_err_msg = 'Argument must be Fixnum between 1-5'
      invalid_args = [ 0, 6, '1', :a, [1], {'a' => 1} ]
      invalid_args.each do |arg|
        expect{ Game.new(arg) }.to raise_error TypeError, type_err_msg
      end
    end

    it 'is done with a new puzzle by default' do
      expect(game.puzzle.class).to eq Puzzle
    end

    it 'is done with a medium level puzzle by defualt' do
      expect(game.puzzle.solved_squares_count).to eq 30
    end

    it 'can be done with a puzzle of any difficulty level' do
      for puzzle_level in 1..5
        expect{ Game.new(puzzle_level) }.not_to raise_error
      end
    end
  end

  context 'After Initialization' do

    context 'Puzzle' do 

      context 'Upload' do

        it 'can upload a new puzzle with the default difficulty level' do
          current_puzzle = game.puzzle.to_str
          game.new_puzzle
          expect(game.puzzle.to_str).not_to eq current_puzzle
          expect(game.puzzle.to_str.class).to eq String
          expect(game.puzzle.to_str.chars.count).to eq 81
        end

        it 'can upload a new puzzle with a specificed difficulty level' do
          current_puzzle = game.puzzle.to_str
          game.new_puzzle(1)
          expect(game.puzzle.to_str).not_to eq current_puzzle
          expect(game.puzzle.to_str.class).to eq String
          expect(game.puzzle.to_str.chars.count).to eq 81
        end
      end

      context 'Solution' do

        it "can solve it's current puzzle" do
          expect(game.solve_puzzle).to be true
        end
      end

      context 'Output' do

        it "can be return it's current puzzle as a String" do
          expect(game.puzzle_str.class).to eq String
          expect(game.puzzle_str.chars.count).to eq 81
        end
      end
    end
  end
end
