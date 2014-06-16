module TicTacToe
  module Core
    class HumanPlayer
      attr_reader :mark

      def initialize(mark)
        @mark = mark
      end

      def human?
        true
      end

      def can_make_move?(board, index)
        board.valid_move?(index)
      end

      def make_move(board, index)
        board.move!(index, mark)
      end
    end
  end
end

