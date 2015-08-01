
Choices = %w(rock paper scissors)

class GameSession 

    def initialize(computerScore, userScore)
        @computerScore = 0
        @userScore = 0
    end 

    def user_wins()
        @userScore += 1
    end 

    def computer_wins()
        @computerScore += 1
    end 

    def menu_message
    <<-EOS
    Welcome to Rock, Paper, Scissors!
    Please choose gameplay mode:
    -- Type '1' to play BEST OF THREE.
    -- Type '2' to play BEST OF FIVE.
    -- Type '3' to play BEST OF TEN.
    -- Type '4' to play UNLIMITED.
    -- Type '5' to play SUDDEN DEATH!
    -- Type 'EXIT' to leave the game.
    EOS
    end

    def menu
        puts self.menu_message

        case self.user_input_text
        when "1"
            self.best_of_three
        when "2"
            self.best_of_five
        when "3"
            self.best_of_ten
        when "4"
            self.unlimited_play
        when "5"
            self.sudden_death
        when "exit"
            puts "Thank you for playing! Have a nice day."
            exit
        else
            puts "Sorry, I didn't understand you. Please re-enter your input."
            self.menu_message
        end

        self.new_game
    end 

    def users_play
        begin
        puts "Which do you play? ROCK, PAPER, or SCISSORS?"
        user_play = user_input_text
        end until Choices.include?(user_play) 
        puts "You play #{user_play}."

        computer_play = rand(1..3)
        case computer_play
        when 1
            puts "Computer plays rock."
            if user_play == "rock" && computer_play == 1 
                puts "The result is a tie."
            elsif user_play == "paper" && computer_play == 1 
                puts "You win!"
                self.user_wins
            else user_play == "scissors" && computer_play == 1  
                puts "You lose!"
                self.computer_wins
            end

        when 2
            puts "Computer plays paper."
            if user_play == "rock" && computer_play == 2 
                puts "You lose!"
                self.computer_wins
            elsif user_play == "paper" && computer_play == 2 
                puts "The result is a tie."
            else user_play == "scissors" && computer_play == 2 
                puts "You win!"
                self.user_wins
            end

        when 3
            puts "Computer plays scissors."
            if user_play == "rock" && computer_play == 3 
                puts "You win!"
                self.user_wins  
            elsif user_play == "paper" && computer_play == 3 
                puts "You lose!"
                self.computer_wins
            else user_play == "scissors" && computer_play == 3 
                puts "The result is a tie."
            end        
        end
        self.scoreboard 
    end 

    def best_of_three
        loop do
            puts users_play
            break if @userScore >= 2 || @computerScore >= 2
        end
        self.best_of_three_winner
        self.new_game 
    end
    
    def best_of_five
        loop do
            puts users_play
            break if @userScore >= 3 || @computerScore >= 3
        end
        self.best_of_five_winner
        self.new_game 
    end
        
    def best_of_ten
        loop do
            puts users_play
            break if @userScore >= 6 || @computerScore >= 6
        end
        self.best_of_ten_winner
        self.new_game
    end

    def unlimited_play
        loop do
        puts users_play
        puts "Press RETURN to continue gameplay. Type 'EXIT' to end gameplay."
           break if self.unlimited_exit
        end
    end

    def sudden_death
        puts users_play
        puts sudden_death_winner
    end

    def user_input_text()
        gets.chomp.downcase
    end 

    def best_of_three_winner
        if @userScore >= 2
            puts "You won the game!"
        else @computerScore >= 2
            puts "You lose the game!"
        end
        @userScore = 0
        @computerScore = 0
    end 

    def best_of_five_winner
        if @userScore >= 3
            puts "You won the game!"
        else @computerScore >= 3
            puts "You lose the game!"
        end
        @userScore = 0
        @computerScore = 0
    end

    def best_of_ten_winner
        if @userScore >= 6
            puts "You won the game!"
        else @computerScore >= 6
            puts "You lose the game!"
        end
        @userScore = 0
        @computerScore = 0
    end

    def unlimited_winner
        if @userScore > @computerScore
            puts "You won the game!"
        elsif @userScore < @computerScore
            puts "You lose the game!"
        else 
            puts "The game is a draw."
        end
        @userScore = 0
        @computerScore = 0
    end

    def sudden_death_winner
        if @userScore > @computerScore
            puts "You won the game!"
        elsif @userScore < @computerScore
            puts "You lose the game!"
        else 
            puts "The game is a draw."
        end
        @userScore = 0
        @computerScore = 0
    end

    def new_game
        puts "Play again? YES or NO."

        case user_input_text
        when 'yes'
            self.start
        when 'no'
            puts "Thank you for playing! Have a nice day."
            exit
        end
    end  

    def unlimited_exit
        if user_input_text == "exit"
        self.scoreboard
        puts self.unlimited_winner
        self.new_game
        end
    end  

    def scoreboard
        computerScore = @computerScore 
        userScore = @userScore

        puts "Your score is: #{@userScore}. Computer score is: #{@computerScore}."
    end 

    def start
        puts self.menu
    end 
end

new_game_session = GameSession.new(0, 0)
new_game_session.start


