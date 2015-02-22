#lib/two_player_chess/piece.rb
module TwoPlayerChess




  class Rook < Piece

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
      # first vertical moves
      8.times do |i|
        new_move = [col, i]
        #break if !on_board(new_move) # later can be used to stop movement
        valid_moves << new_move if new_move != location
      end
      # next find horizontal moves
      8.times do |i|
        new_move = [i, row]
        #break if !on_board(new_move) # later can be used to stop movement
        valid_moves << new_move if new_move != location
      end
      valid_moves
    end


  end

end