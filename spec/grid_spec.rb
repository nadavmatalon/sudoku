
describe Grid do

    let (:puzzle) { '786214590150369080003708416267093800490800601308500072072400300641035700000602054' }
    let (:very_easy_puzzle) { '009006080000457210021389465150802937090003801873005604980534006400701398300068540' }
    let (:easy_puzzle) { '630100009700030600490607130050300090947865000103000400829000570060798301071056000' }
    let (:medium_puzzle) { '810000000000100304050706018140300062005009800000000000020900405093810700406500000' }
    let (:hard_puzzle) { '008003000301000200029005000200070000000506400100040008000020000000090100000000800' }
    let (:very_hard_puzzle) { '000000700000000600300000100000006000000010000000070001000060500000000000000000000' }
    let (:impossible_puzzle) { '516849732307605000809700065135060907472591006968370050253186074684207500791050608' }
    let (:grid) { Grid.new puzzle }

    it 'is initialized with empty puzzle by defualt' do
        expect(Grid.new.puzzle).to eq Array.new(81, 0)
    end

    it 'can be initiallized with a puzzle' do
        expect(grid.puzzle.join).to eq puzzle
    end

    it 'can have puzzle uploaded after initialization' do
        grid = Grid.new
        grid.upload puzzle
        expect(grid.puzzle.join).to eq puzzle
    end

    it 'can get the value of a square based on it\'s index' do
        expect(grid.get_value_at 0).to eq 7
    end

    it 'can set the value of a square based on it\'s index' do
        grid.set_value_at 0, 2
        expect(grid.get_value_at 0).to eq 2
    end

    it 'can exort it\'s puzzle current state to a str' do
        expect(grid.puzzle_to_str).to eq puzzle
    end

    it 'knows if a square is solved based on it\'s index' do
        expect(grid.solved_at? 0).to be true
    end

    it 'knows if a square is not solved based on it\'s index' do
        expect(grid.solved_at? 8).to be false
    end

    it 'can find the box number of a square based on it\'s index' do
        [10, 13, 16].each_with_index { |value, index| expect(grid.find_box_of value).to eq index }
        [37, 40, 43].each_with_index { |value, index| expect(grid.find_box_of value).to eq index+3 }
        [64, 67, 70].each_with_index { |value, index| expect(grid.find_box_of value).to eq index+6 }
    end

    it 'can find all peer values of a square at a given index' do
        expect(grid.peer_values_of 40).to eq [1, 3, 4, 5, 6, 8, 9]
    end

    it 'can find solution candidates for a square at a given index' do
        expect(grid.candidates_for 40).to eq [2, 7]
    end

    it 'solution candidates search returns \'nil\' for solved squares' do
        expect(grid.candidates_for 0).to eq nil
    end

    it 'can solve an unsolved square at a given index' do
        expect(grid.solve_at 11).to eq 4
    end

    it 'should not solve an already solved square' do
        expect(grid.solve_at 0).to be_falsey
    end

    it 'should not solve an unsolved square with more than one solution candidate' do
        expect(grid.solve_at 40).to be_falsey
    end

    it 'knows if it\'s not fully solved' do
        expect(grid.fully_solved?).to be_falsey
    end

    it 'knows if it\'s fully solved' do
        grid.solve
        expect(grid.fully_solved?).to be true
    end

    it 'can solve an empty puzzle' do
        expect(Grid.new.solve).to be true
    end

    it 'can solve a very easy puzzle' do
        expect(Grid.new(very_easy_puzzle).solve).to eq true
    end

    it 'can solve an easy puzzle' do
        expect(Grid.new(easy_puzzle).solve).to eq true
    end

    it 'can solve a medium puzzle' do
        expect(Grid.new(medium_puzzle).solve).to eq true
    end

    it 'can solve a hard puzzle' do
        expect(Grid.new(hard_puzzle).solve).to eq true
    end

    it 'can solve a very hard puzzle' do
        expect(Grid.new(very_hard_puzzle).solve).to eq true
    end

    it 'cannot solve an impossible puzzle' do
        expect(Grid.new(impossible_puzzle).solve).to be_falsey
    end

    it 'can print the grid\'s current state in terminal' do
        puts grid.str_for_print
    end

end

