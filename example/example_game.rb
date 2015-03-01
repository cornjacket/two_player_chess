# /example/example_game.rb
require_relative "../lib/two_player_chess.rb"

puts "Welcome to two player chess"
bob = TwoPlayerChess::Player.new({color: :white, name: "White"})
frank = TwoPlayerChess::Player.new({color: :black, name: "Black"})
players = [bob, frank]
TwoPlayerChess::Game.new(players).play