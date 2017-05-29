# frozen_string_literal: true

module UI
  # Console User Interface
  class UI
    WIDTH = 47
    class << self
      def name
        puts ' Enter a player name: '
        name = gets.chomp
        puts "\nHello #{name}!"
        name
      end

      def won(name, attempt)
        puts name
        puts ' You won! '.center(WIDTH, '=')
        puts "From the #{Codebreaker::Game::ATTEMPTS - attempt} attempt.."
      end

      def lost
        puts ' Game Over '.center(WIDTH, '=')
        puts "Unfortunately you lost..\n"
      end

      def repeat_game?
        puts 'Do you want to repeat the game? [y/yes/Enter]'
        yes?
      end

      def capture_guess(game)
        puts "(#{game.attempts}/#{Codebreaker::Game::ATTEMPTS}) " \
          'Type 4 digits from 1 to 6'
        gets.chomp
      end

      def help
        puts ' About Game '.center(WIDTH, '=')
        rows = [
          'Codebreaker is a logic game', 'in which "you"',
          'try to break a secret code', 'created by a code-maker "game".',
          'If you need help, type:', '[h/hint/help]', 'Good luck'
        ]
        rows.each { |row| puts row.center(WIDTH) }
        puts ' About Game '.center(WIDTH, '=')
      end

      def save?
        puts 'Save your score? [y/yes/Enter]'
        yes?
      end

      def start
        puts "\nNew game was started..."
        puts 'Secret code successfully generated!'
      end

      def bye
        puts ' Goodbye '.center(WIDTH)
        puts ' CodeBreaker '.center(WIDTH, '=')
      end

      def show(scores)
        puts 'Results:'.center(WIDTH)
        format = '%-3s %-14s %-8s %-20s'
        puts format % ['#', 'User:', 'Score:', 'Date and Time:']
        scores.each_with_index do |player, i|
          puts format % [i + 1, player.name, player.score, player.time]
        end
      end

      private

      def yes?
        return true if ['', 'y', 'yes'].include?(gets.chomp)
        false
      end
    end
  end
end
