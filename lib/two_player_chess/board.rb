module TwoPlayerChess
  class Board
    attr_reader :max_row, :max_col
  	attr_reader :grid
  	def initialize(input = {})
      @max_row = 8 # these could be changeable
      @max_col = 8 # these could be changeable      
  	  @grid = input.fetch(:grid, default_grid)
  	end


    def get_cell(x, y)
      return grid[y][x]
    end

    def set_cell(x, y, value)
      get_cell(x, y).value = value    
    end


    def game_over
      return :winner if winner?
      return :draw if draw?
      false
    end

    def formatted_grid
    	grid.each do |row|
    		puts row.map { |cell| cell.value.empty? ? "_" : cell.value }.join(" ")
        end
    end

    def draw?
      false
    end

    def winner?
      false
    end


    private

    def default_grid
      Array.new(max_row) { Array.new(max_col) { Cell.new} }
    end

  end

end