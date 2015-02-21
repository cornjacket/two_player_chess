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

      it "can be initialize with a value of 'something'" do
        cell = Cell.new("something")
        expect(cell.value).to eq 'something'
      end
      

    end # context "#initialize"

  end
end