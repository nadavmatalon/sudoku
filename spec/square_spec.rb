describe Square do

	let (:square) { Square.new }

	it "is initialized with index number of nil" do
		expect(square.index).to eq nil
	end
 
	it "is initialized with row number of nil" do
		expect(square.row).to eq nil
	end

	it "is initialized with column number of nil" do
		expect(square.column).to eq nil
	end

	it "is initialized with box number of nil" do
		expect(square.box).to eq nil
	end

	it "is initialized with value of 0" do
		expect(square.value).to eq 0
	end

	it "knows if it\'s been solved" do
		expect(square.solved?).to be false
		square.value = 1
		expect(square.solved?).to be true
	end

	it "knows if it\'s still unsolved" do
		expect(square.unsolved?).to be true
		square.value = 1
		expect(square.unsolved?).to be false
	end

	it "can set it\'s value" do
		square.set 1
		expect(square.value).to eq 1
	end
end






