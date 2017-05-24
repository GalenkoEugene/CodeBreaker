require "codebreaker/version"

module Codebreaker
  # CodeBreaker Game
  class Game
    attr_reader :attempt, :user_option

    def initialize
      @secret_code, @mutable_secret = [], []
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
      implicit_matches
    end

    private

    def generate_secret_code
      @secret_code.clear
      4.times { @secret_code << rand(1..6).to_s }
    end

    def expliсit_matches
      @mutable_secret = @secret_code.dup
      @mutable_secret.zip(@user_option).each_with_index do |pair, index|
        next if pair.uniq[1]
        @user_option[index] = '+'
        @mutable_secret[index] = '+'
      end
    end

    def implicit_matches
      @mutable_secret.each_index do |secret_i|
        @user_option.each_index do |user_i|
          next unless @user_option[user_i] == @mutable_secret[secret_i] &&
                                              @user_option[user_i] != '+'
          @user_option[user_i] = '-'
        end
      end
      @user_option.sort.join.gsub(/\b+/, '')
    end
  end
end
