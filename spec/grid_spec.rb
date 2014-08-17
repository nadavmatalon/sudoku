describe Grid do

	let (:grid) { Grid.new }

  	it "should have 81 squares" do
        expect(grid.squares.count).to eq 81
    end

    it "can be initialized without a puzzle (defualt)" do
    	grid.squares.each do |square|
    		expect(square.value).to eq 0
    	end
    end

   it "can be initiallized with a puzzle" do
        puzzle = PuzzleGenerator::generate_puzzle
   		grid = Grid.new puzzle
   		grid.squares.each_with_index do |square, index| 
   			expect(square.value).to eq puzzle.chars[index].to_i
   		end
    end

  it "can upload a puzzle after initialization" do
        puzzle = PuzzleGenerator::generate_puzzle
   		grid.upload puzzle
   		grid.squares.each_with_index do |square, index| 
   			expect(square.value).to eq puzzle.chars[index].to_i
   		end
    end

	it "can find the peers of a square" do
		index_of_peers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 18, 19, 20, 27, 36, 45, 54, 63, 72]
		peers = grid.peers_for 0
		peers.each_with_index do |peer, index|
			expect(peer.index).to eq index_of_peers[index]
		end
    end

   	it "can find the values of the peers of a square" do
   		puzzle = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'
   		grid = Grid.new puzzle
		peers_values = [1, 2, 3, 4, 5, 7, 8, 9]
		peers = grid.peers_for 0
		expect(grid.values_of peers).to eq peers_values
    end

    it "can find solution candidates for a square" do
   		puzzle = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'
   		grid = Grid.new puzzle
		expect(grid.candidates_for 0).to eq [6]
    end

    it "knows if a square is unsolved" do
    	expect(grid.unsolved? 0).to be true
    	grid.squares[0].value = 1
    	expect(grid.unsolved? 0).to be false
    end

   it "knows if a suggested solution to a square is correct" do
        puzzle = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'
        grid = Grid.new puzzle
        expect(grid.legit_solution? 6, 7).to be true
        expect(grid.legit_solution? 6, 8).to be true
        for i in 1..9
             expect(grid.legit_solution? 6, i).to be false unless i == 7 || i ==8
         end
    end

    it "can solve a square" do
  		puzzle = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'
   		grid = Grid.new puzzle
   		grid.solve_square_in 0
     	expect(grid.squares[0].value).to eq 6
    end

   it "skips over a square if it\'s already solved" do
  		puzzle = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'
   		grid = Grid.new puzzle
     	expect(grid.solve_square_in 1).to eq nil
    end

   it "knows it\'s current state" do
 		puzzle = '0' * 81
		grid = Grid.new puzzle
   		expect(grid.current_state).to eq puzzle
   		puzzle = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'
   		grid = Grid.new puzzle
   		expect(grid.current_state).to eq puzzle
    end

    it "knows if it\'s still unsolved" do
    	grid = Grid.new
    	expect(grid.fully_solved?).to be false
    end

    it "knows if it\'s fully solved" do
   		puzzle = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'
		grid = Grid.new puzzle
		grid.solve
		expect(grid.fully_solved?).to be true
    end

    it "can duplicate itself" do
  		puzzle = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'
		grid = Grid.new puzzle
		copy = grid.duplicate
		expect(copy.current_state).to eq grid.current_state
    end

    it "can solve an empty puzzle" do
		grid = Grid.new
		grid.solve
		expect(grid.fully_solved?).to be true
    end

   it "can solve a very easy puzzle" do
        very_easy_puzzle = PuzzleGenerator::generate_puzzle 1
		grid = Grid.new very_easy_puzzle
		grid.solve
		expect(grid.fully_solved?).to be true
    end

  it "can solve an easy puzzle" do
        easy_puzzle = PuzzleGenerator::generate_puzzle 2
        grid = Grid.new easy_puzzle
        grid.solve
        expect(grid.fully_solved?).to be true
    end

  	it "can solve a medium puzzle" do
        medium_puzzle = PuzzleGenerator::generate_puzzle 3
		grid = Grid.new medium_puzzle
		grid.solve
		expect(grid.fully_solved?).to be true
    end

 	it "can solve a hard puzzle" do
        hard_puzzle = PuzzleGenerator::generate_puzzle 4
		grid = Grid.new hard_puzzle
		grid.solve
		expect(grid.fully_solved?).to be true
    end

    it "can solve a very hard puzzle" do
        very_hard_puzzle = PuzzleGenerator::generate_puzzle 5
        grid = Grid.new very_hard_puzzle
        grid.solve
        expect(grid.fully_solved?).to be true
    end

   it "gives correct feedback after solving a puzzle" do
        puzzle = PuzzleGenerator::generate_puzzle
		grid = Grid.new puzzle
		expect(grid.solve).to eq "SOLVED IT!"
    end

 	it "knows if it can't solve puzzle" do
		impossible_puzzle = '516849732307605000809700065135060907472591006968370050253186074684207500791050608'
		grid = Grid.new impossible_puzzle
		grid.solve
		expect(grid.fully_solved?).to be false
    end

   it "gives correct feedback after solving a puzzle" do
		impossible_puzzle = '516849732307605000809700065135060907472591006968370050253186074684207500791050608'
		grid = Grid.new impossible_puzzle
		expect(grid.solve).to eq "COULDN'T SOLVE IT!"
    end

 	it "can print the current state of a grid in the terminal" do
        puzzle = PuzzleGenerator::generate_puzzle
		grid = Grid.new puzzle
		grid.solve
 		puts grid.print_in_terminal
 	end
end

