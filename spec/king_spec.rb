# spec/piece_spec.rb
require "spec_helper"

module TwoPlayerChess
  describe King do

    context "#initialize" do
      it "raises an error if initialized without 2 parameters" do
        expect { King.new() }.to raise_error
      end    

      it "can be initialized with a color of :white" do
        piece = King.new(:white, [0,0])
        expect(piece.color).to eq :white
      end

      it "can be initialized with a location of [0,0]" do
        piece = King.new(:black, [0,0])
        expect(piece.location).to eq [0,0]
      end


    end # context "#initialize"



    context "#first_move" do

      it "initially sets first_move to true" do
        piece = King.new(:white, [0,0])
        expect(piece.first_move).to eq true
      end

    end # context "#first_move"
=begin
    context "#captures" do

      it "returns a list of valid positions that can be captured from (3,4)" do
        piece = Queen.new(:white, [3,4])
        expect(piece.captures).to eq [ [0,1], [1,2], [2,3], [4,5], [5,6], [6,7], [0,7], [1,6], [2,5], [4,3], [5,2], [6,1], [7,0], 
                                       [3,0], [3,1], [3,2], [3,3], [3,5], [3,6], [3,7], [0,4], [1,4], [2,4], [4,4], [5,4], [6,4], [7,4] ]
      end      

      it "returns a list of valid positions that can be captured from (4,3)" do
        piece = Queen.new(:white, [4,3])
        expect(piece.captures).to eq [ [1,0], [2,1], [3,2], [5,4], [6,5], [7,6], [0,7], [1,6], [2,5], [3,4], [5,2], [6,1], [7,0],
                                     [4,0], [4,1], [4,2], [4,4], [4,5], [4,6], [4,7], [0,3], [1,3], [2,3], [3,3], [5,3], [6,3], [7,3] ]
      end 

      it "returns a list of valid positions that can be captured from (1,6)" do
        piece = Queen.new(:white, [0,6])
        expect(piece.captures).to eq [ [0,5], [2,7], [0,7], [2,5], [3,4], [4,3], [5,2], [6,1], [7,0],
                                       [1,0], [1,1], [1,2], [1,3], [1,4], [1,5], [1,7], [0,6], [2,6], [3,6], [4,6], [5,6], [6,6], [7,6] ]
      end 

    end # context "#captures"
      

    context "#moves" do

      it "returns a list of valid positions that can be moved to from (3,4)" do
        piece = Queen.new(:white, [3,4])
        expect(piece.moves).to eq [ [0,1], [1,2], [2,3], [4,5], [5,6], [6,7], [0,7], [1,6], [2,5], [4,3], [5,2], [6,1], [7,0], 
                                       [3,0], [3,1], [3,2], [3,3], [3,5], [3,6], [3,7], [0,4], [1,4], [2,4], [4,4], [5,4], [6,4], [7,4] ]
      end      

      it "returns a list of valid positions that can be moved to from (4,3)" do
        piece = Queen.new(:white, [4,3])
        expect(piece.moves).to eq [ [1,0], [2,1], [3,2], [5,4], [6,5], [7,6], [0,7], [1,6], [2,5], [3,4], [5,2], [6,1], [7,0],
                                     [4,0], [4,1], [4,2], [4,4], [4,5], [4,6], [4,7], [0,3], [1,3], [2,3], [3,3], [5,3], [6,3], [7,3] ]
      end 

      it "returns a list of valid positions that can be moved to from (1,6)" do
        piece = Queen.new(:white, [1,6])
        expect(piece.moves).to eq [ [0,5], [2,7], [0,7], [2,5], [3,4], [4,3], [5,2], [6,1], [7,0],
                                       [1,0], [1,1], [1,2], [1,3], [1,4], [1,5], [1,7], [0,6], [2,6], [3,6], [4,6], [5,6], [6,6], [7,6] ]
      end 


    end # context "#moves"
=end

  end
end