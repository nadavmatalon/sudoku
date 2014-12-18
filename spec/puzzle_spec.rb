describe Puzzle do

  let (:empty_puzzle)    { Puzzle.new }
  let (:unsolved_puzzle) { Puzzle.new(UNSOLVED_PUZZLE) }
  let (:solved_puzzle)   { Puzzle.new(SOLVED_PUZZLE)}
  let (:boxes_indices) {
    [
      [0, 9, 18, 1, 10, 19, 2, 11, 20],
      [3, 12, 21, 4, 13, 22, 5, 14, 23],
      [6, 15, 24, 7, 16, 25, 8, 17, 26],
      [27, 36, 45, 28, 37, 46, 29, 38, 47],
      [30, 39, 48, 31, 40, 49, 32, 41, 50],
      [33, 42, 51, 34, 43, 52, 35, 44, 53],
      [54, 63, 72, 55, 64, 73, 56, 65, 74],
      [57, 66, 75, 58, 67, 76, 59, 68, 77],
      [60, 69, 78, 61, 70, 79, 62, 71, 80]
    ]
  }

  context 'During Initialization' do

    it 'can be initialized as an empty puzzle' do
      expect{ empty_puzzle }.not_to raise_error
    end

    it 'can be initialized with a puzzle string' do
      expect{ unsolved_puzzle }.not_to raise_error
    end

    context 'Current State' do

      it 'is set to zeros if no puzzle string is given (default)' do
        expect(empty_puzzle.current_state).to eq ('0' * 81)
      end

      it 'is set to the puzzle string if given' do
        expect(unsolved_puzzle.current_state).to eq UNSOLVED_PUZZLE
      end
    end
  end

  context 'After Initialization' do

    it 'can have a new puzzle string uploaded' do
      empty_puzzle.upload(UNSOLVED_PUZZLE)
      expect(empty_puzzle.current_state).to eq UNSOLVED_PUZZLE
    end

    it "can return the indices of all it's squares" do
      indexed_arr = (0..80).to_a.each_slice(9).to_a
      expect(unsolved_puzzle.indexed).to eq indexed_arr
    end
  end

  context 'Rows' do

    it "can be split into individual rows" do
      expect(empty_puzzle.rows).to eq Array.new(9, Array.new(9, 0))
      expect(unsolved_puzzle.rows.first.join).to eq '786214590'
    end
  end

  context 'Columns' do

    it "can be split into individual columns" do
      expect(empty_puzzle.columns).to eq Array.new(9, Array.new(9, 0))
      expect(unsolved_puzzle.columns.first.join).to eq '710243060'
    end
  end

  context 'Boxes' do

    it "can be split into individual boxes" do
      expect(empty_puzzle.boxes).to eq Array.new(9, Array.new(9, 0))
      expect(unsolved_puzzle.boxes.first.join).to eq '710850603'
    end

    it 'can find the indices of squares within each box' do
      indices = unsolved_puzzle.indexed
      expect(unsolved_puzzle.boxes(indices)).to eq boxes_indices
    end
  end

  context 'Squares' do

    it 'can find the peer values of a square' do
      expect(unsolved_puzzle.peers_of(0).sort).to eq (1..9).to_a
    end

    it 'returns an empty array if all peers have the value 0' do
      expect(empty_puzzle.peers_of(0)).to eq []
    end

    it "knows the box number of a square based on it's index" do
      squares = [10, 13, 16, 37, 40, 43, 64, 67, 70]
      squares.each_with_index do |square, index| 
        expect(unsolved_puzzle.box_of(square)).to eq index
      end
    end
  end

  context 'STDN Output' do

    it "can output it's curent state as a printable string" do
      puts unsolved_puzzle.str_for_print
    end
  end
end
