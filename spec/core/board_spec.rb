require 'tic_tac_toe/core/board'

describe TicTacToe::Core::Board do
  let(:mid_game_str) { "O   X    " }
  let(:diagonal_win_str) {"O X X X  "}
  let(:horizontal_win_str) {"OOO X X  "}
  let(:vertical_win_str) {"XOOXX X O"}
  let(:draw_board_str) {"XOXXXOOXO"}
  
  let(:mid_game_board) { TicTacToe::Core::Board.new(mid_game_str) }
  let(:diagonal_win_board) { TicTacToe::Core::Board.new(diagonal_win_str) }
  let(:horizontal_win_board) { TicTacToe::Core::Board.new(horizontal_win_str) }
  let(:vertical_win_board) { TicTacToe::Core::Board.new(vertical_win_str) }
  let(:draw_board) { TicTacToe::Core::Board.new(draw_board_str) }
  

  describe '#valid_move?' do
    it 'returns true for valid move' do
      expect(mid_game_board.valid_move?(1))
        .to be_truthy
    end

    it 'returns false if cell already occupied' do
      expect(mid_game_board.valid_move?(0))
        .to be_falsey
    end

    it 'returns false if out of range' do
      expect(mid_game_board.valid_move?(-1))
        .to be_falsey
    end
  end

  describe '#valid_moves' do
    it 'returns all valid moves' do
      expect(mid_game_board.valid_moves).to eq [1, 2, 3, 5, 6, 7, 8]
    end

     it 'returns empty list for full board' do
       expect(draw_board.valid_moves).to eq []
     end
  end

  describe '#over?' do
    context 'game not over' do
      it 'is false' do
        expect(mid_game_board.game_over?).to be_falsey
      end
    end

    context 'diagonal win' do
      it 'is true' do
        expect(diagonal_win_board.game_over?).to be_truthy
      end
    end

    context 'horizontal win' do
      it 'is true' do
        expect(horizontal_win_board.game_over?).to be_truthy
      end
    end

    context 'vertical win' do
      it 'is true' do
        expect(vertical_win_board.game_over?).to be_truthy
      end
    end
    context 'draw' do
      it 'is true' do
        expect(draw_board.game_over?).to eq true
      end
    end
  end

  describe '.winner' do
    context 'we have a winner' do
      it 'returns the winners mark' do
        expect(horizontal_win_board.winner).to eq "O"
      end
    end

    context 'no winner' do
      it 'returns no winner' do
        expect(mid_game_board.winner).to be_falsey
      end
    end
  end

  describe '#move' do
    it 'returns new board' do
      expect(mid_game_board.move(8, "X")).to_not equal(mid_game_board)
    end

    it 'places the mark' do
      expect(mid_game_board.move(8, "X").char_at(8)).to eq "X"
    end
  end

  describe '#move!' do
    it 'places the mark' do
      expect(mid_game_board.move!(8, "X").char_at(8)).to eq "X"
    end
  end

  describe '#empty?' do
    it 'is true for empty board' do
      expect(TicTacToe::Core::Board.new.empty?).to be_truthy
    end

    it 'is false for non-empty board' do
      expect(mid_game_board.empty?).to be_falsey
    end
  end

  describe '4x4' do
    let(:board) {TicTacToe::Core::Board.new("                ")}
    it 'accepts move at index 10 as valid' do
      expect(board.valid_move?(10)).to be_truthy
    end

    it 'move at index 16 is invalid' do
      expect(board.valid_move?(16)).to be_falsey
    end

    it 'calculates winning combinations for the given board size' do
      expect(board.winning_combinations).to include [0, 1, 2, 3]
    end

    it 'recognises winner' do
      board = TicTacToe::Core::Board.new("XXXX            ")

      expect(board.winner).to eq "X"
    end
  end

  describe 'setting and getting size' do
    let(:board) { TicTacToe::Core::Board.new }

    it 'can set its size to an arbitrary value' do
      board.set_size(10)

      expect(board.valid_move?(99)).to be_truthy
    end

    it 'sets size attribute' do
      board.set_size 5

      expect(board.size).to eq 5
    end
  end
end
