#lib/two_player_chess/piece.rb
module TwoPlayerChess


  class Pawn < Piece

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

    # testing for now
    def display
      "P"
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

    def special_move
      true
    end

  end


end