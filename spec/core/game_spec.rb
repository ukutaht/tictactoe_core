require 'tic_tac_toe/core/game'

describe TicTacToe::Core::Game do
  let(:game) { TicTacToe::Core::Game.new }


  it 'plays the human move if valid' do
    game.human_goes_first
    game.play_next_move(0)

    expect(game.board.char_at(0)).to eq "X"
  end

  it 'returns a truthy value if valid move was made' do
    game.human_goes_first

    expect(game.play_next_move(0)).to be_truthy
  end

  it 'does not make the move if move is invalid' do
    game.human_goes_first
    game.play_next_move(100)

    expect(game.board).to be_empty
  end

  it 'returns a falsey value if move was not made' do
    game.human_goes_first
    
    expect(game.play_next_move(-1)).to be_falsey
  end


  it 'sets the boards size' do
    game.set_board_size(4)

    expect(game.board_string.size).to eq 16
  end

  it 'knows when size is set' do
    game.set_board_size(4)

    expect(game.board_size_set?).to eq true
  end

  it 'knows when size is not yet set' do
    expect(game.board_size_set?).to eq false
  end

  it 'returns a truthy value if valid board size was set' do
    expect(game.set_board_size(4)).to be_truthy
  end

  it 'does not set the size to an invalid board size' do
    game.set_board_size(5)

    expect(game.board_string.size).to_not eq 25
  end

  it 'returns a falsey value if invalid board size was given' do
    expect(game.set_board_size(5)).to be_falsey
  end


  it 'plays a computer move if current player is computer' do
    game.computer_goes_first
    game.play_next_move

    expect(game.board).to_not be_empty
  end

  it 'rotates players after move' do
    game.human_goes_first
    game.play_next_move(0)

    expect(game.current_player).to_not be_human
  end

  it 'gets rid of players on reset' do
    game.human_goes_first
    game.reset!

    expect(game.players.size).to eq 0
  end

  it 'resets board on reset' do
    game.human_goes_first
    game.play_next_move(0)
    game.reset!

    expect(game.board.valid_moves.size).to eq 9
  end
end
