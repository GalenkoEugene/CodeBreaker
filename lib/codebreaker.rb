require "codebreaker/version"

module Codebreaker
  # CodeBreaker Game
  class Game

    def initialize
      @secret_code = false
    end

    def start
      generate_secret_code
    end

    def compare_with(user_option)

    end

    private

    def generate_secret_code
      code = []
      4.times { code << rand(1..6) }
      @secret_code = code.join
    end
  end
end
