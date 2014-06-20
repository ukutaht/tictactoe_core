require 'tic_tac_toe/core/board'
require 'tic_tac_toe/core/computer_player'
require 'tic_tac_toe/core/human_player'

module TicTacToe
  module Core
    class Game
      VALID_BOARD_SIZES = [3,4]

      attr_reader :board, :players

      def initialize(board=TicTacToe::Core::Board.new)
        @board = board
        @players = []
      end

      def play_next_move(board_index=nil)
        if current_player.can_make_move?(board, board_index)
          current_player.make_move(board, board_index)
          players.rotate!
        end
      end

      def set_board_size(size)
        return false unless VALID_BOARD_SIZES.include?(size)

        board.set_size(size)
      end

      def human_vs_human
        @players = [human_player("X"), human_player("O")]
      end

      def computer_vs_computer
        @players = [computer_player("X"), computer_player("O")]
      end

      def human_goes_first
        @players = [human_player("X"), computer_player("O")]
      end

      def computer_goes_first
        @players = [computer_player("X"), human_player("O")]
      end

      def current_player
        players.first
      end

      def need_players?
        players.size < 2
      end

      def board_size_set?
        !!board.size
      end

      def over?
        board.game_over?
      end

      def winner
        board.winner
      end

      def reset!
        @players = []
        @board = TicTacToe::Core::Board.new
      end

      def board_string
        board.to_s
      end

      private

      def valid_move?(index)
        board.valid_move?(index)
      end

     def human_player(mark)
        TicTacToe::Core::HumanPlayer.new(mark)
     end

      def computer_player(mark)
        TicTacToe::Core::ComputerPlayer.new(mark)
      end
    end
  end
end
