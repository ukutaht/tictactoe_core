require 'tic_tac_toe/core/negamax_cache'
module TicTacToe
  module Core
    class ComputerPlayer
      attr_reader :mark

      def initialize(mark)
        @mark = mark
        @opponent_mark = (["X", "O"] - [mark]).first
        @cache = TicTacToe::Core::NegamaxCache.new 
        @depth = 11
      end

      def human?
        false
      end

      def can_make_move?(_, _)
        true
      end

      def make_move(board, _index)
        move = get_next_move(board)
        board.move!(move, self.mark)
      end

      def get_next_move(board)
        return board.valid_moves.sample if board.valid_moves.length > 11
        best_score = -Float::INFINITY
        best_index = nil
        players = [@mark, @opponent_mark] 

        board.valid_moves.shuffle.each do |index|
          score = -negamax(board.move(index, mark), players.rotate, -Float::INFINITY, Float::INFINITY)
          best_score, best_index = score, index if score > best_score
        end

        return best_index
      end

     private

     NegamaxGameState = Struct.new(:board, :alpha, :beta, :depth, :score)

     def negamax(board, players, alpha, beta, depth=@depth)
       return get_score(board, players.first) if board.game_over? 

       alpha_orig = alpha
       game_state = NegamaxGameState.new(board, alpha, beta, depth, 0)

       if score = @cache.lookup(game_state)
         return score
       end

       best_score = -Float::INFINITY
       board.valid_moves.each do |index|
         new_board = board.move(index, players.first)
         score = -negamax(new_board, players.rotate, -game_state.beta, -game_state.alpha) 
         best_score = [best_score,score].max
         game_state.alpha = [best_score, game_state.alpha].max
         break if game_state.alpha >= game_state.beta
       end

       game_state.alpha = alpha_orig
       game_state.score = best_score
       @cache.insert(game_state)

       return best_score 
     end

     def get_score(board, mark)
       return 0 if board.draw?
       return 1 if board.winner == mark 
       -1
     end
    end
  end
end
