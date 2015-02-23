# lib/tic_tac_toe/player.rb
module TwoPlayerChess
  class Player
  	attr_reader :color, :name
  	def initialize(input)
  	  @color = input.fetch(:color)
  	  @name = input.fetch(:name)
  	end
  end
end