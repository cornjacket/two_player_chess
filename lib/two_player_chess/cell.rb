#lib/two_player_chess/cell.rb
module TwoPlayerChess
  class Cell
    attr_accessor :value
    def initialize(value = "")
      @value = value
    end
  end
end