#lib/two_player_chess/piece.rb
module TwoPlayerChess


  class King < Piece

    attr_accessor :color, :first_move
    attr_reader :location

    def initialize(color, location)
      super(color, location)
      @first_move = true
    end

    def location=(tuple)
      @first_move = false
      super tuple
    end

    def captures
      moves
    end

    def moves
      valid_moves = []
      inc =  [ [-1,0], [-1,1], [0,1], [1,1], [1,0], [1,-1], [0,-1], [-1,-1] ]
      inc.each do |tuple| 
        new_move = [col+tuple[0],row+tuple[1]]
        valid_moves << new_move if on_board(new_move)
      end
      valid_moves
    end

    def special_move
      :castle
    end

  end

end