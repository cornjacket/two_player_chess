# spec/piece_spec.rb
require "spec_helper"

module TwoPlayerChess
  describe Knight do

    context "#initialize" do
      it "raises an error if initialized without 2 parameters" do
        expect { Knight.new() }.to raise_error
      end    

      it "can be initialized with a color of :white" do
        piece = Knight.new(:white, [0,0])
        expect(piece.color).to eq :white
      end

      it "can be initialized with a location of [0,0]" do
        piece = Knight.new(:black, [0,0])
        expect(piece.location).to eq [0,0]
      end


    end # context "#initialize"


    context "#captures" do

      it "returns a list of valid positions that can be captured from (3,4)" do
        piece = Knight.new(:white, [3,4])
        expect(piece.captures).to eq [ [2,6], [1,5], [1,3], [2,2], [4,2], [5,3], [5,5], [4,6] ]
      end                             #  -1,+2  -2,+1  -2,-1  -1,-2  +1,-2  +2,-1  +2,+1  +1,+2

      it "returns a list of valid positions that can be captured from (4,3)" do
        piece = Knight.new(:white, [4,3])
        expect(piece.captures).to eq [ [3,5], [2,4], [2,2], [3,1], [5,1], [6,2], [6,4], [5,5] ]
      end 

      it "returns a list of valid positions that can be captured from (1,6)" do
        piece = Knight.new(:white, [1,6])
        expect(piece.captures).to eq [ [0,4], [2,4], [3,5], [3,7] ]
      end 

    end # context "#captures"
      

    context "#moves" do

      it "returns a list of valid positions that can be moved to from (3,4)" do
        piece = Knight.new(:white, [3,4])
        expect(piece.moves).to eq [ [2,6], [1,5], [1,3], [2,2], [4,2], [5,3], [5,5], [4,6] ]
      end                             #  -1,+2  -2,+1  -2,-1  -1,-2  +1,-2  +2,-1  +2,+1  +1,+2

      it "returns a list of valid positions that can be moved to from (4,3)" do
        piece = Knight.new(:white, [4,3])
        expect(piece.moves).to eq [ [3,5], [2,4], [2,2], [3,1], [5,1], [6,2], [6,4], [5,5] ]
      end 

      it "returns a list of valid positions that can be moved to from (1,6)" do
        piece = Knight.new(:white, [1,6])
        expect(piece.moves).to eq [ [0,4], [2,4], [3,5], [3,7] ]
      end 


    end # context "#moves"


  end
end