# coding: utf-8
# lib/tic_tac_toe_OOP/game.rb
module TwoPlayerChess
  class Game
  	attr_reader :players, :board, :current_player, :other_player
    attr_accessor :from_x, :from_y, :to_x, :to_y
  	
  	def initialize(players, board = Board.new)
  	  @players = players
  	  @board = board
      board.set_up
  	  @current_player, @other_player = players
      @from_x = 0
      @from_y = 0
      @to_x = 0
      @to_y = 0
  	end

    def switch_players
      @current_player, @other_player = @other_player, @current_player
    end

    def solicit_move
      "#{current_player.name}: Enter your move (ie. e2e4)"
    end

# Need to test this
    def get_move(human_move = gets.chomp)
      if ( human_move =~ /^[a-hA-H][1-8][a-hA-H][1-8]/ )
          self.from_x = alpha_to_int(human_move[0].downcase)
          self.from_y = human_move[1].to_i - 1
          self.to_x   = alpha_to_int(human_move[2].downcase)
          self.to_y   = human_move[3].to_i - 1        
        return
      end
      self.from_x = -1
      self.from_y = -1
      self.to_x   = -1
      self.to_y   = -1
    end

    def get_promotion(color)
      done = false
      while !done
        print "#{color}'s pawn has been promoted. Which piece do you select? (q, r, b, n) :"
        choice = gets.chomp.downcase # what is wrong with this????
        if choice[0] == 'q'
          result = :queen
          done = true
        elsif choice[0] == 'r'
          result = :rook
          done = true
        elsif choice[0] == 'b'
          result = :bishop
          done = true
        elsif choice[0] == 'n'
          result = :knight
          done = true
        end
      end
      result
    end  

    def game_over_message
      return "#{current_player.name} won!" if board.game_over == :winner
      return "The game ended in a tie" if board.game_over == :draw
    end

    def play

      while true
        begin
          checkmark = "\u2713"
          puts checkmark
          puts checkmark.encode('utf-8')
          puts checkmark.force_encoding('utf-8')
          board.formatted_grid
          puts ""
          color = current_player.color
          if board.in_check?(color)
            puts "#{color} is in check"  
          end
          puts solicit_move
          get_move
          puts "from (#{from_x},#{from_y}) => (#{to_x},#{to_y})"
          valid_move = board.valid_move?(color,from_x, from_y, to_x, to_y)
          puts "valid_move = #{valid_move}"
        end until valid_move != false
        board.move_piece(from_x, from_y, to_x, to_y) #if valid_move != false        
        if valid_move == :castle
          board.castle_rook(color,from_x,from_y,to_x)
        elsif valid_move == :promotion 
          board.promote_pawn(color,to_x,to_y,get_promotion(color))
        end
        if board.in_check?(other_player.color)
          if board.check_mate?(other_player.color)
            check_mate = true
            puts "#{other_player.color} has been check-mated"
            break # does this take us outside of begin end until loop
          #else
          #  puts "#{other_player.color} is in check"  
          end            
        end        
        if board.game_over
          puts game_over_message
          board.formatted_grid
          return
        else
          switch_players
        end
      end      
    end

    private

    def alpha_to_int(human_move)
      mapping = {
        "a" => 0,
        "b" => 1,
        "c" => 2,
        "d" => 3,
        "e" => 4,
        "f" => 5,
        "g" => 6,
        "h" => 7
      }
      mapping[human_move]
    end

  end # Game
end