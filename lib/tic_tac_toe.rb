class TicTacToe

    WIN_COMBINATIONS= [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def initialize(board= Array.new(9," "))
        @board= board
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index, token)
        @board[index] = token
    end

    def position_taken?(index)
        if @board[index] == "X" || @board[index] == "O"
            true
        else
            false
        end
    end

    def valid_move?(index)
        if index.between?(0,8) && !position_taken?(index)
            true
        else
            false
        end
    end

    def turn_count
        @board.count{ |turn| turn != " " }
    end

    def current_player
        if turn_count.even?
            return "X"
        else
            return "O"
        end
    end

    def turn
        puts "Please select a square (1-9):"
        #get user input
        input = gets.strip
        # since all user input comes in as a string from terminal, convert to integer and subtract 1
        index = input_to_index(input)
        # Check to see if it's a valid move
        # if so, let them make a move
        if valid_move?(index)
            token = current_player
            move(index, token)
            display_board
        # if not, ask them to choose again
        else
            puts "Please select a valid answer (1-9)"
            turn
        end
    end


    def won?
        winning= []
        # check to see if the first position in the winning combination is taken
        # then check to see if the first position matches the second, and if the second position matches the third
        # return the combination if all conditions are met
        WIN_COMBINATIONS.any? do | winning |
            if  position_taken?(winning[0]) && @board[winning[0]] == @board[winning[1]] && @board[winning[1]] == @board[winning[2]]
                return winning
            end
        end
    end

    def full?
        @board.all? do |index|
            index == "X" || index == "O"
        end
    end

    def draw?
        won? == false && full? == true
    end

    def over?
        if won? || draw? || full?
            true
        else
            false
        end
    end

    def winner
        win_char = nil
        if won?.class == Array
            win_char = @board[won?[0]]
        end
    end

    def play
        until over? == true
            turn
            play
        end
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end

