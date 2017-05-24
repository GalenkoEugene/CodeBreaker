require "codebreaker/version"

module Codebreaker
  # CodeBreaker Game
  class Game
    attr_reader :attempt, :user_option

    def initialize
      @secret_code, @user_option = false, false
      @attempt = 10
    end

    def start
      generate_secret_code
    end

    def compare_with(user_option)
      @user_option = user_option
      raise ArgumentError, 'Allow digits 1..6' if user_option !~ /^[1-6]{4}$/
      @attempt-=1
      expliсit_matches
    end

    private

    def generate_secret_code
      code = []
      4.times { code << rand(1..6) }
      @secret_code = code.join
    end

    def expliсit_matches

    end
  end
end
