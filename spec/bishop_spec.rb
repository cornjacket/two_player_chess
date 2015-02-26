# spec/piece_spec.rb
require "spec_helper"

module TwoPlayerChess
  describe Bishop do

    context "#initialize" do
      it "raises an error if initialized without 1 parameter" do
        expect { Bishop.new() }.to raise_error
      end    

      it "can be initialized with a color of :white" do
        piece = Bishop.new(:white)
        expect(piece.color).to eq :white
      end

    end # context "#initialize"


    context "#copy" do

      it "returns a color of white if the original color is white" do
        piece = Bishop.new(:white)
        copy = piece.copy
        expect(copy.color).to eq :white
      end

    end # context "#copy"


    context "#captures" do

      it "returns a list of valid positions that can be captured from (3,4)" do
        board = Board.new
        piece = Bishop.new(:white)
        expect(piece.captures(3,4,board)).to eq [ [4,5], [5,6], [6,7], [2,5], [1,6], [0,7], [4,3], [5,2], [6,1], [7,0], [2,3], [1,2], [0,1] ]
      end      

      it "returns a list of valid positions that can be captured from (4,3)" do
        board = Board.new        
        piece = Bishop.new(:white)
        expect(piece.captures(4,3,board)).to eq [ [5,4], [6,5], [7,6], [3,4], [2,5], [1,6], [0,7], [5,2], [6,1], [7,0], [3,2], [2,1], [1,0] ]
      end 

      it "returns a list of valid positions that can be captured from (1,6)" do
        board = Board.new
        piece = Bishop.new(:white)
        expect(piece.captures(1,6,board)).to eq [ [2,7], [0,7], [2,5], [3,4], [4,3], [5,2], [6,1], [7,0], [0,5] ]
      end 

    end # context "#captures"
      

    context "#moves" do

      it "returns a list of valid positions that can be moved from (3,4)" do
        board = Board.new
        piece = Bishop.new(:white)
        expect(piece.moves(3,4,board)).to eq [ [4,5], [5,6], [6,7], [2,5], [1,6], [0,7], [4,3], [5,2], [6,1], [7,0], [2,3], [1,2], [0,1] ]
      end      

      it "returns a list of valid positions that can be moved from (4,3)" do
        board = Board.new
        piece = Bishop.new(:white)
        expect(piece.moves(4,3,board)).to eq [ [5,4], [6,5], [7,6], [3,4], [2,5], [1,6], [0,7], [5,2], [6,1], [7,0], [3,2], [2,1], [1,0] ]
      end

      it "returns a list of valid positions that can be moved from (1,6)" do
        board = Board.new
        piece = Bishop.new(:white)
        expect(piece.moves(1,6,board)).to eq [ [2,7], [0,7], [2,5], [3,4], [4,3], [5,2], [6,1], [7,0], [0,5] ]
      end


    end # context "#moves"


  end
end