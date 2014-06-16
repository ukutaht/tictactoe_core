module TicTacToe
  module Core
    class Board
      attr_reader :board_string, :size

      STARTING_BOARD =  "         "
      EMPTY = " "

      def initialize(board_string=STARTING_BOARD)
        @board_string = board_string.dup
      end

      def valid_move?(i)
        valid_moves.include?(i)
      end

      def valid_moves
        @valid_moves ||= (0...board_string.size).select{|i| board_string[i] == EMPTY}
      end

      def set_size(size)
        @size = size
        @board_string = EMPTY * (size**2)
      end

      def game_over?
        winner || draw?
      end

      def winning_combinations
        @winning_combinations ||= calculate_winning_combinations
      end

      def winner
        winner = nil
        winning_combinations.each do | triplet|
          winner = board_string[triplet.first] if winning_row?(triplet)
        end
        winner
      end

      def draw?
        valid_moves.empty?
      end

      def move!(index, mark)
        valid_moves.delete(index)
        @board_string[index] = mark
        self
      end
      
      def move(index, mark)
        Board.new(board_string.dup).move!(index, mark)
      end

      def char_at(i)
        board_string[i]
      end

      def to_s 
        board_string
      end

      def to_sym
        board_string.to_sym
      end

      def empty?
        board_string.chars.all?{|char| char == EMPTY}
      end

      def empty_square
        EMPTY
      end

      private

      def calculate_winning_combinations
        side_length = Math.sqrt(board_string.size)

        indices_ary = (0...board_string.size).each_slice(side_length).to_a

        [indices_ary, indices_ary.transpose, [diagonal(indices_ary, side_length), diagonal(indices_ary.transpose.map(&:reverse), side_length)]].flatten(1)
      end

      def diagonal(ary, side_length)
        0.upto(side_length - 1).map do |i|
          ary[i][i]
        end
      end

      def winning_row?(triplet)
        mark = board_string[triplet.first]
        return false if mark == EMPTY
        triplet.all?{|i| board_string[i] == mark }
      end
    end
  end
end
