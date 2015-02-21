#lib/two_player_chess/piece.rb
module TwoPlayerChess


  class Pawn < Piece
  	# how do these accessors work since they are stored in the parent

    attr_accessor :color, :location
    attr_reader :first_move
    def initialize(color, location)
      super(color, location)
      #@color = color
      #@location = location
      @first_move = true
    end

  end


end