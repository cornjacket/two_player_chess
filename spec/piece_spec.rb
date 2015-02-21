# spec/piece_spec.rb
require "spec_helper"

module TwoPlayerChess
  describe Piece do
    # tests will be added here

    context "#initialize" do
      it "raises an error if initialized without 2 parameters" do
        expect { Piece.new() }.to raise_error
      end    

      it "can be initialized with a color of :white" do
        piece = Piece.new(:white, [0,0])
        expect(piece.color).to eq :white
      end

      it "can be initialized with a location of [0,0]" do
        piece = Piece.new(:black, [0,0])
        expect(piece.location).to eq [0,0]
      end      

    end # context "#initialize"
  
    context "#col" do  

      it "returns the col value of the location" do
        piece = Piece.new(:white, [4,6])
        expect(piece.col).to eq 4
      end     

    end # context "#col"

    context "#row" do  

      it "returns the row value of the location" do
        piece = Piece.new(:white, [4,6])
        expect(piece.row).to eq 6
      end     

    end # context "#col"

  end
end