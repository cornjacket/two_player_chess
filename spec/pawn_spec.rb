# spec/piece_spec.rb
require "spec_helper"

module TwoPlayerChess
  describe Pawn do
    # tests will be added here

    context "#initialize" do
      it "raises an error if initialized without 1 parameter" do
        expect { Pawn.new() }.to raise_error
      end    

      it "can be initialize with a color of :white" do
        piece = Pawn.new(:white)
        expect(piece.color).to eq :white
      end

    end # context "#initialize"


    context "#copy" do

      it "returns a color of white if the original color is white" do
        piece = Pawn.new(:white)
        copy = piece.copy
        expect(copy.color).to eq :white
      end

      it "returns a first_move of false if the original first_move is false" do
        piece = Pawn.new(:white)
        piece.first_move = false
        copy = piece.copy
        expect(copy.first_move).to eq false
      end

    end # context "#copy"


    context "#first_move" do

      it "is initially set to true" do
        piece = Pawn.new(:white)
        expect(piece.first_move).to eq true
      end

    end # context "#first_move"



    context "#captures" do

      it "returns a list of valid positions that white can capture" do
        piece = Pawn.new(:white)
        expect(piece.captures(4,1)).to eq [ [3,2], [5,2] ]
      end      

      it "returns a list of valid positions that are on the game board" do
        piece = Pawn.new(:white)
        expect(piece.captures(0,1)).to eq [ [1,2] ]
      end 

      it "returns a list of valid positions that are on the game board" do
        piece = Pawn.new(:white)
        expect(piece.captures(4,7)).to eq []
      end

      it "returns a list of valid positions that black can capture" do
        piece = Pawn.new(:black)
        expect(piece.captures(4,6)).to eq [ [3,5], [5,5] ]
      end 

      it "returns a list of valid positions that are on the game board" do
        piece = Pawn.new(:black)
        expect(piece.captures(7,6)).to eq [ [6,5] ]
      end 

      it "returns a list of valid positions that are on the game board" do
        piece = Pawn.new(:black)
        expect(piece.captures(4,0)).to eq []
      end

    end # context "#captures"
      

    context "#moves" do

      it "returns a list of valid positions for the first move for white" do
        piece = Pawn.new(:white)
        expect(piece.moves(4,1)).to eq [ [4,2], [4,3] ]
      end      

      it "returns a list of valid positions for the first move for black" do
        piece = Pawn.new(:black)
        expect(piece.moves(4,6)).to eq [ [4,5], [4,4] ]
      end 

      it "returns a list of valid positions for a non first move for white" do
        piece = Pawn.new(:white)
        piece.stub(:first_move) { false }
        expect(piece.moves(4,2)).to eq [ [4,3] ]
      end      

      it "returns a list of valid positions for a non first move for black" do
        piece = Pawn.new(:black)
        piece.stub(:first_move) { false }
        expect(piece.moves(4,5)).to eq [ [4,4] ]
      end

    end # context "#moves"

  end
end