# spec/cell_spec.rb
require "spec_helper"

module TwoPlayerChess
  describe Board do
    # tests will be added here

    context "#initialize" do
      it "initializes the board with a grid" do
        expect { Board.new(grid: "grid") }.to_not raise_error
      end    

      
    end # context "#initialize"

    context "#grid" do
      it "returns the grid" do
        board = Board.new(grid: "blah")
        expect(board.grid).to eq "blah"
      end
    end


    context "#valid_move?" do
      it "returns false when player tries to move an empty square" do
        board = Board.new
        expect(board.valid_move?(:white,0,0,0,1)).to eq false
      end

      it "returns false when player tries to move an opponent's piece" do
        pawn = Pawn.new(:white) 
        board = Board.new
        board.set_cell(0,0,pawn)
        expect(board.valid_move?(:black,0,0,0,1)).to eq false
      end      

      it "returns false when player tries to move on to a square already occupied with the same colored piece" do
        pawn = Pawn.new(:white) 
        bishop = Bishop.new(:white)
        board = Board.new
        board.set_cell(0,0,pawn)
        board.set_cell(0,1,bishop)
        expect(board.valid_move?(:white,0,0,0,1)).to eq false
      end

      it "returns :capture when player tries to capture an opposing piece" do
        pawn = Pawn.new(:white) 
        bishop = Bishop.new(:black)
        board = Board.new
        board.set_cell(0,1,pawn)
        board.set_cell(1,2,bishop)
        expect(board.valid_move?(:white,0,1,1,2)).to eq :capture
      end

      it "returns :move when player tries to make a valid move" do
        pawn = Pawn.new(:white) 
        board = Board.new
        board.set_cell(0,0,pawn)
        expect(board.valid_move?(:white,0,0,0,1)).to eq :move
      end

## TODO - add tests for pieces blocking other pieces to make sure
# that pieces' movements are bounded correctly

    end


    context "#move_piece" do
      it "sets the value of the old (x,y) position to nil" do
        pawn = Pawn.new(:white) 
        board = Board.new
        board.set_cell(0,0,pawn)
        board.move_piece(0,0,1,0)
        expect(board.get_cell(0,0).value).to eq nil
      end

      it "sets the value of the new (x,y) position to the piece" do
        pawn = Pawn.new(:white) 
        board = Board.new
        board.set_cell(0,0,pawn)
        board.move_piece(0,0,1,0)
        expect(board.get_cell(1,0).value).to eq pawn
      end

    end

    context "#get_cell" do
      it "returns the cell based on the (x,y) coordinate" do
        grid = [ ["", "", ""], ["", "", "something"], ["", "", ""] ]
        board = Board.new(grid: grid)
        expect(board.get_cell(2,1)).to eq "something"
      end
    end


    context "#set_cell" do
      it "updates the value of the cell object at a (x,y) coordinate" do
        pawn = Pawn.new(:white) 
        board = Board.new
        board.set_cell(0,0,pawn)
        expect(board.get_cell(0,0).value).to eq pawn
      end

    end

    context "#empty_squares_between?" do

      it "returns true when all squares between from_x and to_x (from_x < to_x) on the same row are empty" do 
        board = Board.new
        board.set_up
        board.set_cell(5,0,nil)
        board.set_cell(6,0,nil)
        from_x = 4
        from_y = 0
        to_x = 7
        expect(board.empty_squares_between?(from_x,from_y,to_x)).to eq true
      end

      it "returns true when all squares between from_x and to_x (from_x > to_x) on the same row are empty" do 
        board = Board.new
        board.set_up
        board.set_cell(1,0,nil)
        board.set_cell(2,0,nil)
        board.set_cell(3,0,nil)
        from_x = 4
        from_y = 0
        to_x = 0
        expect(board.empty_squares_between?(from_x,from_y,to_x)).to eq true
      end

      it "returns false when at least one squares between from_x and to_x on the same row is not empty" do 
        board = Board.new
        board.set_up
        board.set_cell(1,0,nil)
        board.set_cell(3,0,nil)
        from_x = 4
        from_y = 0
        to_x = 0
        expect(board.empty_squares_between?(from_x,from_y,to_x)).to eq false
      end

    end


    context "#white_king" do
      it "initially is nil" do
        board = Board.new()
        expect(board.white_king).to eq nil
      end

      it "is set to the white king after set_up" do
        board = Board.new()
        board.set_up
        expect(board.white_king.special_move).to eq :king_castle
      end

    end

    context "#black_king" do
      it "initially is nil" do
        board = Board.new()
        expect(board.black_king).to eq nil
      end

      it "is set to the black king after set_up" do
        board = Board.new()
        board.set_up
        expect(board.black_king.special_move).to eq :king_castle
      end

    end    

    context "#closest_root_can_castle?" do

      it "returns true when white king castles on the king side" do 
        board = Board.new
        board.set_up
        board.set_cell(5,0,nil)
        board.set_cell(6,0,nil)
        from_x = 4
        from_y = 0
        to_x = 4+2
        expect(board.closest_rook_can_castle?(:white,from_x,from_y,to_x)).to eq true
      end

      it "returns true when white king castles on the queen side" do 
        board = Board.new
        board.set_up
        board.set_cell(1,0,nil)
        board.set_cell(2,0,nil)
        board.set_cell(3,0,nil)
        from_x = 4
        from_y = 0
        to_x = 4-2
        expect(board.closest_rook_can_castle?(:white,from_x,from_y,to_x)).to eq true
      end      


      it "returns true when black king castles on the king side" do 
        board = Board.new
        board.set_up
        board.set_cell(5,7,nil)
        board.set_cell(6,7,nil)
        from_x = 4
        from_y = 7
        to_x = 4+2
        expect(board.closest_rook_can_castle?(:black,from_x,from_y,to_x)).to eq true
      end

      it "returns true when black king castles on the queen side" do 
        board = Board.new
        board.set_up
        board.set_cell(1,7,nil)
        board.set_cell(2,7,nil)
        board.set_cell(3,7,nil)
        from_x = 4
        from_y = 7
        to_x = 4-2
        expect(board.closest_rook_can_castle?(:black,from_x,from_y,to_x)).to eq true
      end  

      it "returns false when white king attempts to castle if the rook is not in rook position" do 
        board = Board.new
        board.set_up
        board.set_cell(5,0,nil)
        board.set_cell(6,0,nil)
        board.move_piece(7,0,6,0)
        from_x = 4
        from_y = 0
        to_x = 4+2
        expect(board.closest_rook_can_castle?(:white,from_x,from_y,to_x)).to eq false
      end

      it "returns false when white king attempts to castle if the rook is in rook position but has previously moved" do 
        board = Board.new
        board.set_up
        board.set_cell(5,0,nil)
        board.set_cell(6,0,nil)
        board.move_piece(7,0,6,0)
        board.move_piece(0,6,0,7)
        from_x = 4
        from_y = 0
        to_x = 4+2
        expect(board.closest_rook_can_castle?(:white,from_x,from_y,to_x)).to eq false
      end

      it "returns false when white king attempts to castle if the rook has been captured" do 
        board = Board.new
        board.set_up
        board.set_cell(5,0,nil)
        board.set_cell(6,0,nil)
        board.set_cell(7,0,nil)
        from_x = 4
        from_y = 0
        to_x = 4+2
        expect(board.closest_rook_can_castle?(:white,from_x,from_y,to_x)).to eq false
      end

    end




    TestCell = Struct.new(:value)
    let(:x_cell) { TestCell.new("X") }
    let(:y_cell) { TestCell.new("Y") }
    let(:empty) { TestCell.new }


    context "#game_over" do
      it "it returns :winner if winner? is true" do
        board = Board.new
        board.stub(:winner?) { true }
        expect(board.game_over).to eq :winner
      end

      it "it returns :draw if winner? is false and draw? is true" do
        board = Board.new
        board.stub(:winner?) { false }
        board.stub(:draw?) { true }
        expect(board.game_over).to eq :draw
      end

      it "it returns false if winner? is false and draw? is false" do
        board = Board.new
        board.stub(:winner?) { false }
        board.stub(:draw?) { false }
        expect(board.game_over).to be_falsy
      end      

=begin
      it "returns :winner when row has objects with values that are the same" do
        grid = [
        [x_cell, x_cell, x_cell],
        [y_cell, x_cell, y_cell],
        [y_cell, y_cell, empty]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end

      it "returns :winner when column has objects with values that are the same" do
        grid = [
        [x_cell, x_cell, empty],
        [y_cell, x_cell, y_cell],
        [y_cell, x_cell, empty]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end

      it "returns :winner when diagonal has objects with values that are the same" do
        grid = [
        [x_cell, empty, empty],
        [y_cell, x_cell, y_cell],
        [y_cell, x_cell, x_cell]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end

      it "returns :draw when all spaces on the board are taken" do
        grid = [
        [x_cell, y_cell, x_cell],
        [y_cell, x_cell, y_cell],
        [y_cell, x_cell, y_cell]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :draw
      end

      it "returns falsy when there is no winner or draw" do
        grid = [
        [x_cell, empty, empty],
        [y_cell, empty, empty],
        [y_cell, empty, empty]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to be_falsy
      end
=end
    end # context #game_over

  end
end