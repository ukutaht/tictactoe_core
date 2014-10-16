require 'tic_tac_toe-core'

game = TicTacToe::Core::Game.new
game.computer_vs_computer
until game.over?
  game.play_next_move
end
puts game.winner

