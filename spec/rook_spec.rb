# spec/piece_spec.rb
require "spec_helper"

module TwoPlayerChess
  describe Rook do

    context "#initialize" do
      it "raises an error if initialized without 2 parameters" do
        expect { Rook.new() }.to raise_error
      end    

      it "can be initialized with a color of :white" do
        piece = Rook.new(:white, [0,0])
        expect(piece.color).to eq :white
      end

      it "can be initialized with a location of [0,0]" do
        piece = Rook.new(:black, [0,0])
        expect(piece.location).to eq [0,0]
      end


    end # context "#initialize"

=begin
    context "#captures" do

      it "returns a list of valid positions that can be captured from (3,4)" do
        piece = .new(:white, [3,4])
        expect(piece.captures).to eq [ [0,1], [1,2], [2,3], [4,5], [5,6], [6,7], [0,7], [1,6], [2,5], [4,3], [5,2], [6,1], [7,0] ]
      end      

      it "returns a list of valid positions that can be captured from (4,3)" do
        piece = .new(:white, [4,3])
        expect(piece.captures).to eq [ [1,0], [2,1], [3,2], [5,4], [6,5], [7,6], [0,7], [1,6], [2,5], [3,4], [5,2], [6,1], [7,0] ]
      end 

      it "returns a list of valid positions that can be captured from (1,6)" do
        piece = .new(:white, [1,6])
        expect(piece.captures).to eq [ [0,5], [2,7], [0,7], [2,5], [3,4], [4,3], [5,2], [6,1], [7,0] ]
      end 

    end # context "#captures"
      

    context "#moves" do

      it "returns a list of valid positions that can be moved from (3,4)" do
        piece = .new(:white, [3,4])
        expect(piece.moves).to eq [ [0,1], [1,2], [2,3], [4,5], [5,6], [6,7], [0,7], [1,6], [2,5], [4,3], [5,2], [6,1], [7,0] ]
      end      

      it "returns a list of valid positions that can be moved from (4,3)" do
        piece = .new(:white, [4,3])
        expect(piece.moves).to eq [ [1,0], [2,1], [3,2], [5,4], [6,5], [7,6], [0,7], [1,6], [2,5], [3,4], [5,2], [6,1], [7,0] ]
      end

      it "returns a list of valid positions that can be moved from (1,6)" do
        piece = .new(:white, [1,6])
        expect(piece.moves).to eq [ [0,5], [2,7], [0,7], [2,5], [3,4], [4,3], [5,2], [6,1], [7,0] ]
      end


    end # context "#moves"
=end

  end
end