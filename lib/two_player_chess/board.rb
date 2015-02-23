module TwoPlayerChess
  class Board
    attr_reader :max_row, :max_col
  	attr_reader :grid
  	def initialize(input = {})
      @max_row = 8 # these could be changeable
      @max_col = 8 # these could be changeable      
  	  @grid = input.fetch(:grid, default_grid)
      set_cell(3,3, Pawn.new(:white,[3,3]) ) # testing
      #set_cell(3,4, Pawn.new(:white,[3,4]) ) # testing
      #set_cell(3,5, Pawn.new(:white,[3,5]) ) # testing
  	end


# get_cell and set_sell should be private
# should have move_piece method
# whats distinction between game and board in chess?

    def get_cell(x, y)
      return grid[y][x]
    end

    def set_cell(x, y, value)
      cell = get_cell(x, y)
      cell.value = value
      cell.value.location = [x,y] if value != nil
    end


    def game_over
      return :winner if winner?
      return :draw if draw?
      false
    end

    def formatted_grid
    	grid.each do |row|
    		puts row.map { |cell| cell.value.nil? ? "_" : cell.value.display }.join(" ")
        end
    end

    def draw?
      false
    end

    def winner?
      return true if !get_cell(0,0).value.nil? # testing
      false
    end


    private

    def default_grid
      Array.new(max_row) { Array.new(max_col) { Cell.new} }
    end

  end

end