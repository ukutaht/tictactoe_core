require 'tic_tac_toe/core/game'

describe TicTacToe::Core::ComputerPlayer do
   let(:computer) {TicTacToe::Core::ComputerPlayer.new("X")}
      
   it 'takes win if can take win' do
     board = TicTacToe::Core::Board.new("   OXXOXO")
     expect(computer.get_next_move(board)).to eq 1
   end

   it 'blocks opponents winning move' do
     board = TicTacToe::Core::Board.new("X   O O  ")
     expect(computer.get_next_move(board)).to eq 2
   end

   it 'forks if can fork' do
     board = TicTacToe::Core::Board.new( "XO  X   O")
     forks = [3, 6]
     move = computer.get_next_move(board)

     expect(forks).to include(move)
   end

   it 'forces opponent to defend when opponent can fork' do
     board = TicTacToe::Core::Board.new("OX  O   X")
     good_moves = [2, 5, 6, 3]
     move = computer.get_next_move(board)

     expect(good_moves).to include(move)
  end

   it 'two draw ' do
     game = TicTacToe::Core::Game.new
     game.computer_vs_computer
     until game.over?
       game.play_next_move
     end
     expect(game.winner).to eq nil
   end
end
