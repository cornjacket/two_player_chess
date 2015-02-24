#lib/two_player_chess/piece.rb
module TwoPlayerChess
  class Piece

    attr_accessor :color
    def initialize(color)
      @color = color
    end
    
    def on_board(tuple)
      if (tuple[0] >= 0 && tuple[0] <= 7 && tuple[1] >= 0 && tuple[1] <= 7)
      	return true
      end
      false
    end  

    def special_move
      false
    end

  end
end