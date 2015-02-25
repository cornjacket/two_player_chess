#lib/two_player_chess/queen.rb
module TwoPlayerChess


  class Queen < Piece

    attr_accessor :color
    
    def initialize(color)
      super(color)
    end

    def to_s
      "Q"
    end

    def captures(col, row, board)
      moves(col, row, board)
    end

    # Maybe this code should be refactored with Rook and Bishop and placed inside
    # Piece so that it is common code instead copied in multiple places
    def moves(col, row, board)
      valid_moves = []     
      # need to start off @ col,row and then move outwards in 4 legal directions
      7.times do |i|
        x = col+i+1
        y = row+i+1
        break if !on_board([x,y])
        valid_moves << [x,y]
        break if board.get_cell(x,y).value != nil
      end
      7.times do |i|
        x = col-i-1
        y = row+i+1
        break if !on_board([x,y])
        valid_moves << [x,y]
        break if board.get_cell(x,y).value != nil
      end
      7.times do |i|
        x = col+i+1
        y = row-i-1
        break if !on_board([x,y])
        valid_moves << [x,y]
        break if board.get_cell(x,y).value != nil
      end
      7.times do |i|
        x = col-i-1
        y = row-i-1
        break if !on_board([x,y])
        valid_moves << [x,y]
        break if board.get_cell(x,y).value != nil
      end     

      # need to start off @ col,row and then move outwards in 4 legal directions
       7.times do |i|
        x = col
        y = row+i+1
        break if !on_board([x,y])
        valid_moves << [x,y]
        break if board.get_cell(x,y).value != nil
      end
      7.times do |i|
        x = col-i-1
        y = row
        break if !on_board([x,y])
        valid_moves << [x,y]
        break if board.get_cell(x,y).value != nil
      end
      7.times do |i|
        x = col+i+1
        y = row
        break if !on_board([x,y])
        valid_moves << [x,y]
        break if board.get_cell(x,y).value != nil
      end
      7.times do |i|
        x = col
        y = row-i-1
        break if !on_board([x,y])
        valid_moves << [x,y]
        break if board.get_cell(x,y).value != nil
      end 
      valid_moves      
=begin      
      location = [col,row]
      valid_moves = []     
      # first find positive diagonal moves
      if col < row
        start_col = col-col
        start_row = row-col
      else
        start_col = col-row
        start_row = row-row
      end
      8.times do |i|
        new_move = [start_col+i, start_row+i]
        break if !on_board(new_move)
        valid_moves << new_move if new_move != location
      end
      # next find negative diagonal moves
      if col < row
        neg_start_col = col - col
        neg_start_row = row + col
      else
        diff = 7 - row
        neg_start_col = col - diff
        neg_start_row = row + diff
      end
      # first vertical moves
      8.times do |i|
        new_move = [neg_start_col+i, neg_start_row-i]
        break if !on_board(new_move)
        valid_moves << new_move if new_move != location
      end
      8.times do |i|
        new_move = [col, i]
        #break if !on_board(new_move) # later can be used to stop movement
        valid_moves << new_move if new_move != location
      end
      # next find horizontal moves
      8.times do |i|
        new_move = [i, row]
        #break if !on_board(new_move) # later can be used to stop movement
        valid_moves << new_move if new_move != location
      end

=end      
    end


  end

end