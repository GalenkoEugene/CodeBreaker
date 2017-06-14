require 'yaml/store'
require_relative 'validator'

module Codebreaker
  # CodeBreaker Game
  class Game
    include Validator

    attr_reader :attempts
    ATTEMPTS = 10
    PATH_TO_DATA = './data.yaml'.freeze
    NST = Struct.new(:name, :score, :time)

    def initialize
      @secret_code = []
      @result = ''
      @aid = []
    end

    def start(reps = ATTEMPTS)
      generate_secret_code
      @attempts = reps.to_i
    end

    def compare_with(user_input)
      raise ArgumentError unless valid?(user_input.to_s)
      @user_option = user_input.to_s.chars
      @attempts -= 1
      explicit_matches
      implicit_matches
    end

    def hint
      @secret_code[rand(0..3)]
    end

    def save(name = 'No name')
      raise 'Game is unfinished' if chance?
      @data = load_file
      @data ? @data << form_data(name) : @data = [form_data(name)]
      File.open(PATH_TO_DATA, 'w') { |file| file.write(@data.to_yaml) }
    end

    def score
      load_file.sort_by(&:score).reverse
    end

    private

    def generate_secret_code
      @secret_code.clear
      4.times { @secret_code << rand(1..6).to_s }
    end

    def explicit_matches
      @result.clear
      @aid = @secret_code.zip(@user_option).reject do |pair|
        @result += '+' if pair.uniq.one?
      end.transpose
    end

    def implicit_matches
      return @result if @result == '++++'
      @aid.first.each do |item|
        @aid[1].delete_at(@aid[1].index(item)) if @aid[1].include?(item)
      end
      @result += ('-' * (@aid[0].size - @aid[1].size))
    end

    def chance?
      @result != '++++' && @attempts.positive?
    end

    def form_data(name)
      score = @attempts
      NST.new(name, score, Time.now.strftime('%F %T'))
    end

    def load_file
      YAML.load_file(PATH_TO_DATA) if File.exist?(PATH_TO_DATA)
    end
  end
end
