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

    context "#move_creates_check?" do

# set up looks look but not getting back right value - dbug method
      it "returns true if the king gets in the attack path of the bishop" do
        board = Board.new()
        board.set_up        
        #remove white kings pawn
        board.set_cell(4,1,nil)
        #remove black queens pawn to open up path for bishop
        board.set_cell(3,6,nil)
        #move black bishop to attacking the white queen
        board.move_piece(2,7,6,3)
        #does moving the white king in front of the queen create a check
        expect(board.move_creates_check?(:white,4,0,4,1)).to eq true
      end

    end 

    context "#deep_copy" do
      it "copies a board with the same values" do
        board = Board.new
        board.set_up
        copy = board.deep_copy

        expect(copy.white_king_loc).to eq board.white_king_loc
        expect(copy.black_king_loc).to eq board.black_king_loc        
        expect(copy.white_king).to_not eq board.white_king
        expect(copy.black_king).to_not eq board.black_king
        expect(copy.white_king.first_move).to eq board.white_king.first_move        
        expect(copy.black_king.first_move).to eq board.black_king.first_move
        x = copy.white_king_loc[0]
        y = copy.white_king_loc[1]
        expect(copy.white_king).to eq copy.get_cell(x,y).value
        x = copy.black_king_loc[0]
        y = copy.black_king_loc[1]
        expect(copy.black_king).to eq copy.get_cell(x,y).value
        8.times do |x|
          y = 0  
          old_piece = board.get_cell(x,y).value
          new_piece = copy.get_cell(x,y).value
          expect(old_piece.to_s).to eq new_piece.to_s
          expect(old_piece.first_move).to eq new_piece.first_move if old_piece.special_move
          expect(old_piece).to_not eq new_piece
        end
        8.times do |x|
          y = 1  
          old_piece = board.get_cell(x,y).value
          new_piece = copy.get_cell(x,y).value
          expect(old_piece.to_s).to eq new_piece.to_s
          expect(old_piece.first_move).to eq new_piece.first_move if old_piece.special_move
          expect(old_piece).to_not eq new_piece
        end
        8.times do |x|
          y = 6  
          old_piece = board.get_cell(x,y).value
          new_piece = copy.get_cell(x,y).value
          expect(old_piece.to_s).to eq new_piece.to_s
          expect(old_piece.first_move).to eq new_piece.first_move if old_piece.special_move
          expect(old_piece).to_not eq new_piece
        end
        8.times do |x|
          y = 7  
          old_piece = board.get_cell(x,y).value
          new_piece = copy.get_cell(x,y).value
          expect(old_piece.to_s).to eq new_piece.to_s
          expect(old_piece.first_move).to eq new_piece.first_move if old_piece.special_move
          expect(old_piece).to_not eq new_piece
        end        

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

    context "#in_check?" do

      it "returns false for the initial game board set up" do
        board = Board.new()
        board.set_up
        expect(board.in_check?(:white)).to eq false     
      end

      it "returns true when the white king is under attack by a black rook" do
        board = Board.new()
        x = 4
        y = 0
        board.set_cell(x,y, King.new(:white))
        board.set_king_location(:white, [x,y])
        board.set_cell(4,7, Rook.new(:black))       
        expect(board.in_check?(:white)).to eq true
      end

      it "returns true when the black king is under attack by a white rook" do
        board = Board.new()
        x = 4
        y = 7
        board.set_cell(x,y, King.new(:black))
        board.set_king_location(:black, [x,y])
        board.set_cell(4,0, Rook.new(:white))       
        expect(board.in_check?(:black)).to eq true
      end      

      it "returns false when the white king is in the attack path of the white rook" do
        board = Board.new()
        x = 4
        y = 0
        board.set_cell(x,y, King.new(:white))
        board.set_king_location(:white, [x,y])
        board.set_cell(4,7, Rook.new(:white))       
        expect(board.in_check?(:white)).to eq false
      end      

      it "returns true when the white king is under attack by a black pawn" do
        board = Board.new()
        x = 4
        y = 0
        board.set_cell(x,y, King.new(:white))
        board.set_king_location(:white, [x,y])
        board.set_cell(5,1, Pawn.new(:black))       
        expect(board.in_check?(:white)).to eq true
      end      

    end      

    context "#king" do
      it "is initially nil" do
        board = Board.new()
        expect(board.king(:white)).to eq nil
      end

      it "can refer to the white king after set_up" do
        board = Board.new()
        board.set_up
        expect(board.king(:white).special_move).to eq :king_castle
        expect(board.king(:white).color).to eq :white        
      end

      it "can refer to the black king after set_up" do
        board = Board.new()
        board.set_up
        expect(board.king(:black).special_move).to eq :king_castle
        expect(board.king(:black).color).to eq :black
      end

    end


    context "#get_king_location" do

      it "is initially nil" do
        board = Board.new()
        expect(board.get_king_location(:white)).to eq nil
      end

      it "can access the white king's location after set_up" do
        board = Board.new()
        board.set_up
        expect(board.get_king_location(:white)).to eq [4,0]
      end

      it "can access the black king's location after set_up" do
        board = Board.new()
        board.set_up
        expect(board.get_king_location(:black)).to eq [4,7]
      end

    end    

    context "#set_king_location" do

      it "can change the white king's location" do
        board = Board.new()
        board.set_king_location(:white,[4,1])
        expect(board.get_king_location(:white)).to eq [4,1]
      end

      it "can change the black king's location" do
        board = Board.new()
        board.set_up
        board.set_king_location(:black,[4,6])
        expect(board.get_king_location(:black)).to eq [4,6]
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


    end # context #game_over

  end
end