
describe Grid do

    let (:puzzle) { '786214590150369080003708416267093800490800601308500072072400300641035700000602054' }
    let (:very_easy_puzzle) { '009006080000457210021389465150802937090003801873005604980534006400701398300068540' }
    let (:easy_puzzle) { '630100009700030600490607130050300090947865000103000400829000570060798301071056000' }
    let (:medium_puzzle) { '810000000000100304050706018140300062005009800000000000020900405093810700406500000' }
    let (:hard_puzzle) { '008003000301000200029005000200070000000506400100040008000020000000090100000000800' }
    let (:very_hard_puzzle) { '000000700000000600300000100000006000000010000000070001000060500000000000000000000' }
    let (:impossible_puzzle) { '516849732307605000809700065135060907472591006968370050253186074684207500791050608' }
    let (:grid) { Grid.new }
    let (:grid_with_puzzle) { Grid.new puzzle }

    context 'puzzles' do

        context 'during initialization' do

            it 'grid can be initiallized without a puzzle' do
                expect { grid }.not_to raise_error
            end

            it 'grid is initialized with an empty puzzle if none is provided' do
                expect(grid.puzzle).to eq Array.new(81, 0)
            end
        end

        context 'after initialization' do

            it 'grid can have puzzle uploaded if it has an empty puzzle' do
                grid.upload puzzle
                expect(grid.puzzle.join).to eq puzzle
            end

            it 'grid can have puzzle uploaded even if it already has a puzzle' do
                grid_with_puzzle.upload easy_puzzle
                expect(grid_with_puzzle.puzzle.join).to eq easy_puzzle
            end
        end

        context 'current_state' do

            it 'grid can convert the current state of it\'s puzzle to a simple string' do
                expect(grid_with_puzzle.puzzle.join).to eq puzzle
            end

            it 'grid can convert the current state of it\'s puzzle to a printable string' do
                puts grid_with_puzzle.str_for_print
            end
        end

        context 'generation' do

            it 'grid can upload a new random puzzle seed' do
                grid.upload_new_puzzle_seed
                expect(grid.puzzle.select { |value| value == 0 }.count).to eq 54
            end

            it 'grid can upload a random puzzle' do
                grid.upload_new_puzzle
                expect(grid.puzzle.count).to eq 81
                expect(grid.puzzle.join).not_to eq ('0' * 81)
            end

            it 'grid uploads a medium puzzle (difficulty level 3) by default' do
                grid.upload_new_puzzle
                expect(grid.puzzle.select { |value| value == 0 }.count).to eq 51
            end

            it 'grid can generate a very easy puzzle (difficulty level 1)' do
                grid.upload_new_puzzle 1
                expect(grid.puzzle.select { |value| value == 0 }.count).to eq 31
            end

            it 'grid can generate an easy puzzle (difficulty level 2)' do
                grid.upload_new_puzzle 2
                expect(grid.puzzle.select { |value| value == 0 }.count).to eq 41
            end

            it 'grid can generate a medium puzzle (difficulty level 3)' do
                grid.upload_new_puzzle 3
                expect(grid.puzzle.select { |value| value == 0 }.count).to eq 51
            end

            it 'grid can generate a hard puzzle (difficulty level 4)' do
                grid.upload_new_puzzle 4
                expect(grid.puzzle.select { |value| value == 0 }.count).to eq 61
            end

            it 'grid can generate a very hard puzzle (difficulty level 5)' do
                grid.upload_new_puzzle 5
                expect(grid.puzzle.select { |value| value == 0 }.count).to eq 71
            end
        end

        context 'solution' do

            it 'grid can solve an empty puzzle' do
                expect(grid_with_puzzle.solve_puzzle).to be true
            end

            it 'grid can solve a very easy puzzle' do
                grid.upload very_easy_puzzle 
                expect(grid.solve_puzzle).to eq true
            end

            it 'grid can solve an easy puzzle' do
                grid.upload easy_puzzle 
                expect(grid.solve_puzzle).to eq true
            end

            it 'grid can solve a medium puzzle' do
                grid.upload medium_puzzle 
                expect(grid.solve_puzzle).to eq true
            end

            it 'grid can solve a hard puzzle' do
                grid.upload hard_puzzle 
                expect(grid.solve_puzzle).to eq true
            end

            it 'grid can solve a very hard puzzle' do
                grid.upload very_hard_puzzle 
                expect(grid.solve_puzzle).to eq true
            end

            it 'grid cannot solve an impossible puzzle' do
                grid.upload impossible_puzzle 
                expect(grid.solve_puzzle).to be_falsey
            end
        end
    end

    context 'squares' do

        context 'value' do

            it 'grid can get the value of a square based on it\'s index' do
                expect(grid_with_puzzle.get_value_at 0).to eq 7
            end

            it 'grid can set the value of a square based on it\'s index' do
                grid_with_puzzle.set_value_at 0, 2
                expect(grid_with_puzzle.get_value_at 0).to eq 2
            end
        end

        context 'solution' do

            it 'grid knows if a square is solved based on it\'s index' do
                expect(grid_with_puzzle.solved_at? 0).to be true
            end

            it 'grid knows if a square is not solved based on it\'s index' do
                expect(grid_with_puzzle.solved_at? 8).to be false
            end
 
            it 'grid can find solution candidates for a square at a given index' do
                expect(grid_with_puzzle.candidates_for 40).to eq [2, 7]
            end

            it 'grid solution candidates search returns \'nil\' for solved squares' do
                expect(grid_with_puzzle.candidates_for 0).to eq nil
            end

            it 'grid can solve an unsolved square at a given index' do
                expect(grid_with_puzzle.solve_at 11).to eq 4
            end

            it 'grid should not solve an already solved square' do
                expect(grid_with_puzzle.solve_at 0).to be_falsey
            end

            it 'grid should not solve an unsolved square that has more than one solution candidate' do
                expect(grid_with_puzzle.solve_at 40).to be_falsey
            end
        end

        context 'boxes' do

            it 'grid can find the box number of a square based on it\'s index' do
                [10, 13, 16].each_with_index { |value, index| expect(grid.box_of value).to eq index }
                [37, 40, 43].each_with_index { |value, index| expect(grid.box_of value).to eq index+3 }
                [64, 67, 70].each_with_index { |value, index| expect(grid.box_of value).to eq index+6 }
            end
        end

        context 'peers' do

            it 'grid can find all peer values of a square based on it\'s index' do
                expect(grid_with_puzzle.peer_values_of 40).to eq [1, 3, 4, 5, 6, 8, 9]
            end
        end
    end

    context 'boxes' do
        it 'grid can find the indices of a box based on it\'s number' do
            expect(grid.indices_of_box 0).to eq [0, 1, 2, 9, 10, 11, 18, 19, 20]
            expect(grid.indices_of_box 8).to eq [60, 61, 62, 69, 70, 71, 78, 79, 80]
        end

        it 'grid can find the indices of more than one box based on their numbers' do
            indices = [[3, 4, 5, 12, 13, 14, 21, 22, 23], [6, 7, 8, 15, 16, 17, 24, 25, 26]]
            expect(grid.indices_of_box 1, 2).to eq indices
        end
    end

    context 'solution' do

        it 'grid knows if current puzzle is not solved' do
            expect(grid.puzzle_solved?).to be_falsey
            expect(grid_with_puzzle.puzzle_solved?).to be_falsey   
        end

        it 'grid knows if current puzzle is solved' do
            grid_with_puzzle.solve_puzzle
            expect(grid_with_puzzle.puzzle_solved?).to be true
        end
 
        it 'grid knows if current puzzle solution is correct' do
            grid_with_puzzle.solve_puzzle
            expect(grid_with_puzzle.puzzle_solved?).to be true
        end

        it 'grid knows if current puzzle solution is incorrect' do
            grid_with_puzzle.solve_puzzle
            grid_with_puzzle.set_value_at 0, 4
            expect(grid_with_puzzle.puzzle_solved?).to be false
        end
    end
end

