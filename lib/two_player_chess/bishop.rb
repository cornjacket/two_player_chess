#lib/two_player_chess/piece.rb
module TwoPlayerChess


  class Bishop < Piece

    attr_accessor :color
    
    def initialize(color)
      super(color)
    end

    def display
      "B"
    end

    def captures(col, row)
      moves(col, row)
    end

# there is a bug in this movement
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
      8.times do |i|
        new_move = [neg_start_col+i, neg_start_row-i]
        break if !on_board(new_move)
        valid_moves << new_move if new_move != location
      end
      valid_moves
    end

  end

end