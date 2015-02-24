#lib/two_player_chess/piece.rb
module TwoPlayerChess


  class Queen < Piece

    attr_accessor :color
    
    def initialize(color)
      super(color)
    end

    def display
      "Q"
    end

    def captures(col, row)
      moves(col, row)
    end

    # Maybe this code should be refactored with Rook and Bishop and placed inside
    # Piece so that it is common code instead copied in multiple places
    def moves(col, row)
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
      valid_moves
    end


  end

end