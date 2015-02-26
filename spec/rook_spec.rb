# spec/piece_spec.rb
require "spec_helper"

module TwoPlayerChess
  describe Rook do

    context "#initialize" do
      it "raises an error if initialized without 1 parameter" do
        expect { Rook.new() }.to raise_error
      end    

      it "can be initialized with a color of :white" do
        piece = Rook.new(:white)
        expect(piece.color).to eq :white
      end

    end # context "#initialize"


    context "#copy" do

      it "returns a color of white if the original color is white" do
        piece = Rook.new(:white)
        copy = piece.copy
        expect(copy.color).to eq :white
      end

      it "returns a first_move of false if the original first_move is false" do
        piece = Rook.new(:white)
        piece.first_move = false
        copy = piece.copy
        expect(copy.first_move).to eq false
      end

    end # context "#copy"

    context "#first_move" do

      it "initially sets first_move to true" do
        piece = Rook.new(:white)
        expect(piece.first_move).to eq true
      end

    end # context "#first_move"


    context "#captures" do

      it "returns a list of valid positions that can be captured from (3,4)" do
        board = Board.new
        piece = Rook.new(:white)
        expect(piece.captures(3,4,board)).to eq [ [3,5], [3,6], [3,7], [2,4], [1,4], [0,4], [4,4], [5,4], [6,4], [7,4], [3,3], [3,2], [3,1], [3,0] ]
      end      

      it "returns a list of valid positions that can be captured from (4,3)" do        
        board = Board.new
        piece = Rook.new(:white)
        expect(piece.captures(4,3,board)).to eq [ [4,4], [4,5], [4,6], [4,7], [3,3], [2,3], [1,3], [0,3], [5,3], [6,3], [7,3], [4,2], [4,1], [4,0] ]
      end 

      it "returns a list of valid positions that can be captured from (1,6)" do
        board = Board.new
        piece = Rook.new(:white)
        expect(piece.captures(1,6,board)).to eq [ [1,7], [0,6], [2,6], [3,6], [4,6], [5,6], [6,6], [7,6], [1,5], [1,4], [1,3], [1,2], [1,1], [1,0] ]
      end 

    end # context "#captures"
      

    context "#moves" do

      it "returns a list of valid positions that can be moved to from (3,4)" do
        board = Board.new
        piece = Rook.new(:white)
        expect(piece.moves(3,4,board)).to eq [ [3,5], [3,6], [3,7], [2,4], [1,4], [0,4], [4,4], [5,4], [6,4], [7,4], [3,3], [3,2], [3,1], [3,0] ]
      end      

      it "returns a list of valid positions that can be moved to from (4,3)" do
        board = Board.new
        piece = Rook.new(:white)
        expect(piece.moves(4,3,board)).to eq [ [4,4], [4,5], [4,6], [4,7], [3,3], [2,3], [1,3], [0,3], [5,3], [6,3], [7,3], [4,2], [4,1], [4,0] ]
      end 

      it "returns a list of valid positions that can be moved to from (1,6)" do
        board = Board.new
        piece = Rook.new(:white)
        expect(piece.moves(1,6,board)).to eq [ [1,7], [0,6], [2,6], [3,6], [4,6], [5,6], [6,6], [7,6], [1,5], [1,4], [1,3], [1,2], [1,1], [1,0] ]
      end 


    end # context "#moves"


  end
end