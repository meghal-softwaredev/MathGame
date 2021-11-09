require './question.rb'
require './player.rb'

class Game

    def initialize
      puts 'Please enter your name, PLAYER 1:'
      name1 = gets.chomp
      @player1 = Player.new(name1)
      puts 'Please enter your name, PLAYER 2:'
      name2 = gets.chomp
      @player2 = Player.new(name2)
    end

    def question
      question = Question.new
      @query = question.question
      @ans = question.answer
      puts "  - NEW TURN -  "
      if @player1.turn
        puts "#{@player1.name}: #{@query}"
      else
        puts "#{@player2.name}: #{@query}"
      end
    end

#check answer
    def check_answer
      if STDIN.gets.chomp.to_i == @ans
        if @player1.turn
          puts 'You are correct!'
          @player1.turn = false
          @player2.turn = true
          life
          win?
        else
          puts 'You are correct!'
          @player1.turn = true
          @player2.turn = false
          life
          win?
        end
      else
        if @player1.turn
          @player1.life -= 1
          puts "#{@player1.name}: WRONG!"
          @player1.turn = false
          @player2.turn = true
          puts "The corrent answer was #{@ans}."
          life
          win?
        else
          @player2.life -= 1
          puts "#{@player2.name}: WRONG!"
          @player1.turn = true
          @player2.turn = false
          puts "The corrent answer was #{@ans}."
          life
          win?
        end
      end
    end


#what is the life?
    def life
      sleep(1)
      puts "#{@player1.name}: #{@player1.life.to_s}/3 vs #{@player2.name}: #{@player2.life.to_s}/3"
    end

#whos turn is it?
    def turn
      question
      check_answer
    end

#is the game over yet?
    def game_over?
      @life == 3
    end

#winner?chicken dinner?
    def win?
      if @player1.life == 0
        puts ' - GAME OVER -'
        puts "#{@player1.name} wins with score of #{@player2.life.to_s}/3"
        puts 'GOOD BYE!'
      elsif @player2.life == 0
        puts ' - GAME OVER -'
        puts "#{@player1.name} wins with score of #{@player1.life.to_s}/3"
        puts 'GOOD BYE!'
      else
        turn
      end
    end

end #end of class
