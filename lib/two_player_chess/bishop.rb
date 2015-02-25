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

    def captures(col, row, board)
      moves(col, row, board)
    end


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
      valid_moves
    end


  end

end