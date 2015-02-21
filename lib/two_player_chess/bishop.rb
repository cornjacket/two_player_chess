#lib/two_player_chess/piece.rb
module TwoPlayerChess


  class Bishop < Piece

    attr_accessor :color, :location
    attr_reader :first_move
    def initialize(color, location)
      super(color, location)
    end

=begin
    def captures
      moves
    end

# TODO - need to loop in each of four directions starting at location and stopping when
# on_board is false
    def moves
      valid_moves = []      
      if color == :white
        possible_moves = [ [col,row+1] ]
        possible_moves << [ col,row+2 ] if first_move
      else
        possible_moves = [ [col,row-1] ]
        possible_moves << [ col,row-2 ] if first_move
      end
      possible_moves.each do |tuple|
        valid_moves << tuple if on_board(tuple)
      end      
      valid_moves
    end
=end

  end


end