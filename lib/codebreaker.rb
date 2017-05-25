require 'codebreaker/version'

module Codebreaker
  # CodeBreaker Game
  class Game
    attr_reader :attempts
    ATTEMPTS = 10

    def initialize
      @secret_code = []
      @dup_secret = []
    end

    def start
      generate_secret_code
      @attempts = ATTEMPTS
    end

    def compare_with(user_input)
      raise ArgumentError, 'Allow digit 1..6' if user_input.to_s !~ /^[1-6]{4}$/
      @user_option = user_input.to_s.chars
      @attempts -= 1
      explicit_matches
      implicit_matches
    end

    private

    def generate_secret_code
      @secret_code.clear
      4.times { @secret_code << rand(1..6).to_s }
    end

    def explicit_matches
      @dup_secret = @secret_code.dup
      @dup_secret.zip(@user_option).each_with_index do |pair, index|
        next if pair.uniq[1]
        @user_option[index] = '+'
        @dup_secret[index] = '+'
      end
    end

    def implicit_matches
      @dup_secret.each_index do |dup_s|
        next if @dup_secret[dup_s] == '+'
        @user_option.each_index do |user_o|
          next if @user_option[user_o] != @dup_secret[dup_s]
          (@user_option[user_o] = '-') && break
        end
      end
      @user_option.sort.join.gsub(/\w+/, '')
    end
  end
end
