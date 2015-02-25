#lib/two_player_chess/king.rb
module TwoPlayerChess


  class King < Piece

    attr_accessor :color, :first_move

    def initialize(color)
      super(color)
      @first_move = true
    end

    def to_s
      "K"
    end

    def captures(col, row, board=nil)
      moves(col, row)
    end

    def moves(col, row, board=nil)
      valid_moves = []
      inc =  [ [-1,0], [-1,1], [0,1], [1,1], [1,0], [1,-1], [0,-1], [-1,-1] ]
      inc.each do |tuple| 
        new_move = [col+tuple[0],row+tuple[1]]
        valid_moves << new_move if on_board(new_move)
      end
      # check for castling

      valid_moves
    end

    def special_move
      :king_castle
    end

  end

end