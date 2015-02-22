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

    context "#captures" do

      it "returns a list of valid positions that can be captured from (3,4)" do
        piece = King.new(:white, [3,4])
        expect(piece.captures).to eq [ [2,4], [2,5], [3,5], [4,5], [4,4], [4,3], [3,3], [2,3] ]                                     
      end      

      it "returns a list of valid positions that can be captured from (4,3)" do
        piece = King.new(:white, [4,3])
        expect(piece.captures).to eq [ [3,3], [3,4], [4,4], [5,4], [5,3], [5,2], [4,2], [3,2] ]
      end 

      it "returns a list of valid positions that can be captured from (1,6)" do
        piece = King.new(:white, [0,6])
        expect(piece.captures).to eq [ [0,7], [1,7], [1,6], [1,5], [0,5] ]
      end 

    end # context "#captures"
      
=begin
    context "#moves" do
   

    end # context "#moves"
=end

  end
end