require 'spec_helper'
require_relative 'cases_data'

# Test caomparison algorithm
module Codebreaker
  RSpec.describe Game do
    subject(:game) { Game.new }

    describe 'compare_with' do
      data = Codebreaker.data

      data.size.times do |index|
        it "#{data[index][0]} && #{data[index][1]} => '#{data[index].last}'" do
          game.instance_variable_set(:@attempts, 10)
          game.instance_variable_set(:@secret_code, data[index][0].chars)
          expect(game.compare_with(data[index][1])).to eq(data[index].last)
        end
      end
    end
  end
end
