#lib/two_player_chess/piece.rb
module TwoPlayerChess
  class Piece
    attr_accessor :color, :location
    def initialize(color, location)
      @color = color
      @location = location
    end
  end
end