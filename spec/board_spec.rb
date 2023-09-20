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

  describe '#update' do
    context 'when one player makes a move' do
      move = [1, 1]
      symbol = "A"

      it "updates the board with the move" do
        board.update(move, symbol)
        expect(board.board[move[0]][move[1]]).to eq(symbol)
      end
    end

    context 'when both players make 2 moves each' do
      move1 = [1, 1]
      move2 = [2, 1]
      move3 = [1, 3]
      move4 = [3, 1]
      symbol1 = "A"
      symbol2 = "B"

      it "updates the board with the 4 moves" do
        board.update(move1, symbol1)
        board.update(move2, symbol2)
        board.update(move3, symbol1)
        board.update(move4, symbol2)
        expect(board.board[move1[0]][move1[1]]).to eq(symbol1)
        expect(board.board[move2[0]][move2[1]]).to eq(symbol2)
        expect(board.board[move3[0]][move3[1]]).to eq(symbol1)
        expect(board.board[move4[0]][move4[1]]).to eq(symbol2)
      end
    end
  end

  describe '#full?' do
    move = [1, 1]
    symbol = "A"

    context 'when board is full' do
      before do
        board.board.each { |sub_array| sub_array.map! { |item| "A" } }
      end

      it "returns true" do
        expect(board.full?).to be true
      end
    end

    context 'when board not full' do
      before do
        board.board.each { |sub_array| sub_array.map! { |item| "A" } }
        board.board[0][0] = " "
      end

      it "returns false" do
        expect(board.full?).to be false
      end
    end
  end
end
