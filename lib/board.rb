class Board

    attr_reader :board

    def initialize
        @board = [[" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "]]
    end

    def show
        puts <<-HEREDOC

        |#{board[0][0]}|#{board[0][1]}|#{board[0][2]}|#{board[0][3]}|#{board[0][4]}|#{board[0][5]}|#{board[0][6]}|
        |#{board[1][0]}|#{board[1][1]}|#{board[1][2]}|#{board[1][3]}|#{board[1][4]}|#{board[1][5]}|#{board[1][6]}|
        |#{board[2][0]}|#{board[2][1]}|#{board[2][2]}|#{board[2][3]}|#{board[2][4]}|#{board[2][5]}|#{board[2][6]}|
        |#{board[3][0]}|#{board[3][1]}|#{board[3][2]}|#{board[3][3]}|#{board[3][4]}|#{board[3][5]}|#{board[3][6]}|
        |#{board[4][0]}|#{board[4][1]}|#{board[4][2]}|#{board[4][3]}|#{board[4][4]}|#{board[4][5]}|#{board[4][6]}|
        |#{board[5][0]}|#{board[5][1]}|#{board[5][2]}|#{board[5][3]}|#{board[5][4]}|#{board[5][5]}|#{board[5][6]}|

        HEREDOC
    end

    def update(move, symbol)
        board[move[0]][move[1]] = symbol
    end

    def length
        board.length
    end

    # def full?
    #     not board.any? {|cell| cell.is_a?(Integer)}
    # end

    def check_winner
        cols = board[0].length
        rows = board.length

        # Check verticals
        (0...cols).each do |col|
            (0...rows - 3).each do |row|
                if board[row][col] == board[row+1][col] &&
                   board[row+1][col] == board[row+2][col] &&
                   board[row+2][col] == board[row+3][col] &&
                   board[row][col] != " "
                    return true
                end
            end
        end

        # Check horizontals
        (0...rows).each do |row|
            (0...cols - 3).each do |col|
                if board[row][col] == board[row][col+1] &&
                   board[row][col+1] == board[row][col+2] &&
                   board[row][col+2] == board[row][col+3] &&
                   board[row][col] != " "
                    return true
                end
            end
        end

        # Check diagonals (from left to right)
        (0...rows - 3).each do |row|
            (0...cols - 3).each do |col|
                if board[row][col] == board[row+1][col+1] &&
                   board[row+1][col+1] == board[row+2][col+2] &&
                   board[row+2][col+2] == board[row+3][col+3] &&
                   board[row][col] != " "
                    return true
                end
            end
        end

        # Check diagonals (from right to left)
        (0...rows - 3).each do |row|
            (3...cols).each do |col|
                if board[row][col] == board[row+1][col-1] &&
                   board[row+1][col-1] == board[row+2][col-2] &&
                   board[row+2][col-2] == board[row+3][col-3] &&
                   board[row][col] != " "
                    return true
                end
            end
        end

        return false
    end
end
