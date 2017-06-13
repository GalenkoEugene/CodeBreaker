require 'yaml/store'

module Codebreaker
  # CodeBreaker Game
  class Game
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
      raise ArgumentError, 'Allow digit 1..6' if user_input.to_s !~ /^[1-6]{4}$/
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
      @aid = [@user_option, @secret_code].transpose.reject do |pair|
        @result << '+' if pair.uniq.one?
      end
    end

    def implicit_matches
      @aid.each { |pair| @result << '-' if @aid.assoc(pair.last)&[0].clear }
      @result
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
