describe PuzzleGenerator do

	let (:grid) {Grid.new}

	it "can generate a random puzzle" do
		puzzle = PuzzleGenerator.generate_puzzle
		expect(puzzle.chars.count).to eq 81
		expect(puzzle.class).to eq String
	end

	it "can generate a puzzle without difficulty level argument (default: medium)" do
		puzzle = PuzzleGenerator.generate_puzzle
		expect(puzzle.chars.count).to eq 81
		expect(puzzle.chars.select{|char| char=="0"}.count).to eq 51
	end

	it "can generate a very easy puzzle" do
		very_easy_puzzle = PuzzleGenerator.generate_puzzle 1
		expect(very_easy_puzzle.chars.count).to eq 81
		expect(very_easy_puzzle.chars.select{|char| char=="0"}.count).to eq 31
	end

	it "can generate an easy puzzle" do
		easy_puzzle = PuzzleGenerator.generate_puzzle 2
		expect(easy_puzzle.chars.count).to eq 81
		expect(easy_puzzle.chars.select{|char| char=="0"}.count).to eq 41
	end

	it "can generate a medium puzzle" do
		easy_puzzle = PuzzleGenerator.generate_puzzle 3
		expect(easy_puzzle.chars.count).to eq 81
		expect(easy_puzzle.chars.select{|char| char=="0"}.count).to eq 51
	end

	it "can generate a hard puzzle" do
		easy_puzzle = PuzzleGenerator.generate_puzzle 4
		expect(easy_puzzle.chars.count).to eq 81
		expect(easy_puzzle.chars.select{|char| char=="0"}.count).to eq 61
	end

	it "can generate a very hard puzzle" do
		easy_puzzle = PuzzleGenerator.generate_puzzle 5
		expect(easy_puzzle.chars.count).to eq 81
		expect(easy_puzzle.chars.select{|char| char=="0"}.count).to eq 71
	end
end
