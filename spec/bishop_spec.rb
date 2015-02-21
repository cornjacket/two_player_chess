# spec/piece_spec.rb
require "spec_helper"

module TwoPlayerChess
  describe Bishop do

    context "#initialize" do
      it "raises an error if initialized without 2 parameters" do
        expect { Bishop.new() }.to raise_error
      end    

      it "can be initialized with a color of :white" do
        piece = Bishop.new(:white, [0,0])
        expect(piece.color).to eq :white
      end

      it "can be initialized with a location of [0,0]" do
        piece = Bishop.new(:black, [0,0])
        expect(piece.location).to eq [0,0]
      end


    end # context "#initialize"


    context "#captures" do

      it "returns a list of valid positions that can be captured from (3,4)" do
        piece = Bishop.new(:white, [3,4])
        expect(piece.captures).to eq [ [0,1], [1,2], [2,3], [4,5], [5,6], [6,7], [0,7], [1,6], [2,5], [4,3], [5,2], [6,1], [7,0] ]
      end      

      it "returns a list of valid positions that can be captured from (4,3)" do
        piece = Bishop.new(:white, [4,3])
        expect(piece.captures).to eq [ [1,0], [2,1], [3,2], [5,4], [6,5], [7,6], [0,7], [1,6], [2,5], [3,4], [5,2], [6,1], [7,0] ]
      end 

      it "returns a list of valid positions that can be captured from (1,6)" do
        piece = Bishop.new(:white, [1,6])
        expect(piece.captures).to eq [ [0,5], [2,7], [0,7], [2,5], [3,4], [4,3], [5,2], [6,1], [7,0] ]
      end 

    end # context "#captures"
      
=begin
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
=end

  end
end