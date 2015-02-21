#lib/two_player_chess/piece.rb
module TwoPlayerChess


  class Pawn < Piece

    attr_accessor :color, :location
    attr_reader :first_move
    def initialize(color, location)
      super(color, location)
      #@color = color
      #@location = location
      @first_move = true
    end

    def captures
      valid_captures = []
      if color == :white
      	possible_captures = [ [col-1,row+1], [col+1,row+1] ]
      else
      	possible_captures = [ [col-1,row-1], [col+1,row-1] ]
      end
      possible_captures.each do |tuple|
        valid_captures << tuple if on_board(tuple)
      end      
      valid_captures
    end

    private

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

  end


end