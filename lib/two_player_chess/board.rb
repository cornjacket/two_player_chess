module TwoPlayerChess
  class Board
    attr_reader :max_row, :max_col
  	attr_reader :grid
  	def initialize(input = {})
      @max_row = 8 # these could be changeable
      @max_col = 8 # these could be changeable      
  	  @grid = input.fetch(:grid, default_grid)
  	end

    def set_up
# My board_spec specs are failing here because of set_cell. Do I modify tests
# or do I have an additional method to set_up pieces. Add setup pieces so that
# I can add corner cases to board_spec
      set_cell(3,3, Pawn.new(:white,[3,3]) ) # testing
      #set_cell(3,4, Pawn.new(:white,[3,4]) ) # testing
      #set_cell(3,5, Pawn.new(:white,[3,5]) ) # testing      
    end

# returns :move if it is a valid move
# returns :capture if it is a valid capture
# returns :castle if it is a valid castling move
# returns :en_passe if it is a valid en_passe move
# returns false if it is an invalid move or capture
    def valid_move?(color, from_x, from_y, to_x, to_y)
      source = get_cell(from_x,from_y).value
      destination = get_cell(to_x, to_y).value
      # this should be checked at input - check if source and destintion are on_board
      
      # then check if piece exists to move at source
      return false if source == nil
      # then check if calling player is same as piece color
      return false if color != source.color
      # check if piece is not occupied by own piece
      return false if (destination != nil && color == destination.color)
      # check if moving piece to destination will indirectlycause check for king
      # what about directly causing check for king - how is that remedied

      # check if move is a castle

      # check if move may cause an en_passe in opponent's next move

      # check if move is an en_passe

      # check if move is a capture or just a move by seeing if destination is
      # occupied by opposite color, then check if piece can move to destination
      # checking for capture amounts to checking if destination != nil since
      # already checked for same color
      if destination != nil
        # capture scenario, now check if valid capture by asking piece TODO
        return :capture
      else
        # move scenario, now check if valid move by asking piece TODO
        return :move
      end

      return false
    end

# get_cell and set_sell should be private
# should have move_piece method
# whats distinction between game and board in chess?
    def move_piece(from_x, from_y, to_x, to_y)      
      piece = get_cell(from_x,from_y).value
      set_cell(to_x,to_y, piece)
      set_cell(from_x,from_y, nil)
      puts "New internal x,y = #{piece.col},#{piece.row}"
    end

    def get_cell(x, y)
      return grid[y][x]
    end

    def set_cell(x, y, value)
      cell = get_cell(x, y)
      cell.value = value
      # set the piece's internal location to [x,y] so the piece knows where it is
      # does the piece need to always know where it is? or can it be passed this info
      # when it is actually needed?
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