#lib/two_player_chess/piece.rb
module TwoPlayerChess




  class Rook < Piece

    attr_accessor :color, :first_move

    def initialize(color)
      super(color)
      @first_move = true
    end

    def display
      "R"
    end

    def captures(col, row)
      moves(col, row)
    end


    def moves(col, row)
      location = [col,row]
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

    def special_move
      :castle
    end

  end

end