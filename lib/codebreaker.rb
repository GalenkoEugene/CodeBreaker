require "codebreaker/version"

module Codebreaker
  # CodeBreaker Game
  class Game
    attr_reader :attempt, :user_option

    def initialize
      @secret_code = []
      @user_option = false
      @attempt = 10
    end

    def start
      generate_secret_code
    end

    def compare_with(user_option)
      @user_option = user_option.chars
      raise ArgumentError, 'Allow digits 1..6' if user_option !~ /^[1-6]{4}$/
      @attempt-=1
      expliсit_matches
    end

    private

    def generate_secret_code
      @secret_code.clear
      4.times { @secret_code << rand(1..6).to_s }
    end

    def expliсit_matches

    end
  end
end
