module TwoPlayerChess
  class Board
    attr_reader :max_row, :max_col
  	attr_reader :grid
    # these could be private later but i think internal self references must be removed
    attr_accessor :white_king, :black_king
    attr_accessor :white_king_loc, :black_king_loc
    attr_accessor :en_passe

    def abs(a)
      return -a if a < 0
      a
    end

  	def initialize(input = {})
      @max_row = 8 # these could be changeable
      @max_col = 8 # these could be changeable      
  	  @grid = input.fetch(:grid, default_grid)  
      @en_passe = {} #{:white => nil, :black => nil}
  	end

    # shallow copy can not be used because, any piece movement in copied grid array (ie. Castle,Pawn movement) will have
    # lasting effect (first_move set to false). so we need a deep copy of all the pieces.
    # deep_copy will create a copy of a Board after a game has been started.
    # copying a board using deep copy prior to Board#set_up may/will result in an error
    # deep_copy will be used to determine if there are any possible piece configurations that are possible if the
    # player is under check, it should also help determine whether there is a check mate.
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


    def set_up_kings(white_king_x,white_king_y,black_king_x,black_king_y)
      self.white_king_loc = [white_king_x,white_king_y]
      self.black_king_loc = [black_king_x,black_king_y]
      self.white_king = King.new(:white)
      self.black_king = King.new(:black)
      set_cell(white_king_loc[0],white_king_loc[1], white_king)     
      set_cell(black_king_loc[0],black_king_loc[1], black_king)       
    end

    def set_up

      set_up_kings(4,0, 4,7)
      8.times do |i|
        set_cell(i,1, Pawn.new(:white))
        set_cell(i,6, Pawn.new(:black))
      end    
      set_cell(0,0, Rook.new(:white))
      set_cell(1,0, Knight.new(:white))
      set_cell(2,0, Bishop.new(:white))
      set_cell(3,0, Queen.new(:white))

      set_cell(5,0, Bishop.new(:white))
      set_cell(6,0, Knight.new(:white))
      set_cell(7,0, Rook.new(:white))
      set_cell(0,7, Rook.new(:black))
      set_cell(1,7, Knight.new(:black))
      set_cell(2,7, Bishop.new(:black))
      set_cell(3,7, Queen.new(:black))

      set_cell(5,7, Bishop.new(:black))
      set_cell(6,7, Knight.new(:black))
      set_cell(7,7, Rook.new(:black))
    end

    def out_of_bounds(val)
      return true if val < 0 || val > 7
      false
    end

# returns :move if it is a valid move
# returns :capture if it is a valid capture
# returns :castle if it is a valid castling move
# returns :en_passe if it is a valid en_passe move
# returns false if it is an invalid move or capture
    def valid_move?(color, from_x, from_y, to_x, to_y)
      return false if out_of_bounds(from_x)
      return false if out_of_bounds(from_y)
      return false if out_of_bounds(to_x)
      return false if out_of_bounds(to_y)
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

      # where do I check for pawn promotion

      # then check if piece exists to move at source
      return false if source == nil
      # then check if calling player is same as piece color
      return false if color != source.color
      # check if piece is not occupied by own piece
      return false if (destination != nil && color == destination.color)
      # check if moving piece to destination will indirectly cause check for king
      # what about directly causing check for king - how is that remedied

      # check if move may cause an en_passe in opponent's next move -- this is done below

      # check if move is an en_passe
      # how to check if it is an en_passe
      # first is color's piece a pawn
      # second is en_passe(color) != nil then it has a  column,row where the offending piece lives
     
      # we will have to return :en_passe to game so that game will remove offending piece since move_to wont do it.
      passe = en_passe[color]
      puts "en_passe = #{en_passe}"
      puts "passe = #{passe}"
      if passe != nil && source.special_move == :two_step && passe[1] == from_y && passe[0] == to_x && (abs(from_x-to_x)==1)
        self.en_passe[opposite_color(color)] = nil
        puts "En passe"
        return :en_passe
      end

      # check if castle
      if source.special_move == :king_castle && source.first_move == true
        if from_y == to_y && abs(from_x-to_x) == 2 && !in_check?(color)
          if closest_rook_can_castle?(color,from_x,from_y,to_x) # looks for closest rook of color, returns nil if 
            self.en_passe[opposite_color(color)] = nil         
            return :castle if !move_creates_check?(color,from_x,from_y,to_x,to_y,true)
          end
        end
      end
      # check if move is a capture or just a move by seeing if destination is
      # occupied by opposite color, then check if piece can move to destination
      # checking for capture amounts to checking if destination != nil since
      # already checked for same color
      if destination != nil
        # capture scenario, now check if valid capture by asking piece TODO
        puts "Valid captures = #{source.captures(from_x,from_y,self)}"
        if source.captures(from_x,from_y,self).include?([to_x,to_y])
          if move_creates_check?(color,from_x,from_y,to_x,to_y)
            return false
          else 
            self.en_passe[opposite_color(color)] = nil                     
            return :promotion if source.special_move == :two_step && pawn_at_last_position?(color,to_y)
            return :capture
          end
        end
      else
        # move scenario, now check if valid move by asking piece TODO
        # also check for castle
        # also check for pawn first move
        puts "Valid moves = #{source.moves(from_x,from_y,self)}"
        #return :move if source.moves(from_x,from_y,self).include?([to_x,to_y])
        if source.moves(from_x,from_y,self).include?([to_x,to_y])
          if move_creates_check?(color,from_x,from_y,to_x,to_y)
            return false
          else
            if (source.special_move == :two_step) && (abs(from_y-to_y)==2)
              # recording an en passe is done by recording the final destination of the pawn in the en_passe hash under
              # opposing color. this info can be used to deduce where destination is for the en passe
              puts "DRT 1"
              self.en_passe[opposite_color(color)] = [to_x,to_y]
              puts "New en_passe = #{en_passe}"
            else
              puts "DRT 2"
              self.en_passe[opposite_color(color)] = nil
              puts "New en_passe = #{en_passe}"              
            end
            return :promotion if source.special_move == :two_step && pawn_at_last_position?(color,to_y)
            return :move
          end
        end        
      end

      puts "Not a valid move or capture"
      return false
    end

# need specs for this
def en_passe_capture(color)
  to_capture = en_passe[color]
  x = to_capture[0]
  y = to_capture[1]
  set_cell(x,y,nil)
end
=begin
Need to check for check mate - 
if player is under check, then check for check mate.
how,
for each of the pieces (of the current color) on the board
    go through the list of captures for that piece (if it's a pawn, also go through the list of moves) and
    call move_creates_check? for each. Return false at the first false received from move_creates_check? If
    move_creates_check? never returns false for all the pieces on the board, then return true, there is a
    checkmate on the board. 
=end
    def check_mate?(color)
      8.times do |x|
        8.times do |y|
          piece = get_cell(x,y).value
          if piece != nil && piece.color == color
            #puts "check_mate? color = #{color}"
            valid_moves = []
            piece.captures(x,y,self).each do |loc|
              valid_moves << loc if valid_move?(color,x,y,loc[0],loc[1])
            end
            #valid_moves = piece.captures(x,y,self)
            #valid_moves = valid_moves + piece.moves(x,y,self) if piece.special_move == :two_step
            if piece.special_move == :two_step
              piece.moves(x,y,self).each do |loc|
                valid_moves << loc if valid_move?(color,x,y,loc[0],loc[1])
              end
            end
            valid_moves.each do |loc|
              #print "check_mate? loc = #{loc[0]},#{loc[1]} "
              return false if !move_creates_check?(color,x,y,loc[0],loc[1])
            end # do |loc|
          end  # if
        end # do |y|
      end # do |x|
      true
    end # def

    # method creates a deep_copy of the current board setup, executes the hypothetical move on the board copy,
    # and then checks to see if the hypothetical move causes a check.
    def move_creates_check?(color, from_x, from_y, to_x, to_y, castle=false)
      copy = self.deep_copy
      copy.move_piece(from_x, from_y, to_x, to_y)  
      copy.castle_rook(color,from_x,from_y, to_x) if castle
      copy.in_check?(color)
    end

    def closest_rook_coord(color,from_x,from_y,to_x)
      rook_x = (to_x > 4) ? 7 : 0
      rook_y = from_y
      [rook_x,rook_y]
    end

    def closest_rook_can_castle?(color,from_x,from_y,to_x) # looks for closest rook of color
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
      #puts "Rook is @ (#{rook_x},#{rook_y})"
      move_piece(rook_x,rook_y, rook_dest_x(rook_x) ,rook_y)
    end

    # returns the destination x coord for the rook that is going to castle
    def rook_dest_x(x)
      return 5 if x == 7
      return 3
    end

    # helper method for castling
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
      color = piece.color
      # check if king_loc(color) = source location, and adjust king_loc accordingly
      set_king_location(color, [to_x,to_y]) if get_king_location(color) == [from_x,from_y]
      piece.first_move = false if piece.special_move != false
      set_cell(to_x,to_y, piece)
      set_cell(from_x,from_y, nil)
    end

    # need to test
    def pawn_at_last_position?(color,row)
      final = (color == :white) ? 7 : 0
      return true if row == final
      return false
    end

    # need to test
    def promote_pawn(color,to_x,to_y,piece_type)
        if piece_type == :knight
          piece = Knight.new(color)
        elsif piece_type == :bishop
          piece = Bishop.new(color)
        elsif piece_type == :rook
          piece = Rook.new(color)
        else
          piece = Queen.new(color)
        end      
      set_cell(to_x,to_y,piece)  
    end

    def get_cell(x, y)
      return grid[y][x]
    end

    # set_cell is used to init the board with pieces and as a helper function to move and
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

    # need specs for this
    def in_check?(color)
      king_loc = get_king_location(color)
      opposite_color = (color == :white) ? :black : :white
      #go through entire board and look at each piece of opposite color and see if king_location
      #is included inside of each opponent's capture array
      8.times do |x|
        8.times do |y|
          piece = get_cell(x,y).value
          if piece != nil && piece.color == opposite_color && piece.captures(x,y,self).include?(king_loc)
            #puts "in_check? reports true at #{x},#{y}"
            #puts piece.captures(x,y,self)
            return true
          end
        end
      end
      #puts "in_check? reports false"
      false
    end

    def game_over
      return :winner if winner?
      return :draw if draw?
      false
    end

    def formatted_grid(perspective = :white)      
      col_headers = %w(a b c d e f g h).join(" ")
      if perspective == :white
        display = grid.reverse
        display.each_with_index do |row, i|
          puts (8-i).to_s + " " + row.map { |cell| cell.value.nil? ? "_" : cell.value.to_s }.join(" ")
        end
        puts "  " + col_headers
      else
        display = grid 
        display.each_with_index do |row, i|
          row_display = row.map { |cell| cell.value.nil? ? "_" : cell.value.to_s }.join(" ") + " " + (i+1).to_s
          puts row_display.reverse
        end   
        puts "  " + col_headers.reverse     
      end
    end

    def draw?
      false
    end

    def winner?
      return false
      return true if !get_cell(0,2).value.nil? # early testing
      false
    end


    private

    def default_grid
      Array.new(max_row) { Array.new(max_col) { Cell.new} }
    end

    def opposite_color(color)
      return :black if color == :white
      return :white
    end

  end

end