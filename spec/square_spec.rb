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




end






