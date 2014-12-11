class Puzzle_Solver < Puzzle; include PuzzleSolver; end

describe 'PuzzleSolver' do

  let (:empty_puzzle) { Puzzle_Solver.new }
  let (:unsolved_puzzle) { Puzzle_Solver.new(UNSOLVED_PUZZLE) }
  let (:solved_puzzle) { Puzzle_Solver.new(SOLVED_PUZZLE) }
  let (:erroneously_solved_puzzle) { Puzzle_Solver.new(ERR_PUZZLE) }

  context 'Square' do

    context 'Candidates' do

      it 'can find solution candidates for a square' do
        expect(unsolved_puzzle.candidates_for(11)).to eq [4]
      end

      it 'returns nil if a square has no solution candidates' do
        expect(unsolved_puzzle.candidates_for(0)).to eq nil
      end
    end

    context 'Find Unsolved Square' do

      it 'can find the index of the first unsolved square' do
        expect(empty_puzzle.first_unsolved_square).to eq 0
        expect(unsolved_puzzle.first_unsolved_square).to eq 8
      end

      it 'should return nil if no unsolved squares' do
        expect(solved_puzzle.first_unsolved_square).to eq nil
      end
    end

    context 'Solution' do

      it 'knows if a square is solved' do
        expect(solved_puzzle.solved_at?(0)).to be true
      end

      it 'knows if a square is not solved' do
        expect(empty_puzzle.solved_at?(0)).to be false
      end
    end

    context 'Counting' do
      it 'can count the number of solved squares' do
        expect(empty_puzzle.solved_squares_count).to eq 0
        expect(unsolved_puzzle.solved_squares_count).to eq 50
        expect(solved_puzzle.solved_squares_count).to eq 81
      end
    end
  end

  context 'Puzzle' do

    context 'Solution Status' do

      it 'knows if a puzzle is not fully solved' do
        expect(empty_puzzle.solved?).to be false
        expect(unsolved_puzzle.solved?).to be false
      end

      it 'knows if a puzzle is erroneously solved' do
        expect(erroneously_solved_puzzle.solved?).to be false
      end

      it 'knows if a puzzle is fully solved' do
        expect(solved_puzzle.solved?).to be true
      end
    end

    context 'Solving' do

      it 'can solve a puzzle' do
        expect(unsolved_puzzle.solve).to be true
      end

      it 'can solve a very easy puzzle' do
        expect(Puzzle_Solver.new(VERY_EASY_PUZZLE).solve).to be true
      end

      it 'can solve an easy puzzle' do
        expect(Puzzle_Solver.new(EASY_PUZZLE).solve).to be true
      end

      it 'can solve a medium puzzle' do
        expect(Puzzle_Solver.new(MEDIUM_PUZZLE).solve).to be true
      end

      it 'can solve a hard puzzle' do
        expect(Puzzle_Solver.new(HARD_PUZZLE).solve).to be true
      end

      it 'can solve a very hard puzzle' do
        expect(Puzzle_Solver.new(VERY_HARD_PUZZLE).solve).to be true
      end

      it 'can solve an empty puzzle' do
        empty_puzzle.solve
        expect(empty_puzzle.solved?).to be true
      end

      it 'cannot solve an impossible puzzle' do
        expect(Puzzle_Solver.new(IMPOSSIBLE_PUZZLE).solve).to be false
      end
    end
  end

  it 'can generate a new very easy puzzle and solve it' do
    empty_puzzle.upload_new_puzzle(1)
    empty_puzzle.solve
    expect(empty_puzzle.solved?).to be true
  end

  it 'can generate a new easy puzzle and solve it' do
    empty_puzzle.upload_new_puzzle(2)
    empty_puzzle.solve
    expect(empty_puzzle.solved?).to be true
  end

  it 'can generate a new medium puzzle and solve it' do
    empty_puzzle.upload_new_puzzle(3)
    empty_puzzle.solve
    expect(empty_puzzle.solved?).to be true
  end

  it 'can generate a new hard puzzle and solve it' do
    empty_puzzle.upload_new_puzzle(4)
    empty_puzzle.solve
    expect(empty_puzzle.solved?).to be true
  end

  it 'can generate a new very hard puzzle and solve it' do
    empty_puzzle.upload_new_puzzle(5)
    empty_puzzle.solve
    expect(empty_puzzle.solved?).to be true
  end
end
