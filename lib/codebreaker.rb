# frozen_string_literal: true

require_relative 'codebreaker/version'
require 'yaml/store'
module Codebreaker
  # CodeBreaker Game
  class Game
    attr_reader :attempts
    ATTEMPTS = 10
    PATH_TO_DATA = './data.yaml'
    NST = Struct.new(:name, :score, :time)

    def initialize
      @secret_code = []
      @dup_secret = []
      @result = ''
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
      @dup_secret = @secret_code.dup
      @dup_secret.zip(@user_option).each_with_index do |pair, index|
        next if pair.uniq[1]
        @user_option[index], @dup_secret[index] = '+', '+'
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
      @result = @user_option.sort.join.gsub(/\w+/, '')
    end

    def chance?
      @result != '++++' && @attempts.positive?
    end

    def form_data(name)
      score = generate_score.to_i
      NST.new(name, score, Time.now.strftime('%F %T'))
    end

    def generate_score
      return 0 if @result != '++++' && @attempts.zero?
      %w[21 34 55 89 144 233 377 610 987 1597].at @attempts
    end

    def load_file
      YAML.load_file(PATH_TO_DATA) if File.exist?(PATH_TO_DATA)
    end
  end
end
