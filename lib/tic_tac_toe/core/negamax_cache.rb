module TicTacToe
  module Core
    class NegamaxCache

      def initialize
        @transposition_table = {}
      end

      def lookup(state)
        entry = @transposition_table[state.board.to_sym]

        if entry && entry[:depth] >= state.depth
          if entry[:flag] == :exact
            return entry[:score]
          elsif entry[:flag] == :lower
            state.alpha = [state.alpha, entry[:score]].max
          elsif entry[:flag] == :upper
            state.beta = [state.beta, entry[:score]].min
          end
        end

        if state.alpha >= state.beta
          return entry[:score]
        end
        false
      end


      def insert(state)
        new_entry = {}
        new_entry[:score] = state.score

        if state.score <= state.alpha
          new_entry[:flag] = :upper
        elsif state.score >= state.beta
          new_entry[:flag] = :lower
        else
          new_entry[:flag] = :exact
        end
        new_entry[:depth] = state.depth

        @transposition_table[state.board.to_sym] = new_entry
      end 
    end
  end
end

