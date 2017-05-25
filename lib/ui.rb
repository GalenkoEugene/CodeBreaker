# frozen_string_literal: true

module UI
  # Console User Interface
  class UI
    class << self
      def name
        puts ' Enter a player name: '
        name = gets.chomp
        puts "\nHello #{name}!"
        name
      end

      def won(name, counter)
        puts name
        puts '-- You won! --'
        puts "From the #{counter} attempts.."
      end

      def lost
        puts '-- Game Over --'
        puts "Unfortunately you lost..\n"
      end

      def repeat_game?
        puts 'Do you want to repeat the game?'
        puts "Please type 'yes' or just click 'Enter' "\
             'if you want to start a new game, otherwise type something else:'
        return true if ['', 'y', 'yes'].include?(gets.chomp)
        false
      end

      def capture_guess
        puts " Enter your option, it must be\n four digits from 1 to 6"
        gets.chomp
      end

      def help
        width = 33
        puts ' About Game '.center(width, '=')
        puts 'Codebreaker is a logic game'.center(width)
        puts 'in which a code-breaker is "you"'.center(width)
        puts 'tries to break a secret code'.center(width)
        puts 'created by a code-maker "game".'.center(width)
        puts 'If you need help, type:'.center(width)
        puts '`hint`, `help` or just `h`'.center(width)
        puts 'Good luck'.center(width)
        puts ' About Game '.center(width, '=')
      end

      def save?
        puts 'Save your score?'
        return true if ['', 'y', 'yes'].include?(gets.chomp)
        false
      end
    end
  end
end
