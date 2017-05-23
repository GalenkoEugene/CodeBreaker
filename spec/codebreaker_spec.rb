require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }

    describe '.start' do
      it 'has instance variable @secret_code' do
        expect(game.instance_variable_get(:@secret_code)).not_to be nil
      end

      it 'generate secret_code' do
        game.start
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'call generate_secret_code' do
        expect(game).to receive(:generate_secret_code)
        game.start
      end
    end

    describe '.generate_secret_code' do
      before { game.send(:generate_secret_code) }
      it 'has size == 4' do
        expect(game.instance_variable_get(:@secret_code).size).to eq 4
      end

      it 'contain digits from 1..6' do
        expect(game.instance_variable_get(:@secret_code)).to match /[1-6]{4}/
      end
    end

    describe '.compare_with' do
      it 'is' do
        expect(game).to respond_to(:compare_with)
      end

      it 'compare user_input with secret_code'
      it 'replies according to the marking algorithm'
    end
  end
end
