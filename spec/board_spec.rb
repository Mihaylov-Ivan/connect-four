require_relative '../lib/board.rb'
require 'rspec'

describe Board do
  subject(:board) { Board.new }

  describe '#check_winner' do
    context 'when there is no winner' do
      it 'returns false by default' do
        expect(board.check_winner).to eq(false)
      end

      it 'returns false when no horizontal connection' do
        board.board[0][0] = "X"
        board.board[0][1] = "X"
        board.board[0][2] = "X"
        board.board[0][4] = "X"

        expect(board.check_winner).to eq(false)
      end

      it 'returns false when no vertical connection' do
        board.board[1][1] = "X"
        board.board[2][1] = "X"
        board.board[3][1] = "X"
        board.board[4][1] = "x"

        expect(board.check_winner).to eq(false)
      end

      it 'returns false when no diagonal connection' do
        board.board[0][0] = "X"
        board.board[1][1] = "X"
        board.board[2][1] = "X"
        board.board[3][3] = "X"

        expect(board.check_winner).to eq(false)
      end
    end

    context 'when there is a horizontal winner' do
      it 'returns true' do
        board.board[0][0] = "X"
        board.board[0][1] = "X"
        board.board[0][2] = "X"
        board.board[0][3] = "X"

        expect(board.check_winner).to eq(true)
      end

      it 'returns true' do
        board.board[3][2] = "X"
        board.board[3][3] = "X"
        board.board[3][4] = "X"
        board.board[3][5] = "X"

        expect(board.check_winner).to eq(true)
      end
    end

    context 'when there is a vertical winner' do
        it 'returns true' do
          board.board[1][1] = "X"
          board.board[2][1] = "X"
          board.board[3][1] = "X"
          board.board[4][1] = "X"
  
          expect(board.check_winner).to eq(true)
        end

        it 'returns true' do
            board.board[2][4] = "X"
            board.board[3][4] = "X"
            board.board[4][4] = "X"
            board.board[5][4] = "X"
    
            expect(board.check_winner).to eq(true)
          end
    end

    context 'when there is a diagonal winner' do
        it 'returns true' do
          board.board[0][0] = "X"
          board.board[1][1] = "X"
          board.board[2][2] = "X"
          board.board[3][3] = "X"
  
          expect(board.check_winner).to eq(true)
        end

        it 'returns true' do
            board.board[2][2] = "X"
            board.board[3][3] = "X"
            board.board[4][4] = "X"
            board.board[5][5] = "X"
    
            expect(board.check_winner).to eq(true)
          end
    end
  end
end
