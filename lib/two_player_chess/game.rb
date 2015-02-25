# lib/tic_tac_toe_OOP/game.rb
module TwoPlayerChess
  class Game
  	attr_reader :players, :board, :current_player, :other_player
  	
  	def initialize(players, board = Board.new)
  	  @players = players
  	  @board = board
      board.set_up
  	  @current_player, @other_player = players.shuffle
  	end

    def switch_players
      @current_player, @other_player = @other_player, @current_player
    end

    def solicit_move
      "#{current_player.name}: Enter a number between 0 and 7 to make your move"
    end

    def get_move(human_move = gets.chomp)
      human_move.to_s
      #human_move_to_coordinate(human_move)
    end

    def game_over_message
      return "#{current_player.name} won!" if board.game_over == :winner
      return "The game ended in a tie" if board.game_over == :draw
    end

    def play
      puts "#{current_player.name} has randomly been selected as the first player"
      while true
        board.formatted_grid
        puts ""
        puts solicit_move
        from_x = get_move.to_i
        puts solicit_move
        from_y = get_move.to_i
        puts solicit_move
        to_x = get_move.to_i
        puts solicit_move
        to_y = get_move.to_i
        puts "from (#{from_x},#{from_y}) => (#{to_x},#{to_y})"

        valid_move = board.valid_move?(current_player.color,from_x, from_y, to_x, to_y)
        puts "valid_move = #{valid_move}"
        board.move_piece(from_x, from_y, to_x, to_y) if valid_move != false

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

    def human_move_to_coordinate(human_move)
      mapping = {
        "1" => [0,0],
        "2" => [1,0],
        "3" => [2,0],
        "4" => [0,1],
        "5" => [1,1],
        "6" => [2,1],
        "7" => [0,2],
        "8" => [1,2],
        "9" => [2,2]
      }
      mapping[human_move]
    end

  end # Game
end