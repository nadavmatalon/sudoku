class Square
 
	attr_accessor :index, :row, :column, :box, :value

	def initialize (index = nil, row = nil, column = nil, box = nil, value = 0)
		@index = index
		@row = row
		@column = column
		@box = box
		@value = value
	end

	def solved?
		value != 0
	end

	def unsolved?
		value == 0
	end

	def set value
    	@value = value
  	end

end

