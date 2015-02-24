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
        piece = Piece.new(:white)
        expect(piece.color).to eq :white
      end 

    end # context "#initialize"

  end
end