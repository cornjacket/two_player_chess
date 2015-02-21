# spec/piece_spec.rb
require "spec_helper"

module TwoPlayerChess
  describe Pawn do
    # tests will be added here

    context "#initialize" do
      it "raises an error if initialized without 2 parameters" do
        expect { Pawn.new() }.to raise_error
      end    

      it "can be initialize with a color of :white" do
        piece = Pawn.new(:white, [0,0])
        expect(piece.color).to eq :white
      end

      it "can be initialize with a location of [0,0]" do
        piece = Pawn.new(:black, [0,0])
        expect(piece.location).to eq [0,0]
      end

      it "returns a list of valid positions that white can capture" do
        piece = Pawn.new(:white, [4,1])
        expect(piece.captures).to eq [ [3,2], [5,2] ]
      end 

    end # context "#initialize"

    context "#first_move" do

      it "initially sets first_move to true" do
        piece = Pawn.new(:white, [0,0])
        expect(piece.first_move).to eq true
      end

    end # context "#first_move"

    context "#captures" do

      it "returns a list of valid positions that white can capture" do
        piece = Pawn.new(:white, [4,1])
        expect(piece.captures).to eq [ [3,2], [5,2] ]
      end      

      it "returns a list of valid positions that are on the game board" do
        piece = Pawn.new(:white, [0,1])
        expect(piece.captures).to eq [ [1,2] ]
      end 

      it "returns a list of valid positions that are on the game board" do
        piece = Pawn.new(:white, [4,7])
        expect(piece.captures).to eq []
      end

      it "returns a list of valid positions that black can capture" do
        piece = Pawn.new(:black, [4,6])
        expect(piece.captures).to eq [ [3,5], [5,5] ]
      end 

      it "returns a list of valid positions that are on the game board" do
        piece = Pawn.new(:black, [7,6])
        expect(piece.captures).to eq [ [6,5] ]
      end 

      it "returns a list of valid positions that are on the game board" do
        piece = Pawn.new(:black, [4,0])
        expect(piece.captures).to eq []
      end

    end # context "#captures"
      

    context "#moves" do

      it "returns a list of valid positions for the first move for white" do
        piece = Pawn.new(:white, [4,1])
        expect(piece.moves).to eq [ [4,2], [4,3] ]
      end      

      it "returns a list of valid positions for the first move for black" do
        piece = Pawn.new(:black, [4,6])
        expect(piece.moves).to eq [ [4,5], [4,4] ]
      end 

      it "returns a list of valid positions for a non first move for white" do
        piece = Pawn.new(:white, [4,2])
        piece.stub(:first_move) { false }
        expect(piece.moves).to eq [ [4,3] ]
      end      

      it "returns a list of valid positions for a non first move for black" do
        piece = Pawn.new(:black, [4,5])
        piece.stub(:first_move) { false }
        expect(piece.moves).to eq [ [4,4] ]
      end

    end # context "#moves"

  end
end