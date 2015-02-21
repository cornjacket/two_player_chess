# spec/piece_spec.rb
require "spec_helper"

module TwoPlayerChess
  describe Pawn do
    # tests will be added here

    context "#initialize" do
      it "raises an error if initialized without 2 parameters" do
        expect { Pawn.new() }.to raise_error
      end    

      it "can be initialize with a color of 'White'" do
        piece = Pawn.new("White", [0,0])
        expect(piece.color).to eq 'White'
      end

      it "can be initialize with a location of [0,0]" do
        piece = Pawn.new("Black", [0,0])
        expect(piece.location).to eq [0,0]
      end      

    end # context "#initialize"




      

  end
end