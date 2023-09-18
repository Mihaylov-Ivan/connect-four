module Display
  def show_introduction
    puts "
    Welcome to Connect Four!
    The first player to get 4 of their pieces consecutively in a row, column, or along a diagonal is going to win the game.
    Each player can drop one piece at a time from the top of the cage, taking turns.

    Each player will have to choose a column from 1 to 7 to drop a piece in.
    "
  end
end

def player_name_prompt(number)
  puts "
  Player #{number}, what is your name?
  "
end

def player_symbol_prompt(name, otherSymbol)
  puts "#{name}, what is you symbol? (a single symbol or letter)"
  puts "Make sure it is not #{otherSymbol}" if otherSymbol
end

def show_input_error
  puts "\e[31mSorry, that is an invalid input. Please, try again.\e[0m"
end

def player_turn_prompt(name)
  puts "#{name}, make a move! Select column 1 to 7."
end

def show_move_error
  puts "\e[31mSorry, that is an invalid move. Please, select a free slot.\e[0m"
end

def show_winner(name, symbol)
  puts "Congratulations #{name} (#{symbol})! You are the winner!"
end

def show_no_winner
    puts "Game Over! No winner."
end
