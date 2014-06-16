require 'tic_tac_toe/core/human_player'
require 'tic_tac_toe/core/board'

describe TicTacToe::Core::HumanPlayer do
  let(:board) { TicTacToe::Core::Board.new }
  let(:player) { TicTacToe::Core::HumanPlayer.new("X") }

  it 'makes a move if index is valid' do
    player.make_move(board, 1)
    
    expect(board.char_at(1)).to eq "X"
  end

  it 'returns truthy value if move was made' do
    expect(player.can_make_move?(board, 1)).to be_truthy
  end
end

