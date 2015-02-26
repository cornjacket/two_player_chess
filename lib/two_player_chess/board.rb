module TwoPlayerChess
  class Board
    attr_reader :max_row, :max_col
  	attr_reader :grid
    # these could be private later but i think internal self references must be removed
    attr_accessor :white_king, :black_king
    attr_accessor :white_king_loc, :black_king_loc

    def abs(a)
      return -a if a < 0
      a
    end

  	def initialize(input = {})
      @max_row = 8 # these could be changeable
      @max_col = 8 # these could be changeable      
  	  @grid = input.fetch(:grid, default_grid)  
  	end

    # shallow copy can not be used because, any piece movement in copied grid array (ie. Castle,Pawn movement) will have
    # lasting effect (first_move set to false). so we need a deep copy of all the pieces.
    # deep_copy will create a copy of a Board after a game has been started.
    # copying a board using deep copy prior to Board#set_up may/will result in an error
    def deep_copy
      copy = Board.new
      8.times do |x|
        8.times do |y|
          cell = get_cell(x,y).value
          if cell == nil
            copy.set_cell(x,y,nil)
          else
            copy.set_cell(x,y,cell.copy)
          end
        end
      end
      copy.white_king_loc = white_king_loc
      copy.black_king_loc = black_king_loc
      copy.white_king = copy.get_cell(white_king_loc[0],white_king_loc[1]).value
      copy.black_king = copy.get_cell(black_king_loc[0],black_king_loc[1]).value
      copy      
    end

    def king(color)
      return self.white_king if color == :white
      self.black_king
    end

    def get_king_location(color)
      return self.white_king_loc if color == :white
      self.black_king_loc
    end

    def set_king_location(color, location)
      if color == :white
        self.white_king_loc = location
      else
        self.black_king_loc = location
      end
    end

    def set_up

      self.white_king_loc = [4,0]
      self.black_king_loc = [4,7]
      self.white_king = King.new(:white)
      self.black_king = King.new(:black)
      8.times do |i|
        set_cell(i,1, Pawn.new(:white))
        set_cell(i,6, Pawn.new(:black))
      end    
      set_cell(0,0, Rook.new(:white))
      set_cell(1,0, Knight.new(:white))
      set_cell(2,0, Bishop.new(:white))
      set_cell(3,0, Queen.new(:white))
      set_cell(white_king_loc[0],white_king_loc[1], white_king)
      set_cell(5,0, Bishop.new(:white))
      set_cell(6,0, Knight.new(:white))
      set_cell(7,0, Rook.new(:white))
      set_cell(0,7, Rook.new(:black))
      set_cell(1,7, Knight.new(:black))
      set_cell(2,7, Bishop.new(:black))
      set_cell(3,7, Queen.new(:black))
      set_cell(black_king_loc[0],black_king_loc[1], black_king)
      set_cell(5,7, Bishop.new(:black))
      set_cell(6,7, Knight.new(:black))
      set_cell(7,7, Rook.new(:black))
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

if source == nil
  puts "source == nil"
elsif color != source.color
  puts "color != source.color"
elsif (destination != nil && color == destination.color)
  puts "destination != nil &&"
elsif destination != nil
  puts "capture"
else
  puts "move"
end

      # then check if piece exists to move at source
      return false if source == nil
      # then check if calling player is same as piece color
      return false if color != source.color
      # check if piece is not occupied by own piece
      return false if (destination != nil && color == destination.color)
      # check if moving piece to destination will indirectly cause check for king
      # what about directly causing check for king - how is that remedied

      # check if move may cause an en_passe in opponent's next move

      # check if move is an en_passe

      # check if castle

# DEBUGGING
      if source.special_move == :king_castle && source.first_move == true
        puts "castle 1"
        if from_y == to_y && abs(from_x-to_x) == 2 # destination is 2 spaces to the horizonal of the source
          puts "castle 2"
# later add for escaping check or going into check
          return :castle if closest_rook_can_castle?(color,from_x,from_y,to_x) # looks for closest rook of color, returns nil if 
         
        end
      end
      # closest rook exists (not nil and special_move == :rook_castle) where it should, match color, first_move is true, 
      # closest initial rook square to destination has a rook with first_move == true
      # empty spaces in between source and closest rook position
      # empty_squares_between(from_x,from_y,to_y)


      # check if move is a capture or just a move by seeing if destination is
      # occupied by opposite color, then check if piece can move to destination
      # checking for capture amounts to checking if destination != nil since
      # already checked for same color
      if destination != nil
        # capture scenario, now check if valid capture by asking piece TODO
        puts "Valid captures = #{source.captures(from_x,from_y,self)}"
        return :capture if source.captures(from_x,from_y,self).include?([to_x,to_y])
      else
        # move scenario, now check if valid move by asking piece TODO
        # also check for castle
        # also check for pawn first move
        puts "Valid moves = #{source.moves(from_x,from_y,self)}"
        return :move if source.moves(from_x,from_y,self).include?([to_x,to_y])
      end

      puts "Not a valid move or capture"
      return false
    end

    def closest_rook_coord(color,from_x,from_y,to_x)
      rook_x = (to_x > 4) ? 7 : 0
      rook_y = from_y
      [rook_x,rook_y]
    end

# need tests for this
    def closest_rook_can_castle?(color,from_x,from_y,to_x) # looks for closest rook of color, returns nil if 
      rook_x, rook_y = closest_rook_coord(color,from_x,from_y,to_x) 
      rook = get_cell(rook_x,rook_y).value
      if rook != nil && rook.special_move == :rook_castle && rook.first_move == true && rook.color == color && empty_squares_between?(from_x, from_y, rook_x) 
        return true
      end
      false
    end
  
  # need tests for this
    def castle_rook(color,from_x,from_y,to_x)
      rook_x,rook_y = closest_rook_coord(color,from_x,from_y,to_x)
      puts "Rook is @ (#{rook_x},#{rook_y})"
      move_piece(rook_x,rook_y, rook_dest_x(rook_x) ,rook_y)
    end

    # returns the destination x coord for the rook that is going to castle
    def rook_dest_x(x)
      return 5 if x == 7
      return 3
    end

    def empty_squares_between?(from_x,from_y,to_x)
      return_value = true
      start = (from_x < to_x) ? from_x+1 : to_x+1
      stop  = (to_x > from_x) ? to_x-1 : from_x-1
      start.upto(stop) do |i|
        return_value = false if get_cell(i, from_y).value != nil
      end
      return_value
    end


    def move_piece(from_x, from_y, to_x, to_y)      
      piece = get_cell(from_x,from_y).value
      piece.first_move = false if piece.special_move != false
      set_cell(to_x,to_y, piece)
      set_cell(from_x,from_y, nil)
    end

    def get_cell(x, y)
      return grid[y][x]
    end

    # set_cell is used to init the board with pieces along with as a helper function to move and
    # and clear pieces on the board
    def set_cell(x, y, value)
      cell = get_cell(x, y)
      cell.value = value
    end

    # this method will be useful when determining if a move is valid, especially in case
    # the current player is in check and wants to move a piece to block it. this will be
    # useful when there is a web interface and the source square is picked independently from
    # the destination square
    # not sure how this will work in conjunction with valid_move? yet
    def valid_source?

    end

    # used in conjunction with valid_source? to determine new valid_move?
    def valid_destination?

    end

    # definitely need specs for this
    def in_check?(color)
      #select king based on color and record king_location
      king_loc = get_king_location(color)
      opposite_color = (color == :white) ? :black : :white
      #go through entire board and look at each piece of opposite color and see if king_location
      #is included inside of each opponent's capture array
      8.times do |x|
        8.times do |y|
          piece = get_cell(x,y).value
          # piece != nil, color = opposite_color
          if piece != nil && piece.color == opposite_color && piece.captures(x,y,self).include?(king_loc)
            return true
          end
        end
      end
      false
    end

    def game_over
      return :winner if winner?
      return :draw if draw?
      false
    end

    def formatted_grid
    	grid.each do |row|
    		puts row.map { |cell| cell.value.nil? ? "_" : cell.value.to_s }.join(" ")
        end
    end

    def draw?
      false
    end

    def winner?
      return true if !get_cell(0,2).value.nil? # upper left white pawn moves one square
      false
    end


    private

    def default_grid
      Array.new(max_row) { Array.new(max_col) { Cell.new} }
    end

  end

end