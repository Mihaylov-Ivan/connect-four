require_relative './lib/game.rb'

def play
    connect_four = Game.new
    connect_four.play
end

play
