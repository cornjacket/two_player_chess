#lib/two_player_chess/piece.rb
module TwoPlayerChess
  class Piece
    attr_accessor :color, :location
    def initialize(color, location)
      @color = color
      @location = location
    end
    
    def on_board(tuple)
      if (tuple[0] >= 0 && tuple[0] <= 7 && tuple[1] >= 0 && tuple[1] <= 7)
      	return true
      end
      false
    end  

    def col
      location[0]
    end

    def row
      location[1]
    end

    def special_move
      false
    end
      
  end
end