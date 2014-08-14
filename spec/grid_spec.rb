require './lib/square.rb'

describe Grid do

	let (:grid) { Grid.new }

  	it "should have 81 squares" do
        expect(grid.squares.count).to eq 81
    end

    it "knows the index number of all the square's peers" do
    	expect(grid.peers_of_square_in_index 1).to eq [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 19, 20, 21, 28, 37, 46, 55, 64, 73]
    	expect(grid.peers_of_square_in_index 81).to eq [9, 18, 27, 36, 45, 54, 61, 62, 63, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80]
    end


end

