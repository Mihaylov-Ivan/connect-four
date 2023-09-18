require_relative 'display.rb'
require_relative 'player.rb'
require_relative 'board.rb'

require 'pry-byebug'

class Game
    include Display

    attr_reader :board
    attr_accessor :player1, :player2, :current_player, :game_over

    def initialize
        show_introduction
        @board = Board.new
        @game_over = false
    end

    def play
        game_setup
        board.show
        play_turns
        # show_play_again
    end

    def game_setup
        @player1 = create_player(1)
        @player2 = create_player(2, player1.symbol)
    end

    def create_player(number, otherSymbol = nil)
        player_name_prompt(number)
        name = gets.chomp
        symbol = get_symbol(name, otherSymbol)
        Player.new(name, symbol)
    end

    def get_symbol(name, otherSymbol)
        player_symbol_prompt(name, otherSymbol)
        symbol = gets.chomp
        return symbol if symbol.match?(/^[^0-9]$/) && symbol != otherSymbol

        show_input_error
        get_symbol(name, otherSymbol)
    end

    def play_turns
        current_player = player1
        until game_over do
            player_turn_prompt(current_player.name)
            move = validate_move(gets.chomp)
            board.update(move, current_player.symbol)
            board.show
            # check_game_over
            # switch_current_player
        end
    end

    def validate_move(col)
        col = check_move_input(col).to_i-1

        # binding.pry
        rows = board.length-1
        rows.downto(1) do |row|
            a=1
            return [row, col] if board.board[row][col] == " "
        end

        show_move_error
        validate_move(gets.chomp)
    end

    def check_move_input(move)
        return move if move.match?(/[1-7]/)

        show_input_error
        check_move_input(gets.chomp)
    end

    def switch_current_player
        @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
    end

    def check_game_over
        if @board.check_winner
            @game_over = true
            return show_winner(@current_player.name, @current_player.symbol)
        elsif @board.full?
            @game_over = true
            show_no_winner
        end
    end
end
