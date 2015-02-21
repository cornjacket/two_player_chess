# spec/cell_spec.rb
require "spec_helper"

module TwoPlayerChess
  describe Cell do
    # tests will be added here

    context "#initialize" do
      it "is initialized with a value of '' by default" do
        cell = Cell.new
        expect(cell.value).to eq ''
      end

      it "can be initialize with a value of 'X'" do
        cell = Cell.new("X")
        expect(cell.value).to eq 'X'
      end
      

    end # context "#initialize"

  end
end