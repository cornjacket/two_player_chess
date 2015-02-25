#lib/two_player_chess/piece.rb
module TwoPlayerChess


  class Knight < Piece

    attr_accessor :color
    
    def initialize(color)
      super(color)
    end

    def to_s
      "N"
    end

    def captures(col, row, board=nil)
      moves(col, row)
    end


    def moves(col, row, board=nil)
      valid_moves = []
      inc =  [ [-1,2], [-2,1], [-2,-1], [-1,-2], [1,-2], [2,-1], [2,1], [1,2] ]
      inc.each do |tuple| 
        new_move = [col+tuple[0],row+tuple[1]]
        valid_moves << new_move if on_board(new_move)
      end
      valid_moves
    end

  end

end